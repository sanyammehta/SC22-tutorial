#include "eam.h"

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#ifdef _OPENMP
#include <omp.h>
#endif

#include "constants.h"
#include "memUtils.h"
#include "parallel.h"
#include "linkCells.h"
#include "CoMDTypes.h"
#include "performanceTimers.h"
#include "haloExchange.h"


typedef long int li64b_t;


typedef struct InterpolationObjectSt 
{
   int n;          //!< the number of values in the table
   real_t x0;      //!< the starting ordinate range
   real_t invDx;   //!< the inverse of the table spacing
   real_t* values; //!< the abscissa values
} InterpolationObject;


typedef struct EamPotentialSt 
{
   real_t cutoff;             //!< potential cutoff distance in Angstroms
   real_t mass;               //!< mass of atoms in intenal units
   real_t lat;                //!< lattice spacing (angs) of unit cell
   char latticeType[8];       //!< lattice type, e.g. FCC, BCC, etc.
   char  name[3];	      //!< element name
   int	 atomicNo;	      //!< atomic number  
   int  (*force)(SimFlat* s); //!< function pointer to force routine
   void (*print)(FILE* file, BasePotential* pot);
   void (*destroy)(BasePotential** pot); //!< destruction of the potential
   InterpolationObject* phi;  //!< Pair energy
   InterpolationObject* rho;  //!< Electron Density
   InterpolationObject* f;    //!< Embedding Energy

   real_t* rhobar;            //!< per atom storage for rhobar
   real_t* dfEmbed;           //!< per atom storage for derivative of Embedding
   HaloExchange* forceExchange;
   ForceExchangeData* forceExchangeData;
} EamPotential;

void get_bounds(int in_nlo, int in_nhi, int *nlo, int *nhi)
{
  int num_threads,my_thread_id;

#ifdef _OPENMP
  my_thread_id = omp_get_thread_num();
  num_threads  = omp_get_num_threads();
  *nlo = in_nlo+((in_nhi-in_nlo+1)/num_threads+1)*(my_thread_id);
  *nhi = fmin(in_nhi,*nlo+(in_nhi-in_nlo+1)/num_threads);
#else
  *nlo = in_nlo;
  *nhi = in_nhi;
#endif
}


/// Interpolate a table to determine f(r) and its derivative f'(r).
///
/// The forces on the particle are much more sensitive to the derivative
/// of the potential than on the potential itself.  It is therefore
/// absolutely essential that the interpolated derivatives are smooth
/// and continuous.  This function uses simple quadratic interpolation
/// to find f(r).  Since quadric interpolants don't have smooth
/// derivatives, f'(r) is computed using a 4 point finite difference
/// stencil.
///
/// Interpolation is used heavily by the EAM force routine so this
/// function is a potential performance hot spot.  Feel free to
/// reimplement this function (and initInterpolationObject if necessay)
/// with any higher performing implementation of interpolation, as long
/// as the alternate implmentation that has the required smoothness
/// properties.  Cubic splines are one common alternate choice.
///
/// \param [in] table Interpolation table.
/// \param [in] r Point where function value is needed.
/// \param [out] f The interpolated value of f(r).
/// \param [out] df The interpolated value of df(r)/dr.
void interpolate(InterpolationObject* table, real_t r, real_t* f, real_t* df)
{
   const real_t* tt = table->values; // alias
   
   if ( r < table->x0 ) r = table->x0;

   r = (r-table->x0)*(table->invDx) ;
   
   
   //long ii = (long)floor(r);
   long ii = (long)(r);
   if (ii > table->n)
   {
      ii = table->n;
      r = table->n / table->invDx;
   }
   // reset r to fractional distance
   long tmp = (long)(r);
   r = r - tmp;

   real_t g1 = tt[ii+1] - tt[ii-1];
   real_t g2 = tt[ii+2] - tt[ii];

   *f = tt[ii] + 0.5*r*(g1 + r*(tt[ii+1] + tt[ii-1] - 2.0*tt[ii]) );

   *df = 0.5*(g1 + r*(g2-g1))*table->invDx;
}


/// Calculate potential energy and forces for the EAM potential.
///
/// Three steps are required:
///
///   -# Loop over all atoms and their neighbors, compute the two-body
///   interaction and the electron density at each atom
///   -# Loop over all atoms, compute the embedding energy and its
///   derivative for each atom
///   -# Loop over all atoms and their neighbors, compute the embedding
///   energy contribution to the force and add to the two-body force
/// 
int eamForce_kernel(SimFlat* s)
{
   EamPotential* pot = (EamPotential*) s->pot;
   assert(pot);

   // set up halo exchange and internal storage on first call to forces.
   if (pot->forceExchange == NULL)
   {
      long maxTotalAtoms = MAXATOMS*s->boxes->nTotalBoxes;
      pot->dfEmbed = comdMalloc(maxTotalAtoms*sizeof(real_t));
      pot->rhobar  = comdMalloc(maxTotalAtoms*sizeof(real_t));
      pot->forceExchange = initForceHaloExchange(s->domain, s->boxes);
      pot->forceExchangeData = comdMalloc(sizeof(ForceExchangeData));
      pot->forceExchangeData->dfEmbed = pot->dfEmbed;
      pot->forceExchangeData->boxes = s->boxes;
   }
   
   real_t rCut2 = pot->cutoff*pot->cutoff;
   real_t etot = 0.;

   // zero forces / energy / rho /rhoprime
   long fsize = s->boxes->nTotalBoxes*MAXATOMS;
   long nNbrBoxes = 27;

#pragma omp parallel
{
    long num_t = omp_get_num_threads();
    long chunk_size = ceil(fsize/num_t);
    long t_id = omp_get_thread_num();

   #pragma omp for schedule(static, chunk_size)
   for (long ii=0; ii<fsize; ii++)
   {
      zeroReal3(s->atoms->f[ii]);
      s->atoms->U[ii] = 0.;
      pot->dfEmbed[ii] = 0.;
      pot->rhobar[ii] = 0.;
   }

    chunk_size = ceil(s->boxes->nLocalBoxes/num_t);

   // loop over local boxes
   #pragma omp for reduction(+:etot) schedule(static,chunk_size)
   for (long iBox=0; iBox<s->boxes->nLocalBoxes; iBox++)
   {
      long nIBox = s->boxes->nAtoms[iBox];


      // loop over neighbor boxes of iBox (some may be halo boxes)
      for (long jTmp=0; jTmp<nNbrBoxes; jTmp++)
      {
         long jBox = s->boxes->nbrBoxes[iBox][jTmp];
         long nJBox = s->boxes->nAtoms[jBox];
//printf("nIBox = %d, nJBox = %d\n",nIBox,nJBox);

#pragma _CRI prefervector
#pragma _CRI concurrent
#pragma simd
         // loop over atoms in iBox
         for (long iOff=MAXATOMS*iBox; iOff<(iBox*MAXATOMS+nIBox); iOff++)
         {
            // loop over atoms in jBox
            for (long jOff=MAXATOMS*jBox; jOff<(jBox*MAXATOMS+nJBox); jOff++)
            {

	      real_t dr0,dr1,dr2;
               real_t r2 = 0.0;
                  dr0=s->atoms->r[iOff][0]-s->atoms->r[jOff][0];
                  r2+=dr0*dr0;
                  dr1=s->atoms->r[iOff][1]-s->atoms->r[jOff][1];
                  r2+=dr1*dr1;
                  dr2=s->atoms->r[iOff][2]-s->atoms->r[jOff][2];
                  r2+=dr2*dr2;

               if(r2 <= rCut2 && r2 > 0.0)
               {

                  real_t r = sqrt(r2);
                  real_t r1 = r;
                  real_t r0 = r;
                  real_t phiTmp, dPhi, rhoTmp, dRho;

   
   if ( r < pot->phi->x0 ) r = pot->phi->x0;

   r = (r-pot->phi->x0)*(pot->phi->invDx) ;
   //long ii = (long)floor(r);
   long ii = (long)(r);
   if (ii > pot->phi->n)
   {
      ii = pot->phi->n;
      r = pot->phi->n / pot->phi->invDx;
   }
   // reset r to fractional distance
   long tmp = (long)(r);
   r = r - tmp;

   real_t g1 = pot->phi->values[ii+1] - pot->phi->values[ii-1];
   real_t g2 = pot->phi->values[ii+2] - pot->phi->values[ii];

   phiTmp = pot->phi->values[ii] + 0.5*r*(g1 + r*(pot->phi->values[ii+1] + pot->phi->values[ii-1] - 2.0*pot->phi->values[ii]) );

   dPhi = 0.5*(g1 + r*(g2-g1))*pot->phi->invDx;
   
   if ( r1 < pot->rho->x0 ) r1 = pot->rho->x0;

   r1 = (r1-pot->rho->x0)*(pot->rho->invDx) ;
   ii = (long)(r1);
   if (ii > pot->rho->n)
   {
      ii = pot->rho->n;
      r1 = pot->rho->n / pot->rho->invDx;
   }
   // reset r to fractional distance
   long tmp2 = (long)(r1);
   r1 = r1 - tmp2;


   g1 = pot->rho->values[ii+1] - pot->rho->values[ii-1];
   g2 = pot->rho->values[ii+2] - pot->rho->values[ii];

   rhoTmp = pot->rho->values[ii] + 0.5*r1*(g1 + r1*(pot->rho->values[ii+1] + pot->rho->values[ii-1] - 2.0*pot->rho->values[ii]) );

   dRho = 0.5*(g1 + r1*(g2-g1))*pot->rho->invDx;

                     s->atoms->f[iOff][0] -= dPhi*dr0/r0;
                     s->atoms->f[iOff][1] -= dPhi*dr1/r0;
                     s->atoms->f[iOff][2] -= dPhi*dr2/r0;

                  // Calculate energy contribution
                  s->atoms->U[iOff] += 0.5*phiTmp;
                  etot += 0.5*phiTmp;

                  // accumulate rhobar for each atom
                  pot->rhobar[iOff] += rhoTmp;
               }

            } // loop over atoms in jBox
         } // loop over atoms in iBox
      } // loop over neighbor boxes
   } // loop over local boxes

   // Compute Embedding Energy
   // loop over all local boxes

   real_t              *my_rhobar  = pot->rhobar;
   InterpolationObject *my_f       = pot->f;
   real_t              *my_dfEmbed = pot->dfEmbed;
   real_t              *my_U       = s->atoms->U;

   #pragma omp for reduction(+:etot) schedule(static, chunk_size)
   for (long iBox=0; iBox<s->boxes->nLocalBoxes; iBox++)
   {
      long nIBox =  s->boxes->nAtoms[iBox];


      // loop over atoms in iBox
      #pragma _CRI prefervector
      #pragma _CRI concurrent
      #pragma simd
      for (long iOff=MAXATOMS*iBox; iOff<(MAXATOMS*iBox+nIBox); iOff++)
      {
         real_t fEmbed, dfEmbed;
         interpolate(my_f, my_rhobar[iOff], &fEmbed, &dfEmbed);
         my_dfEmbed[iOff] = dfEmbed; // save derivative for halo exchange
         my_U[iOff] += fEmbed;
         etot += fEmbed;
      }
   }
}

   // exchange derivative of the embedding energy with repsect to rhobar
   startTimer(eamHaloTimer);
   haloExchange(pot->forceExchange, pot->forceExchangeData);
   stopTimer(eamHaloTimer);

   // third pass
   // loop over local boxes

#pragma omp parallel
{
    long num_t = omp_get_num_threads();
    long chunk_size = ceil(s->boxes->nLocalBoxes/num_t);
    long t_id = omp_get_thread_num();


   #pragma omp for schedule(static,chunk_size)
   for (long iBox=0; iBox<s->boxes->nLocalBoxes; iBox++)
   {
      long nIBox = s->boxes->nAtoms[iBox];


      // loop over neighbor boxes of iBox (some may be halo boxes)
      for (long jTmp=0; jTmp<nNbrBoxes; jTmp++)
      {
         long jBox = s->boxes->nbrBoxes[iBox][jTmp];
         long nJBox = s->boxes->nAtoms[jBox];

         // loop over atoms in iBox
	 #pragma _CRI prefervector
	 #pragma _CRI concurrent
	 #pragma simd
         for (long iOff=MAXATOMS*iBox; iOff<(MAXATOMS*iBox+nIBox); iOff++)
         {
            // loop over atoms in jBox
            for (long jOff=MAXATOMS*jBox; jOff<(MAXATOMS*jBox+nJBox); jOff++)
            { 

               real_t r2 = 0.0;
	       real_t dr0,dr1,dr2;
                  dr0=s->atoms->r[iOff][0]-s->atoms->r[jOff][0];
                  r2+=dr0*dr0;
                  dr1=s->atoms->r[iOff][1]-s->atoms->r[jOff][1];
                  r2+=dr1*dr1;
                  dr2=s->atoms->r[iOff][2]-s->atoms->r[jOff][2];
                  r2+=dr2*dr2;

               if(r2 <= rCut2 && r2 > 0.0)
               {

                  real_t r = sqrt(r2);
                  real_t r0 = r;

                  real_t rhoTmp, dRho;

   
   if ( r < pot->rho->x0 ) r = pot->rho->x0;

   r = (r-pot->rho->x0)*(pot->rho->invDx) ;
   
   long ii = (long)(r);
   if (ii > pot->rho->n)
   {
      ii = pot->rho->n;
      r = pot->rho->n / pot->rho->invDx;
   }
   
   long tmp = (long)(r);
   r = r - tmp;


   real_t g1 = pot->rho->values[ii+1] - pot->rho->values[ii-1];
   real_t g2 = pot->rho->values[ii+2] - pot->rho->values[ii];

   rhoTmp = pot->rho->values[ii] + 0.5*r*(g1 + r*(pot->rho->values[ii+1] + pot->rho->values[ii-1] - 2.0*pot->rho->values[ii]) );

   dRho = 0.5*(g1 + r*(g2-g1))*pot->rho->invDx;

                     s->atoms->f[iOff][0] -= (pot->dfEmbed[iOff]+pot->dfEmbed[jOff])*dRho*dr0/r0;
                     s->atoms->f[iOff][1] -= (pot->dfEmbed[iOff]+pot->dfEmbed[jOff])*dRho*dr1/r0;
                     s->atoms->f[iOff][2] -= (pot->dfEmbed[iOff]+pot->dfEmbed[jOff])*dRho*dr2/r0;
               }

            } // loop over atoms in jBox
         } // loop over atoms in iBox
      } // loop over neighbor boxes
   } // loop over local boxes
}

   s->ePotential = (real_t) etot;

   return 0;
}

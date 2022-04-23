
//@HEADER
// ***************************************************
//
// HPCG: High Performance Conjugate Gradient Benchmark
//
// Contact:
// Michael A. Heroux ( maherou@sandia.gov)
// Jack Dongarra     (dongarra@eecs.utk.edu)
// Piotr Luszczek    (luszczek@eecs.utk.edu)
//
// ***************************************************
//@HEADER

/*!
 @file ComputeSPMV_ref.cpp

 HPCG routine
 */

#include "ComputeSPMV_ref.hpp"

#ifndef HPCG_NO_MPI
#include "ExchangeHalo.hpp"
#endif

#ifndef HPCG_NO_OPENMP
#include <omp.h>
#endif
#include <cassert>

/*!
  Routine to compute matrix vector product y = Ax where:
  Precondition: First call exchange_externals to get off-processor values of x

  This is the reference SPMV implementation.  It CANNOT be modified for the
  purposes of this benchmark.

  @param[in]  A the known system matrix
  @param[in]  x the known vector
  @param[out] y the On exit contains the result: Ax.

  @return returns 0 upon success and non-zero otherwise

  @see ComputeSPMV
*/
int ComputeSPMV_ref( const SparseMatrix & A, Vector & x, Vector & y) {

  assert(x.localLength>=A.localNumberOfColumns); // Test vector lengths
  assert(y.localLength>=A.localNumberOfRows);

#ifndef HPCG_NO_MPI
    ExchangeHalo(A,x);
#endif
  const double * const xv = x.values;
  double * const yv = y.values;
  const local_int_t nrow = A.localNumberOfRows;
  int dist = 8;
#ifndef HPCG_NO_OPENMP
  #pragma omp parallel for
#endif
  for (local_int_t i=0; i< nrow; i++)  {
    if(i==(nrow-dist)) dist = 0;
    double sum = 0.0;
    double ** Values = A.matrixValues;
    const double * const cur_vals = Values[i];
    local_int_t ** IndL = A.mtxIndL;
    const local_int_t * const cur_inds = IndL[i];
    const char * const cur_nnzs = A.nonzerosInRow;
    const int cur_nnz = cur_nnzs[i];

#pragma _CRI novector
#pragma nounroll
    for (int j=0; j< cur_nnz; j++) {
      sum += cur_vals[j]*xv[cur_inds[j]];
    }

    yv[i] = sum;

{
    #pragma prefetch (level(1)) Values[i+2*dist]
    #pragma prefetch (level(1)) IndL[i+3*dist]
    #pragma prefetch (level(1)) cur_nnzs[i+2*dist]
    const double * const cur_vals1 = Values[i+dist];
    const local_int_t* cur_inds1 = IndL[i+dist];
    const local_int_t* cur_inds2 = IndL[i+2*dist];
    const int cur_nnz1 = cur_nnzs[i+dist];
#pragma _CRI novector
#pragma unroll(8)
    for (int j=0; j< cur_nnz1; j++) {
      #pragma prefetch (level(1)) cur_vals1[j]
      #pragma prefetch (level(1)) cur_inds2[j]
      #pragma prefetch (level(1)) xv[cur_inds1[j]]
    }
    #pragma prefetch (level(1)) yv[i+dist]
}

  }

  return 0;
}

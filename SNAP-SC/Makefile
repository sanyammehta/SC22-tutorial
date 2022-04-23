#
# Build SNAP
#

#MPI_INC=-I/cray/css/mptgrp/envoy-aarch64/anl-mpich/3.1.2.1.NOSLURM/arm64/eth/mpich-cray/8.4/include #"-I/opt/cray/pe/anl-mpich/3.1.2.1.4/arm64/eth/mpich-cray/8.4/include"
#MPI_LIB=-L/cray/css/mptgrp/envoy-aarch64/anl-mpich/3.1.2.1.NOSLURM/arm64/eth/mpich-cray/8.4/lib #"-L/opt/cray/pe/anl-mpich/3.1.2.1.4/arm64/eth/mpich-cray/8.4/lib"

MPI_INC=-I/opt/cray/pe/anl-mpich/3.1.2.1.4/arm64/eth/mpich-cray/8.4/include
MPI_LIB=-L/opt/cray/pe/anl-mpich/3.1.2.1.4/arm64/eth/mpich-cray/8.4/lib


#AARCH64LIBS=-L$(CRAY_BINUTILS_ROOT_AARCH64)/aarch64-unknowun-linux-gnu
#AARCH64INC=-I $(CRAY_BINUTILS_ROOT_AARCH64)/include
#AARCH64BINUTILS=/opt/cray/pe/cce/8.5.0.2012/aarch64-binutils/bin

OPT = yes

#FFLAGS = -O2 -hlist=m -target-cpu=arm-ngva -hnopattern -static $(MPI_INC)
FFLAGS = -homp -O2 -hlist=m -hnopattern #-hnoautoprefetch -static #$(MPI_INC)
#FFLAGS = -O3 -static
#FFLAGS = -O3 -target-cpu=mic-knl -hnopattern -L/cray/css/users/jbalma/Tools/VRT/tl4s/x86 -lcraymp -lmp #-I$(MPICH_DIR)/include
#FFLAGS = -O3 -target-cpu=haswell -hnopattern -L/cray/css/users/jbalma/Tools/VRT/tl4s/x86 -lcraymp -lmp
#FFLAGS = -O3 -target-cpu=arm-ngva -hnopattern -static -homp -rm $(MPI_INC)

#FFLAGS = -O1 -target-cpu=aarch64 -hnopattern -as-needed --cray-bypass-pkgconfig -hvector3 -rm -hnoomp -static -craype-verbose -c $(AARCH64LIBS) #-h pl=my_snap_lib
#LD=# $(AARCH64BINUTILS)/aarch64-linux-gnu-ld
#LDFLAGS= -static -z nodefaultlib --exclude-libs pthread,craymp -L/opt/cray/pe/cce/8.5.0.2012/craylibs/aarch64/libf.a $(AARCH64LIBS)
LDFLAGS= -static #$(MPI_LIB) #-z nodefaultlib
#-L/cray/css/users/jbalma/Tools/VRT/tl4s/x86 -lcraymp -lmp #-I$(MPICH_DIR)/lib #-static -L/opt/cray/pe/cce/8.5.0.2012/craylibs/aarch64 -lmodules -lu -lf -lcraymp -lcsup -L.
#LDFLAGS= -static
FFLAG2 =
DEFS = 
PP=cc

MPI = yes
OPENMP = yes

#FORTRAN = /cray/css/users/scottm/builds/sve/ftn
#COMPILER = /cray/css/users/scottm/builds/sve/ftn
FORTRAN=ftn
COMPILER=ftn

ifeq ($(MPI),yes)
  DEFS := $(DEFS) MPI
else
  FORTRAN = $(COMPILER)
endif

ifeq ($(OPENMP),yes)
  DEFS := $(DEFS) OPENMP
  ifeq ($(COMPILER),gfortran)
    OMPFLAG = -fopenmp
  endif
  ifeq ($(COMPILER),ifort)
    # Assuming Intel 15, if 14, use -openmp
    OMPFLAG = -qopenmp
  endif
  ifeq ($(COMPILER),ftn)
    OMPFLAG = -homp
  endif
else
  OMPFLAG =
endif

PPFLAGS = $(foreach def,$(DEFS),-D$(def))

ifeq ($(COMPILER),gfortran)
  TARGET = snap
  FFLAGS = -O3 $(OMPFLAG)
  FFLAG2 =
  PP = cpp
  ifeq ($(OPT),no)
    TARGET = snap_db
    FFLAGS = -O0 $(OMPFLAG) -g -fbounds-check -fbacktrace
    FFLAG2 =
  endif
endif

ifeq ($(COMPILER),ifort)
  TARGET = isnap
  FFLAGS = -O3 $(OMPFLAG) -align array32byte -fp-model fast -fp-speculation fast -xHost
  FFLAG2 =
  PP = fpp
  ifeq ($(OPT),no)
    TARGET = isnap_db
    FFLAGS = -O0 $(OMPFLAG) -g -check bounds -traceback -warn unused
    FFLAG2 =
  endif
endif


ifeq ($(COMPILER),ftn)
  TARGET = snap.x #snap_sve_wic.x #snap_x86_vrt.x #snap_aarch64_vrt.x
  FFLAGS +=
  FFLAG2 +=
  PP = cpp #/opt/gcc-cross-aarch64/4.8.1/bin/aarch64-unknown-linux-gnu-cpp #envoy
  ifeq ($(OPT),no)
    TARGET = snap_db
    FFLAGS = -O0 $(OMPFLAG)
    FFLAG2 =
  endif
endif





.SUFFIXES:	.F90 .f90 .o

OBJS = global.o snap_main.o utils.o version.o plib.o geom.o sn.o \
       data.o control.o input.o setup.o dealloc.o translv.o solvar.o \
       outer.o expxs.o inner.o sweep.o octsweep.o dim1_sweep.o dim3_sweep.o \
       output.o time.o mms.o analyze.o thrd_comm.o mkba_sweep.o

SRCS = global.f90 snap_main.f90 utils.f90 version.f90 plib.F90 geom.f90 \
       sn.f90 data.f90 control.f90 input.f90 setup.f90 dealloc.f90 \
       translv.f90 solvar.f90 outer.f90 expxs.f90 inner.f90 sweep.f90 \
       octsweep.f90 dim1_sweep.f90 dim3_sweep.f90 output.f90 time.F90 mms.f90 \
       analyze.f90 thrd_comm.f90 mkba_sweep.f90

$(TARGET) :	$(OBJS)
		$(FORTRAN) $(FFLAGS) $(FFLAG2) -o $@ $(OBJS) #$(MPI_LIB)


version.o :	global.o
geom.o :	global.o
sn.o :		global.o
data.o :	global.o
control.o :	global.o
time.o :	global.o
plib.o :	global.o time.o
thrd_comm.o:	global.o plib.o
expxs.o :	global.o geom.o sn.o data.o
solvar.o :	global.o plib.o geom.o sn.o data.o control.o
mms.o:		global.o geom.o sn.o data.o control.o plib.o
dealloc.o :	global.o sn.o data.o mms.o geom.o solvar.o control.o
utils.o :	global.o dealloc.o plib.o control.o
analyze.o:	global.o control.o geom.o data.o solvar.o plib.o
input.o :	global.o plib.o geom.o sn.o data.o control.o utils.o time.o
setup.o :	global.o geom.o sn.o data.o control.o mms.o utils.o time.o \
		plib.o
output.o :	global.o geom.o sn.o data.o control.o utils.o solvar.o \
		mms.o time.o plib.o
snap_main.o :	global.o utils.o version.o input.o setup.o output.o time.o \
		dealloc.o plib.o control.o
dim1_sweep.o :	global.o geom.o sn.o data.o control.o plib.o
dim3_sweep.o :	global.o plib.o geom.o sn.o data.o control.o thrd_comm.o
mkba_sweep.o :	global.o plib.o geom.o sn.o data.o control.o thrd_comm.o
octsweep.o :	global.o geom.o sn.o data.o control.o solvar.o \
		thrd_comm.o dim1_sweep.o dim3_sweep.o mkba_sweep.o
sweep.o :	global.o geom.o data.o control.o octsweep.o solvar.o plib.o \
		thrd_comm.o
inner.o :	global.o geom.o sn.o data.o control.o solvar.o sweep.o \
		time.o plib.o thrd_comm.o
outer.o :	global.o geom.o sn.o data.o solvar.o control.o inner.o \
		time.o plib.o expxs.o thrd_comm.o
translv.o :	global.o plib.o geom.o sn.o data.o control.o utils.o \
		solvar.o expxs.o outer.o time.o analyze.o

#
# Fortran rules
#
%.o:	%.F90
	$(PP) $(PPFLAGS) $< >$*.f90
	$(FORTRAN) $(FFLAGS) -c $*.f90

%.o:	%.f90
	$(FORTRAN) $(FFLAGS) -c $<

#
# Cleanup
#
clean:
	rm -f *.o *.mod *.bc *.s *.lst *.i

#
# Count lines of code
#
count:
	rm -f Lines
	for file in $(SRCS); do ./LineCount $$file Lines; done
	awk -f ./LineReport < Lines >> Lines
	cat Lines

#
# Link compiled files only. No recompile.
#
link:
	$(LD) -static -o $(TARGET) $(LDFLAGS) $(OBJS) #-L. #-L/opt/cray/pe/lib64/cce/lib/libf.so.1



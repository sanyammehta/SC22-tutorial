# Makefile for src-openmp

SHELL = /bin/bash

### CoMD can be built in either double or single precision and with or
### without MPI.  Select desired precision and MPI here.

# Set executable name and add includes & libraries for MPI if needed.
BIN_DIR=
CoMD_VARIANT = CoMD_openmp
CoMD_EXE = ${CoMD_VARIANT}


# double precision (ON/OFF)
DOUBLE_PRECISION = ON
# MPI for parallel (ON/OFF)
DO_MPI = ON
DO_SAGE = OFF
DO_CrayPat = OFF

### Set your desired C compiler and any necessary flags.  Note that CoMD
### uses some c99 features.  You can also set flags for optimization and
### specify paths to include files that the compiler can't find on its
### own.  If you need any -L or -l switches to get C standard libraries
### (such as -lm for the math library) put them in C_LIB.
CC = cc 
CFLAGS =  #-hnoexceptions -homp -hgnu -hvector3
#CFLAGS = -std=c99 -fopenmp 
OPTFLAGS = -hlist=m -homp #-Ofast -fopenmp -fsave-loopmark
INCLUDES = 
C_LIB = -lm -static


### If you need to specify include paths, library paths, or link flags
### for MPI, put them here.  Put both -L and -l switches into MPI_LIB.
MPI_LIB = #-L/cray/css/mptgrp/envoy-aarch64/anl-mpich/3.1.2.1.NOSLURM/arm64/eth/mpich-cray/8.4/lib/ -lmpi
MPI_INCLUDE = #-I/cray/css/mptgrp/envoy-aarch64/anl-mpich/3.1.2.1.NOSLURM/arm64/eth/mpich-cray/8.4/include/

### A place to specify any other include or library switches your
### platform requires.
OTHER_LIB = #-L/users/swarren/vrt/tl4s/arm/
OTHER_INCLUDE =




#########################################
### Below here, it is pitch black.  
### You are likely to be eaten by a grue.
##########################################

# clear all suffixes
.SUFFIXES:
# list only those that we use 
.SUFFIXES: .c .o

.PHONY: DEFAULT clean distclean depend

# Check for double precision
ifeq ($(DOUBLE_PRECISION), ON)
CFLAGS += -DDOUBLE
else
CFLAGS += -DSINGLE
endif

ifeq ($(DO_MPI), ON)
CoMD_VARIANT = 
INCLUDES += ${MPI_INCLUDE}
CFLAGS += -DDO_MPI
LDFLAGS += ${MPI_LIB}
endif

ifeq ($(DO_SAGE), ON)
#CFLAGS += -DDO_SAGE
CFLAGS += 
LDFLAGS += /cray/css/pe_arch/sage/sage_start_stop.o
endif

ifeq ($(DO_CrayPat), ON)
CFLAGS +=  -DDO_CrayPat
LDFLAGS += 
endif

CoMD_EXE = CoMD_openmp

LDFLAGS += ${C_LIB} ${OTHER_LIB}
# -static
CFLAGS  += ${OPTFLAGS} ${INCLUDES} ${OTHER_INCLUDE}


SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)


DEFAULT: ${CoMD_EXE}

%.o: %.c
	${CC} ${CFLAGS} -c $< -o $@

${CoMD_EXE}: ${BIN_DIR} CoMD_info.h ${OBJECTS} 
	${CC} ${CFLAGS} -o ${CoMD_EXE} ${OBJECTS} ${LDFLAGS} 
#	pat_build ${CoMD_EXE} -o ${BIN_DIR}/${CoMD_EXE}+pat

CoMD_info.h: Makefile
	./generate_info_header ${CoMD_VARIANT} "$(CC)" "$(CFLAGS)" "$(LDFLAGS)"

${BIN_DIR}:
	@if [ ! -d ${BIN_DIR} ]; then mkdir -p ${BIN_DIR} ; fi

clean:
	rm -f *.o CoMD_info.h .depend *.s *.lst *.x ${CoMD_EXE}

distclean: clean
	rm -f ${CoMD_EXE} .depend.bak
	rm -rf html latex

.depend: $(SOURCES)
	@touch .depend
	@$(MAKE) --no-print-directory depend

depend:
	@echo "Rebuilding dependencies..."
	@$(MAKE) CoMD_info.h
	@makedepend -f .depend -Y. --$(CFLAGS)-- $(SOURCES) 2> /dev/null


-include .depend

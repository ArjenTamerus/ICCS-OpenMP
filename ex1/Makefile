FC=ifx
FFLAGS=-fiopenmp -fopenmp-targets=spir64

all: saxpy

%: %.f90
	$(FC) $(FFLAGS) $< -o $@
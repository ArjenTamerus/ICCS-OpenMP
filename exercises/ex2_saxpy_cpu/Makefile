all: saxpy_omp_cpu

saxpy_omp_cpu:
	nvfortran -mp -o saxpy_omp_cpu saxpy_omp_cpu.f90

run:
	./saxpy_omp_cpu

clean:
	rm saxpy_omp_cpu

all: saxpy_omp_gpu_optimised

saxpy_omp_gpu_optimised:
	nvfortran -mp=gpu -o saxpy_omp_gpu_optimised saxpy_omp_gpu_optimised.f90

run:
	./saxpy_omp_gpu_optimised

clean:
	rm saxpy_omp_gpu_optimised

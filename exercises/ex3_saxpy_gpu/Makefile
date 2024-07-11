all: saxpy_omp_gpu

saxpy_omp_gpu:
	nvfortran -mp=gpu -o saxpy_omp_gpu saxpy_omp_gpu.f90

run:
	./saxpy_omp_gpu

clean:
	rm saxpy_omp_gpu

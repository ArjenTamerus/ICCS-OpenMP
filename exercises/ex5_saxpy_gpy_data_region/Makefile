all: saxpy_omp_gpu_data_region

saxpy_omp_gpu_data_region:
	nvfortran -mp=gpu -o saxpy_omp_gpu_data_region saxpy_omp_gpu_data_region.f90

run:
	./saxpy_omp_gpu_data_region

clean:
	rm saxpy_omp_gpu_data_region

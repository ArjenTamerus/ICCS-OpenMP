all: jacobi

jacobi:
	nvfortran -mp=gpu -o jacobi jacobi.f90

run:
	./jacobi

clean:
	rm jacobi

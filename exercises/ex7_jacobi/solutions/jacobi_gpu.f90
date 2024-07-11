! Exercise 7 - Jacobi solver
! This code implements a simple Jacobi solver to solve
! Ax = b where A and B are known.
!
! Exercise: try parallelising this with OpenMP!
! Sample solutions are provided for both CPU and GPU-
! offloaded versions.
!
! Note: normally we would check for convergence and break
! out of the solver loop early if we've reached a good-enough
! solution, but both for simplicity and ease of experimentation
! we're running for a fixed number of steps in this exercise.
program jacobi
  use omp_lib

  implicit none

  integer,parameter :: dp = selected_real_kind(15,300)
  integer,parameter :: max_step = 100000
  integer,parameter :: N = 1024

  integer :: i, j, step

  real(kind=dp), dimension(:,:), allocatable :: A
  real(kind=dp), dimension(:), allocatable :: B, B_test, x, x_new

  real(kind=dp) :: s
  real(kind=dp) :: time

  allocate(A(N,N))
  allocate(B(N),x(N),x_new(N))

  call random_number(A)
  call random_number(B)

  do i=1,N
    A(i,i) = sum(A(i,:)) + 1
  end do

  step = 0
  x = 0.0

  time = omp_get_wtime()

  ! Jacobi solver loop
  ! Exercise:
  ! Implement your OpenMP parallelisation here!
  ! There are multiple ways to approach this
  ! I suggest starting with parallelising the
  ! loop over `j` initially.
  !
  ! Feel free to refer to the solutions if you get stuck!
!$omp target data map(alloc:x_new) map(from:x_new) map(to:A,B)
  do while (step < max_step)
!$omp target teams distribute parallel do simd
    do j=1,N
      s = 0
      do i=1,N
        if (i .ne. j) then
          s = s+A(j,i) * x(i)
        endif
      end do
      x_new(j) = (B(j) - s)/A(j,j)
    end do
    !$omp end target teams distribute parallel do simd

    step = step + 1

    !$omp target update from(x_new)
    do i=1,N
      x(i) = x_new(i)
    end do
    !$omp target update to(x)
  end do

!$omp end target data

  time = omp_get_wtime() - time

  ! if we calculated `x` correctly, `Ax = B_test` should
  ! result in `B_test` being equivalent to `B`
  B_test = matmul(A,x)

  write(*,*) "Is our result close enough (T/F)?", all(abs(B-B_test) < 0.0001)
  write(*,*) "Elapsed time:", time

end program jacobi

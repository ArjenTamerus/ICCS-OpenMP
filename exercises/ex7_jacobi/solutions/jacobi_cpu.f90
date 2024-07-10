program jacobi
  use omp_lib

  implicit none

  integer,parameter :: dp = selected_real_kind(15,300)
  integer,parameter :: max_iter = 100000
  integer,parameter :: N = 1024

  integer :: i, j, k

  real(kind=dp), dimension(:,:), allocatable :: A
  real(kind=dp), dimension(:), allocatable :: B, x, x_new

  real(kind=dp) :: s
  real(kind=dp) :: time

  logical :: not_converged

  allocate(A(N,N))
  allocate(B(N),x(N),x_new(N))

  call random_number(A)
  call random_number(B)

  do i=1,N
    A(i,i) = sum(A(i,:)) + 1
  end do

  not_converged = .true.
  k = 0
  x = 0.0

  time = omp_get_wtime()

  do while (k < max_iter)
!$omp parallel do default(none) private(s,i) shared(N,A,x,x_new,B)
    do j=1,N
      s = 0
      do i=1,N
        if (i .ne. j) then
          s = s+A(j,i) * x(i)
        endif
      end do
      x_new(j) = (B(j) - s)/A(j,j)
    end do
!$omp end parallel do

    k = k + 1

    do i=1,N
      x(i) = x_new(i)
    end do
  end do


  time = omp_get_wtime() - time
  x_new = matmul(A,x)

  write(*,*) b
  write(*,*) x_new
  write(*,*) x_new
  write(*,*) all(abs(b-x_new) < 0.0001)
  write(*,*) time

end program jacobi

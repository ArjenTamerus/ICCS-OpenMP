program saxpy
  use omp_lib

  implicit none

  real,dimension(:),allocatable :: x,y
  real :: a

  integer, parameter :: N = 1024
  integer :: i

  allocate(x(N))
  allocate(y(N))

  a = 3.1415

  do i=1,N
    y(i) = i
    x(i) = 2*i
  end do

  !$omp target teams distribute parallel do simd
  do i=1,N
    y(i) = a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd


  write (*,*) "First value of y:", y(1)
  write (*,*) "Last value of y:", y(N)

end program saxpy

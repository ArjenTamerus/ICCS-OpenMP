program saxpy
  use omp_lib

  implicit none

  real,dimension(:),allocatable :: x,y,z
  real :: a

  integer, parameter :: N = 1024
  integer :: i

  allocate(x(N))
  allocate(y(N))
  allocate(z(N))

  a = 3.1415

  do i=1,N
    y(i) = i
    x(i) = 2*i
  end do

  !$omp target teams distribute parallel do simd map(to:x(1:N),y(1:N)) map(from:z(1:N))
  do i=1,N
    z(i) = a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd


  write (*,*) "First value of z:", z(1)
  write (*,*) "Last value of z:", z(N)

end program saxpy

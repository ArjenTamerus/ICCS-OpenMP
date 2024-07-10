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

  ! TODO init

  !$omp target teams distribute parallel do simd
  do i=1,N
    z(i) = a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd


  write (*,*) "Some result here"

end program saxpy

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

  ! Exercise: We've got our parallel loop implemented.
  ! Can you optimise the data movement for this kernel?
  ! Fill out and expand the map clause(s).
  !
  ! Note we're using an extra `z` array this time.
  ! Can you do it with just `x` and `y`?

!  !$omp target teams distribute parallel do simd map()
  do i=1,N
    z(i) = a * x(i) + y(i)
  end do
!  !$omp end target teams distribute parallel do simd


  write (*,*) "First value of z:", z(1)
  write (*,*) "Last value of z:", z(N)

end program saxpy

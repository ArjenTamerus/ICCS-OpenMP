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
  
  ! Exercise: implement this data region
  ! Take a look at the code and see how the arrays are used on the CPU and/or GPU
  ! and add data mapping clauses as appropriate.
  !
  ! You may have to add some map clauses to the offloaded kernels themselves,
  ! or make use of the `update` directive.
  !
  ! Why not try both?

!  !$omp target data map()

  !$omp target teams distribute parallel do simd
  do i=1,N
    z(i) = a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd

  call modify_on_host(y, N)

  !$omp target teams distribute parallel do simd
  do i=1,N
    z(i) = z(i) + a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd

!   !$omp end target data

  write (*,*) "First value of z:", z(1)
  write (*,*) "Last value of z:", z(N)

  contains
    subroutine modify_on_host(data, N)
      real, dimension(:), intent(inout) :: data
      integer, intent(in) :: N
      integer :: i

      do i=1, N
        data(i) = data(i) * 2
      end do

    end subroutine modify_on_host
end program saxpy

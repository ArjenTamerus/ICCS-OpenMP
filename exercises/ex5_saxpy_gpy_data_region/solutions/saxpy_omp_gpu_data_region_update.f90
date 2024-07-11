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
  
  !$omp target data map(to:x(1:N),y(1:N)) map(from:z(1:N))

  !$omp target teams distribute parallel do simd
  do i=1,N
    z(i) = a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd

  call modify_on_host(y, N)
  !$omp target update to(y(1:N))

  !$omp target teams distribute parallel do simd
  do i=1,N
    z(i) = z(i) + a * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do simd

  !$omp end target data

  write (*,*) "Some result here"

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

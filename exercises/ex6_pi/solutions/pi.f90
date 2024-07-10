! Exercise: parallelise calculating Pi on CPU and/or GPU
! 
! You're on your own for this one!
! 
program pi
  use omp_lib

  implicit none

  integer, parameter :: nsteps = 1000000000
  integer, parameter :: dp = selected_real_kind(15,300)
  real(kind=dp), parameter :: pi_ref = 4.0_dp*DATAN(1.0_dp)

  integer :: i
  real(kind=dp) :: x
  real(kind=dp) :: pi_calc
  real(kind=dp) :: sum
  real(kind=dp) :: step
  real(kind=dp) :: time

  step = 1.0/nsteps
  sum = 0.0

  time = omp_get_wtime()

  !$omp target teams distribute parallel do simd shared(x) reduction(+:sum)
  do i=1,nsteps
    x = (i-0.5) * step
    sum = sum + 4.0 / (1.0 + x * x)
  end do
  !$omp end target teams distribute parallel do simd

  time = omp_get_wtime() - time

  pi_calc = step * sum

  print *, pi_ref, pi_calc, time

end program pi

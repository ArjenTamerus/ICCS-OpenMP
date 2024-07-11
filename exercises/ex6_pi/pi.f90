! Exercise: parallelise calculating Pi on CPU and/or GPU
! 
! You're on your own for this one!
!
! Can you calculate Pi correctly, in parallel?
! Why not give it a try on both CPU or GPU
!
! If you get stuck, a GPU-offloaded solution can be found
! in the `solution` folder
!
! Try playing around with the number of steps and see how it
! affect execution time and accuracy
program pi
  use omp_lib

  implicit none

  integer, parameter :: nsteps = 10000000
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

!  !$omp target
  do i=1,nsteps
    x = (i-0.5) * step
    sum = sum + 4.0 / (1.0 + x * x)
  end do
!  !$omp end target

  time = omp_get_wtime() - time

  pi_calc = step * sum

  print *, "Reference value of pi:", pi_ref
  print *, "Calculated value of pi:", pi_calc
  print *, "Seconds spent in computational loop:", time

end program pi

program hello_world
  use omp_lib

  implicit none

  integer,dimension(:),allocatable :: my_array

  integer :: thread_count
  integer :: my_thread
  integer :: i, status, sum

  allocate(my_array(1024))

  ! Exercise: 
!$omp parallel default(none) private(thread_count, my_thread)
  thread_count = omp_get_num_threads()
  my_thread = omp_get_thread_num()

  print *, "Hello from thread ", my_thread, " out of ", thread_count
!$omp end parallel

  ! Exercise:
  sum = 0
!$omp parallel do default(none) shared(my_array) reduction(+:sum)
  do i=1,1024
    my_array(i) = i
    sum = sum + i
  end do
!$omp end parallel do

  print *, "first: ", my_array(1)
  print *, "last: ", my_array(1024)
  print *, "sum: ", sum

  deallocate(my_array)

end program hello_world

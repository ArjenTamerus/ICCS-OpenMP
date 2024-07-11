program hello_world
  use omp_lib

  implicit none

  integer,dimension(:),allocatable :: my_array

  integer :: thread_count
  integer :: my_thread
  integer :: i, status, sum

  allocate(my_array(1024))

  ! Exercise: Uncomment the OpenMP directives, implement the data-sharing clauses and re-run the code.
  ! What is the output? What is the expected output?
  ! Can you explain what happens?
  !$omp parallel
  thread_count = omp_get_num_threads()
  my_thread = omp_get_thread_num()

  print *, "Hello from thread ", my_thread, " out of ", thread_count
  !$omp end parallel

  ! Exercise: Uncomment the OpenMP directives, implement the data-sharing clauses and re-run the code.
  ! What is the output? What is the expected output?
  ! Can you explain what happens?
  ! Do you need to add any extra clauses compared to the previous exercise?
  sum = 0
  !$omp parallel do
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

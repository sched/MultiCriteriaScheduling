include(syndex.m4x)dnl
include(reliability.m4x)dnl
include(int.m4x)dnl
include(u.m4x)dnl

processor_(U,louve,sammp,
SynDEx-6.7.0 (c)INRIA 2002, 6/9/2004 11:16:58
)


semaphores_(
  Semaphore_Thread_y,
  input1_o__louve_y_empty,
  input1_o__louve_y_full,
  add_o__louve_y_empty,
  add_o__louve_y_full,
  input2_o__louve_y_empty,
  input2_o__louve_y_full,
)

alloc_(int,input1_o,1)
alloc_(int,add_o,1)
alloc_(int,input2_o,1)

media_failures_(0)
processors_failures_(1)

thread_(TCP,y,root,izard,louve,ourson)
  loadFrom_(root)
  Pre0_(input2_o__louve_y_empty)
  Pre0_(add_o__louve_y_empty)
  Pre0_(input1_o__louve_y_empty)
  loop_
    Suc1_(input2_o__louve_y_full)
    reliable_send_(input2_o,U,2.,louve,izard,ourson)
    Pre0_(input2_o__louve_y_empty)
    Suc1_(input1_o__louve_y_full)
    reliable_send_(input1_o,U,2.,louve,izard,ourson)
    Pre0_(input1_o__louve_y_empty)
    Suc1_(add_o__louve_y_full)
    reliable_send_(add_o,U,2.,louve,ourson,root)
    Pre0_(add_o__louve_y_empty)
  endloop_
  saveUpto_(root)
endthread_

main_
  spawn_thread_(y)
  sensor2(input1_o)
  sensor2(input2_o)

  loop_
    Suc0_(input1_o__louve_y_empty,y)
    sensor2(input1_o)
    Pre1_(input1_o__louve_y_full,y)
    Suc0_(input2_o__louve_y_empty,y)
    sensor2(input2_o)
    Pre1_(input2_o__louve_y_full,y)
    Suc0_(add_o__louve_y_empty,y)
    addition(input1_o,input2_o,add_o)
    Pre1_(add_o__louve_y_full,y)
  endloop_
  sensor2(input1_o)
  sensor2(input2_o)
  wait_endthread_(Semaphore_Thread_y)
endmain_

endprocessor_

include(syndex.m4x)
include(int.m4x)
include(u.m4x)
processor_(U,root,hierarchy,
SynDEx-6.6.0 (c)INRIA 2002, 22/1/2003 16:16:26
)


semaphores_(
  Semaphore_Thread_x,
  Main_C_B1_add_o__root_x_empty,
  Main_C_B1_add_o__root_x_full,
  Main_C_B1_A2_add_o__root_x_empty,
  Main_C_B1_A2_add_o__root_x_full,
  Main_i2_o__root_x_empty,
  Main_i2_o__root_x_full,
  Main_i3_o__root_x_empty,
  Main_i3_o__root_x_full,
)


alloc_(int,Main_C_B1_A2_add_o,1)
alloc_(int,Main_C_B1_zero_root_o,1)
alloc_(int,Main_i3_o,1)
alloc_(int,Main_i2_o,1)
alloc_(int,Main_i1_o,1)
alloc_(int,Main_C_B1_A1_add_o,1)
alloc_(int,Main_C_B1_add_o,1)

thread_(TCP,x,root,ecu1)
  loadDnto_(,ecu1)
  Pre0_(Main_i3_o__root_x_empty)
  Pre0_(Main_i2_o__root_x_empty)
  Pre0_(Main_C_B1_add_o__root_x_empty)
  loop_
    Suc1_(Main_i3_o__root_x_full)
    send_(Main_i3_o,U,root,ecu1)
    Pre0_(Main_i3_o__root_x_empty)
    Suc1_(Main_i2_o__root_x_full)
    send_(Main_i2_o,U,root,ecu1)
    Pre0_(Main_i2_o__root_x_empty)
    Suc1_(Main_C_B1_A2_add_o__root_x_empty)
    recv_(Main_C_B1_A2_add_o,U,ecu1,root)
    Pre0_(Main_C_B1_A2_add_o__root_x_full)
    Suc1_(Main_C_B1_add_o__root_x_full)
    send_(Main_C_B1_add_o,U,root,ecu1)
    Pre0_(Main_C_B1_add_o__root_x_empty)
  endloop_
  saveFrom_(,ecu1)
endthread_

main_
  spawn_thread_(x)
  int_cst(1,0,Main_C_B1_zero_root_o)
  int_input(1,Main_i3_o)
  int_input(1,Main_i2_o)
  int_input(1,Main_i1_o)
  int_Arit_add(1,Main_i1_o,Main_C_B1_zero_root_o,Main_C_B1_A1_add_o)
  int_Arit_add(1,Main_C_B1_A1_add_o,Main_C_B1_A2_add_o,Main_C_B1_add_o)
  Pre1_(Main_C_B1_A2_add_o__root_x_empty,x)
  loop_
    Suc0_(Main_i3_o__root_x_empty,x)
    int_input(1,Main_i3_o)
    Pre1_(Main_i3_o__root_x_full,x)
    Suc0_(Main_i2_o__root_x_empty,x)
    int_input(1,Main_i2_o)
    Pre1_(Main_i2_o__root_x_full,x)
    int_input(1,Main_i1_o)
    int_Arit_add(1,Main_i1_o,Main_C_B1_zero_root_o,Main_C_B1_A1_add_o)
    Suc0_(Main_C_B1_A2_add_o__root_x_full,x)
    Suc0_(Main_C_B1_add_o__root_x_empty,x)
    int_Arit_add(1,Main_C_B1_A1_add_o,Main_C_B1_A2_add_o,Main_C_B1_add_o)
    Pre1_(Main_C_B1_A2_add_o__root_x_empty,x)
    Pre1_(Main_C_B1_add_o__root_x_full,x)
  endloop_
  int_cst(1,0,Main_C_B1_zero_root_o)
  int_input(1,Main_i3_o)
  int_input(1,Main_i2_o)
  int_input(1,Main_i1_o)
  int_Arit_add(1,Main_i1_o,Main_C_B1_zero_root_o,Main_C_B1_A1_add_o)
  int_Arit_add(1,Main_C_B1_A1_add_o,Main_C_B1_A2_add_o,Main_C_B1_add_o)
  wait_endthread_(Semaphore_Thread_x)
endmain_

endprocessor_
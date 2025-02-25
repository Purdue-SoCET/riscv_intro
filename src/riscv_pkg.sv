package riscv_pkg

typedef enum logic [3:0] {
   NOP     = 0,
   UNKNOWN = 1,
   ADDI    = 2,
   LUI     = 3,
   SB      = 4,
   LBU     = 5,
   BEQ     = 6,
   BNE     = 7,
   JAL     = 8,
   JALR    = 9
} t_risc_v_op;

typedef enum logic {
    ADD   = 0,
    SUB   = 1,
 } t_alu;
    
endpackage
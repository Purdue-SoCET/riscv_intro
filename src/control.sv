module control
    import riscv_pkg::*;
    (
    input logic clk_i,
    input logic rstn_i,
    // Decoder interface
    input t_risc_v_op op_dec_i,
    input logic [4:0] rd_i,
    input logic [4:0] rs1_i,
    input logic [4:0] rs2_i,
    input logic [31:0] imm_i_i,
    input logic [31:0] imm_s_i,
    input logic [31:0] imm_b_i,
    input logic [31:0] imm_u_i,
    input logic [31:0] imm_j_i,
    output logic decoder_en_o,
    // ALU interface
    input logic [31:0] alu_result_o,
    output t_alu op_alu_i,
    output logic [31:0] alu_src1_i,
    output logic [31:0] alu_src2_i,
    // Memory interface
    input logic [31:0] mem_data_i,
    output logic [byte_addr_p-1:0] addr_o,
    output logic wr_en_o,
    output logic rd_en_o,
    output logic [31:0] mem_data_o
);

// Program counter
logic [31:0] pc_s;
// Currently execeuted PC address
logic [31:0] pc_current_s;
// General purpose registers
logic [31:0] reg_s [31:0];
// Write back word to registers
logic write_back_s [31:0];
    
endmodule
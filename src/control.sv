module control (
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
    output logic [31:0] alu_src2_i
);
    
endmodule
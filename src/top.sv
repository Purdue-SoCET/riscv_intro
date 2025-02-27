module top (
    input logic clk_i,
    input logic rstn_i,
    input logic [31:0] mem_data_i,
    output logic [31:0] mem_data_o
);

logic [addr_p-1:0] word_addr_s;
logic [byte_addr_p-1:0] byte_addr_s;

assign word_addr_s = byte_addr_s [byte_addr_p -1 : 2];

// Memory
logic mem_rd_en_s;
logic mem_wr_en_s;
// Decoder
logic dec_rd_en_s;
logic t_risc_v_op dec_opcode_s,
logic [4:0] rd_s,
logic [4:0] rs1_s,
logic [4:0] rs2_s,
logic [31:0] imm_i_s,
logic [31:0] imm_s_s,
logic [31:0] imm_b_s,
logic [31:0] imm_u_s,
logic [31:0] imm_j_s,
// ALU
t_alu alu_opcode_s,
logic [31:0] src1_s,
logic [31:0] src2_s,
logic [31:0] result_s

memory memory_inst (
    .clk_i (clk_i),
    .rstn_i (rstn_i),
    .addr_i (word_addr_s),
    .wr_en_i (mem_wr_en_s),
    .rd_en_i (mem_rd_en_s),
    .data_i (mem_data_i),
    .data_o (mem_data_o)
)

decoder decoder_inst (
    .clk_i (clk_i),
    .rstn_i (rstn_i),
    .rd_en_i (dec_rd_en_s),
    .mem_data_i (mem_data_o),
    .opcode_o (dec_opcode_s),
    .rd_o (rd_s),
    .rs1_o (rs1_s),
    .rs2_o (rs2_s),
    .imm_i_o (imm_i_s),
    .imm_s_o (imm_s_s),
    .imm_b_o (imm_b_s),
    .imm_u_o (imm_u_s),
    .imm_j_o (imm_j_s)
)

alu alu_inst (
    .op_i (alu_opcode_s),
    .src1_i (src1_s),
    .src2_i (src2_s),
    .result_o (result_s)
)

control control_inst (
    .clk_i (clk_i),
    .rstn_i (rstn_i),
    // Decoder interface
    .op_dec_i (dec_opcode_s),
    .rd_i (rd_s),
    .rs1_i (rs1_s),
    .rs2_i (rs2_s),
    .imm_i_i (imm_i_s),
    .imm_s_i (imm_s_s),
    .imm_b_i (imm_b_s),
    .imm_u_i (imm_u_s),
    .imm_j_i (imm_j_s),
    .decoder_en_o (dec_rd_en_s),
    // ALU interface
    .alu_result_i (result_s),
    .op_alu_o (alu_opcode_s),
    .alu_src1_o (src1_s),
    .alu_src2_o (src2_s),
    // Memory interface
    .mem_data_i (mem_data_i),
    .addr_o (byte_addr_s),
    .wr_en_o (mem_wr_en_s),
    .rd_en_o (mem_rd_en_s),
    .mem_data_o (mem_data_o)
)
    
endmodule
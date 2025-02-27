module top (
    input logic clk_i,
    input logic rstn_i,
    input logic [31:0] mem_data_i,
    output logic [31:0] mem_data_o
);

logic mem_rd_en_s;
logic mem_wr_en_s;
logic dec_rd_en_s;
logic t_risc_v_op opcode_s,
logic [4:0] rd_s,
logic [4:0] rs1_s,
logic [4:0] rs2_s,
logic [31:0] imm_i_s,
logic [31:0] imm_s_s,
logic [31:0] imm_b_s,
logic [31:0] imm_u_s,
logic [31:0] imm_j_s,
logic [addr_p-1:0] word_addr_s;
logic [byte_addr_p-1:0] byte_addr_s;

assign word_addr_s = byte_addr_s [byte_addr_p -1 : 2];
    
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
    .opcode_o (opcode_s),
    .rd_o (rd_s),
    .rs1_o (rs1_s),
    .rs2_o (rs2_s),
    .imm_i_o (imm_i_s),
    .imm_s_o (imm_s_s),
    .imm_b_o (imm_b_s),
    .imm_u_o (imm_u_s),
    .imm_j_o (imm_j_s)
)
    
endmodule
module decoder
(
    input logic clk_i,
    input logic rstn_i,
    input logic enable_i,
    input logic [31:0] mem_data_i,
    output logic [4:0] rd_o,
    output logic [4:0] rs1_o,
    output logic [4:0] rs2_o,
    output logic [31:0] imm_i_o,
    output logic [31:0] imm_s_o,
    output logic [31:0] imm_b_o,
    output logic [31:0] imm_u_o,
    output logic [31:0] imm_j_o,
); 
    logic [31:0] instr_s;
    logic [6:0] opcode_s;
    logic [2:0] func3_s;
    logic [6:0] func7_s;
    // Stream operator for little endian to big endiasn
    assign instr_s = {<<8{mem_data_i}};
endmodule
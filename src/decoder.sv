module decoder
import riscv_pkg::*;
(
    input logic clk_i,
    input logic rstn_i,
    input logic rd_en_i,
    input logic [31:0] mem_data_i,
    output t_risc_v_op opcode_o,
    output logic [4:0] rd_o,
    output logic [4:0] rs1_o,
    output logic [4:0] rs2_o,
    output logic [31:0] imm_i_o,
    output logic [31:0] imm_s_o,
    output logic [31:0] imm_b_o,
    output logic [31:0] imm_u_o,
    output logic [31:0] imm_j_o
); 
    logic [31:0] instr_s;
    logic [6:0] opcode_s;
    logic [2:0] func3_s;
    logic [6:0] func7_s;
    // Stream operator for little endian to big endiasn
    assign instr_s = {<<8{mem_data_i}};
    // Slice instructions 
    assign opcode_s = instr_s [6:0];
    assign func3_s = instr_s [14:12];
    assign func7_s = instr_s [31:25];

    always @(posedge clk_i) begin: INST_PROC
    if (rstn_i == 0'b0) begin
        opcode_o <= NOP;
        rd_o <= '{default: '0};
        rs1_o <= '{default: '0};
        rs2_o <= '{default: '0};
        imm_i_o <= '{default: '0};
        imm_s_o <= '{default: '0};
        imm_b_o <= '{default: '0};
        imm_u_o <= '{default: '0};
        imm_j_o <= '{default: '0};
    end
    else begin
        if (rd_en_i == 1'b1)
        begin
            rd_o <= instr_s [11:7];
            rs1_o <= instr_s [19:15];
            rs2_o <= instr_s [24:20];
            // I immidiate
            imm_i_o [31:11] <= {21{instr_s[31]}};
            imm_i_o [10:0] <= instr_s [30:20];
            // S immidiate
            imm_s_o [31:11] <= {21{instr_s[31]}};
            imm_s_o [10:5] <= instr_s [30:25];
            imm_s_o [4:0] <= instr_s [11:7];
            // B immidiate
            imm_b_o [31:12] <= {20{instr_s[31]}};
            imm_b_o [10:5] <= instr_s [30:25];
            imm_b_o [11] <= instr_s [7];
            imm_b_o [4:1] <= instr_s [11:8];
            imm_b_o [0] <= 1'b0;
            // U immidiate
            imm_u_o [10:5] <= {6{1'b0}};
            imm_u_o [31:12] <= instr_s [31:12];
            // J immidiate
            imm_j_o [31:20] <= {12{instr_s[31]}};
            imm_j_o [19:12] <= instr_s [19:12];
            imm_j_o [11] <= instr_s [20];
            imm_j_o [10:5] <= instr_s [30:25];
            imm_j_o [4:1] <= instr_s [24:21];
            imm_j_o [0] <= 0'b0;
        end
    end
end: INST_PROC

always @(posedge clk_i) begin: DECODE_PROC

    if (rstn_i == 1'b0) begin
      op <= NOP;
    end
        else begin

            if rd_en_i == 1'b0 begin

            end
            else if (opcode_s == 7'b0010011 && func3_s == 3'b000) begin
              opcode_o <= ADDI;
            end
            else if (opcode_s == 7'b0110111) begin
              opcode_o <= LUI;
            end
            else if (opcode_s == 7'b0100011 && func3_s == 3'b000) begin
              opcode_o <= SB;
            end
            else if (opcode_s == 7'b0000011 && func3_s == 3'b100) begin
              opcode_o <= LBU;
            end
            else if (opcode_s == 7'b1100011 && func3_s == 3'b000) begin
              opcode_o <= BEQ;
            end
            else if (opcode_s == 7'b1100011 && func3_s == 3'b001) begin
              opcode_o <= BNE;
            end
            else if (opcode_s == 7'b1101111) begin
              opcode_o <= JAL;
            end
            else if (opcode_s == 7'b1100111 && func3_s == 3'b000) begin
              opcode_o <= JALR;
            end
            else begin
              opcode_o <= UNKNOWN;
              $$display("NO INSTRUCTION IS DETECTED, opcode_s = 0x%0h", opcode_s);
            end
        end
end: DECODE_PROC
endmodule
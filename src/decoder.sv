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
    // Slice instructions 
    assign opcode_s = instr_s [6:0];
    assign func3_s = instr_s [14:12];
    assign func7_s = instr_s [31:25];

    INST_PROC: always @(posedge clk) begin
    if (rstn_i == 0'b0) begin
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
        if (enable_i == 1'b1)
        begin
            mem_s[addr_i] <= data_i;
        end
        if (rd_en_i == 1'b1)
        begin
            rd_o <= instr_s [11:7];
            rs1_o <= instr_s [19:15];
            rs2_o <= instr_s [24:20];
            // I immidiate
            imm_i_o [31:11] <= '{default: 'instr_s[31]};
            imm_i_o [10:0] <= instr_s [30:20];
            // S immidiate
            imm_s_o [31:11] <= '{default: 'instr_s[31]};
            imm_s_o [10:5] <= instr_s [30:25];
            imm_s_o [4:10] <= instr_s [11:7];

        end
    end
end
endmodule
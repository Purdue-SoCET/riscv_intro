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
    input logic [31:0] alu_result_i,
    output t_alu op_alu_o,
    output logic [31:0] alu_src1_o,
    output logic [31:0] alu_src2_o,
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
logic [31:0] write_back_s;

// FSM Encoding
enum logic [3:0]
    { FETCH_FIRST,
      FETCH_SECOND,
      DECODE_FIRST,
      DECODE_SECOND,
      EXECUTE_FIRST,
      EXECUTE_SECOND,
      MEM_RD_FIRST,
      MEM_RD_SECOND,
      MEM_WRITE,
      MEM_WRITE_BACK
    } state;
    
always @(posedge clk_i) begin: CONTROL_PROC
    if (rstn_i == 1'b0) begin
        decoder_en_o <= '{default: '0};
        op_alu_o <= ADD;
        alu_src1_o <= '{default: '0};
        alu_src2_o <= '{default: '0};
        addr_o <= '{default: '0};
        wr_en_o <= '{default: '0};
        rd_en_o <= '{default: '0};
        wr_en_o <= '{default: '0};
        mem_data_o <= '{default: '0};
        state <= FETCH_FIRST;
        pc_s <= '{default: '0};
        pc_current_s <= '{default: '0};
        reg_s <= '{default: '0};
        write_back_s <= '{default: '0};
   end 
   else begin
    decoder_en_o <= 1'b0;
    wr_en_o <= 1'b0;
    case (state) //CONTROL_FSM
        FETCH_FIRST : begin
            addr_o <= pc_s [byte_addr_p - 1: 0];
            pc_current_s <= pc_s;
            pc_s <= pc_s + 4;
            state <= FETCH_SECOND; // to wait one clock cycle
        end
        FETCH_SECOND : begin
            decoder_en_o <= 1'b1;
            state <= DECODE_FIRST;
        end
        DECODE_FIRST : begin
            state <= DECODE_SECOND; // to wait one clock cycle
        end
        DECODE_SECOND : begin
            // case (op_dec_i) // RISCV_INST_DECODE
            //     : 
            //     default: 
            // endcase: RISCV_INST_DECODE
        end
        EXECUTE_FIRST : begin
            // case (op_dec_i) // RISCV_INST_EXECUTE_FIRST
            //     : 
            //     default: 
            // endcase: RISCV_INST_EXECUTE_FIRST
        end
        EXECUTE_SECOND : begin
            //  case (op_dec_i) // RISCV_INST_EXECUTE_SECOND
            //     : 
            //     default: 
            // endcase: RISCV_INST_EXECUTE_SECOND
        end
        MEM_RD_FIRST : begin
            state <= MEM_RD_SECOND;  // to wait one clock cycle
        end
        MEM_RD_SECOND : begin
            // case (op_dec_i) // RISCV_INST_MEMORY_READ_SECOND
            //     : 
            //     default: 
            // endcase: RISCV_INST_MEMORY_READ_SECOND
        end
        MEM_WRITE : begin
            // case (op_dec_i) // RISCV_INST_WRITE
            //     : 
            //     default: 
            // endcase: RISCV_INST_WRITE
        end
        MEM_WRITE_BACK : begin
            reg_s[rd_i] <= write_back_s;
            reg_s[0] <= 1'b0; // x0 is hardwired 
            state <= FETCH_FIRST;
        end
    endcase // CONTROL_FSM
    end
 end:CONTROL_PROC
endmodule
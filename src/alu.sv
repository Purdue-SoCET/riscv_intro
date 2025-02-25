module alu 
import riscv_pkg::*;
(
    input t_risc_v_op op_i,
    input logic [31:0] src1_i,
    input logic [31:0] src2_i,
    output logic [31:0] result_o
    ); 

ALU_PROC: always @(*) begin

    case (op_i)
       ADD : 
       begin
        result_o <= src1_i + src2_i;
       end
       SUB:
       begin
        result_o <= src1_i - src2_i;
        end
        default:
        begin
            result_o <= '{default: '0};
        end
    endcase

end
endmodule
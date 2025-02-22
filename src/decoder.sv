module decoder
(
    input logic clk_i,
    input logic rstn_i,
    input logic enable_i,
    input logic [31:0] mem_data_i,
    output logic 
); 
    logic instr_s [31:0];
    // Stream operator for little endian to big endiasn
    assign instr_s = {<<8{mem_data_i}};
endmodule
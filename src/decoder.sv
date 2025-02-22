module decoder
(
    input bit clk_i,
    input bit rstn_i,
    input bit enable_i,
    input bit [31:0] mem_data_i
); 
    reg instr_r [31:0];
    // Stream operator for little endian to big endiasn
    assign instr_r = {<<8{mem_data_i}};
endmodule
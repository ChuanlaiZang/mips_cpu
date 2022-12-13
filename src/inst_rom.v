module inst_rom(
    input [15:0] ins,
    input clk,
    input reset,
    input ena,
    output [6:0] seg,
    output [7:0] ans
    );
    wire [31:0] InsData;

    single_port_rom inst_rom (
        .clka(clk),    // input wire clka
        .ena(ena),      // input wire ena
        .addra({{16{ins[15]}},ins[15:0]}),  // input wire [9 : 0] addra 
        .douta(InsData[31:0])  // output wire [31 : 0] douta
);
            
endmodule
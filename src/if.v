module if(clk, rst, instr);
    input clk;
    input rst;
    input targ_addr;
    input PC_sel;
    output [31:0] instr;

    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] pcplus4;


    pc u_pc #(32)(
        .clk    (clk),
        .rst    (rst),
        .d      (pc),
        .q      (pc_next)
    );

    adder u_pcadder(
        .a      (pc_next),
        .b      (32'd4),
	    .y      (pcplus4)
    );

    mux2 u_pcmux2 (
        .d0(pcplus4),
        .d1(targ_addr),
        .s (PC_sel),
        .y (pc)
    );
    
    inst_ram inst_rom (
        .clka(clk),    // input wire clka
        .ena(),      // input wire ena
        .addra(pc_next),  // input wire [9 : 0] addra 
        .douta(instr)  // output wire [31 : 0] douta
);
          

endmodule
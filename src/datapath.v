module datapath(
	input wire clk,rst,
	input wire memtoreg,pcsrc,
	input wire alusrc,regdst,
	input wire regwrite,jump,
	input wire[2:0] alucontrol,
	output wire overflow,zero,
	output wire[31:0] pc,
	input wire[31:0] instr,
	output wire[31:0] aluout,writedata,
	input wire[31:0] readdata
    );
	

	wire[4:0] writereg;
	wire[31:0] pcnext,pcnextbr,pcplus4,pcbranch;
	wire[31:0] signimm,signimmsh;
	wire[31:0] srca,srcb;
	wire[31:0] result;

	wire [5:0] opcode;
	wire [5:0] func;
	wire [5:0] rs;
	wire [5:0] rt;
	wire [5:0] rd;
	wire [15:0] imm16;
	
	assign opcode = instr[31:26];
	assign func = instr[5:0];

    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] pcplus4;

// ****************************************************************
// if
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

    npc u_npc(

	)

    mux2 u_pcmux2 (
        .d0(pcplus4),
        .d1(targ_addr),
        .s (PC_sel),
        .y (pc)
    );
    
    inst_ram u_inst_rom (
        .clka(clk),            // input wire clka
        .rsta(rst),            // input wire rsta
        .ena(),              // input wire ena
        .addra(pc_next),          // input wire [31 : 0] addra
        .douta(instr),          // output wire [31 : 0] douta
        .rsta_busy()  // output wire rsta_busy
    );

// ****************************************************************
	pc #(32) pcreg(clk,rst,pcnext,pc);
	adder pcadd1(pc,32'b100,pcplus4);
	sl2 immsh(signimm,signimmsh);
	adder pcadd2(pcplus4,signimmsh,pcbranch);
	mux2 #(32) pcbrmux(pcplus4,pcbranch,pcsrc,pcnextbr);
	mux2 #(32) pcmux(pcnextbr,{pcplus4[31:28],instr[25:0],2'b00},jump,pcnext);

	regfile rf(clk,regwrite,instr[25:21],instr[20:16],writereg,result,srca,writedata);
	mux2 #(5) wrmux(instr[20:16],instr[15:11],regdst,writereg);
	mux2 #(32) resmux(aluout,readdata,memtoreg,result);
	signext se(instr[15:0],signimm);

	mux2 #(32) srcbmux(writedata,signimm,alusrc,srcb);
	alu alu(srca,srcb,alucontrol,aluout,overflow,zero);

endmodule

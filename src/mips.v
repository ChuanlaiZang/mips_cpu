module mips(
	input wire clk,rst,
	output wire[31:0] pc,
	input wire[31:0] instr,
	output wire memwrite,
	output wire[31:0] aluout,writedata,
	input wire[31:0] readdata 
    );
	

	wire [5:0] opcode, // 操作码
    wire [4:0] rd,     // 目标寄存器
    wire [4:0] rs,     // 源寄存器 1
    wire [4:0] rt,     // 源寄存器 2
    wire [15:0] imm,   // 立即数
    wire [25:0] target // 目标地址

	// 提取操作码
    assign opcode = instr[6:0];
    // 提取目标寄存器
    assign rd = instr[11:7];
    // 提取源寄存器 1
    assign rs = instr[19:15];
    // 提取源寄存器 2
    assign rt = instr[24:20];
    // 提取立即数
    assign imm = instr[15:0];
    // 提取目标地址
    assign target = instr[25:0];

    // 对于 J 类型指令，将立即数拼接到操作码后面
    always_comb
        if (opcode == 6'b000010 || opcode == 6'b000011)
            target = {opcode, imm};
        else
            target = 25'b0;
	
	wire memtoreg,alusrc,regdst,regwrite,jump,pcsrc,zero,overflow;
	wire[2:0] alucontrol;


	controller c(instr[31:26],instr[5:0],zero,memtoreg,
		memwrite,pcsrc,alusrc,regdst,regwrite,jump,alucontrol);
	datapath dp(clk,rst,memtoreg,pcsrc,alusrc,
		regdst,regwrite,jump,alucontrol,overflow,zero,pc,instr,aluout,writedata,readdata);
	
endmodule

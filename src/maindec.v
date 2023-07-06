module maindec(
	//input wire[31:0] instr,
	input wire [5:0] opcode;
	input wire [5:0] func;

	output wire memtoreg,
	output wire memwrite,
	output wire branch,
	output wire alusrc,
	output wire regdst,
	output wire regwrite,
	output wire jump,
	output wire[1:0] aluop
	output wire PC_sel
	output wire ExtOp;
);

	//控制信号有opcode,和func决定
	//wire [5:0] opcode;
	//wire [5:0] func;
	//wire [5:0] rs;
	//wire [5:0] rt;
	//wire [5:0] rd;
	//wire [15:0] imm16;


	reg[8:0] controls;

	//assign opcode = instr[31:26];
	//assign func = instr[5:0];

	assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,aluop} = controls;
	
	assign opcpde 
	always @(*) begin
		case (opcode)
			6'b000000:controls <= 9'b110000010;//R-TYRE
			6'b000000:controls <= 9'b;//ORI
			6'b100011:controls <= 9'b101001000;//LW
			6'b101011:controls <= 9'b001010000;//SW
			6'b000100:controls <= 9'b000100001;//BEQ
			6'b001000:controls <= 9'b101000000;//ADDI
			6'b000010:controls <= 9'b000000100;//J
			default:  controls <= 9'b000000000;//illegal op
		endcase
	end
endmodule

//七条指令
//addu, subu, ori, lw, sw, beq, j


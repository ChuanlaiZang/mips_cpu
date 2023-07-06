`include "define.v"

module alu (a, b, aluop, result, carry_out, overflow, overflow, zero);
	input wire [31:0] a;
	input wire [31:0] b;
	input wire [4:0] aluop;
	output signed [31:0] result;
	output wire carry_out;
	output wire overflow;
	output wire zero;

	wire [31:0] result_temp;
	wire [31:0] a_signed;
	wire [31:0] b_signed;
  
	// 符号数转换
	// assign a_signed = a;
	// assign b_signed = b;
	assign result_temp = {32{a[31]}} + b;
	assign carry_out = result_temp[32];
	assign result = result_temp[31:0];
	assign overflow = (a[31] == b[31]) & (a[31] != result[31]);
	assign zero = (result == 0);
  
	// 运算选择
	always@(*) begin
	  case (aluop)
		`ALU_NOP:  result = a;                          // NOP
		`ALU_ADD:  result = a + b;                      // ADD
		`ALU_SUB:  result = a - b;                      // SUB
		`ALU_AND:  result = a & b;                      // AND/ANDI/ADDIU
		`ALU_OR:   result = a | b;                      // OR/ORI
		`ALU_SLT:  result = (a < b) ? 32'd1 : 32'd0;    // SLT/SLTI/SLTIU
		`ALU_SLTU: result = ({1'b0, a} < {1'b0, b}) ? 32'd1 : 32'd0;
		`ALU_NOR:  result = ~(a | b);
		`ALU_XOR:  result = a ^ b;                      //xor
		`ALU_SLL:  result = b << a;                     //sll
		`ALU_SRL:  result = b >> a;                     //srl
		`ALU_SRA:  result = b >>> a;                    //sra
		`ALU_SLLV: result = b << a[4:0];                //sllv
		`ALU_SRLV: result = b >> a[4:0];                //srlv
		`ALU_SRAV: result = b >>> a[4:0];               //srav
		`ALU_SLL16: result = b << 16;                   //lui
		//`ALU_MULTI: D = A * B;                     //mutli
		default:   result = A;                          //Undefined
	  endcase
	end
endmodule
  
//寄存器堆
module regfile(
	input wire clk,
	input wire rst;
	input wire wena,
	input wire[4:0] rw,ra,rb,		//读写控制信号，选中对应编号的寄存器将内容放入busA,busB,busW
	input wire[31:0] RegWriDate,	//写总线
	output wire[31:0] busA,busB		//输出总线
    );

	reg [31:0] rf[31:0];`//32个32位的寄存器

	//寄存器的写受时钟控制
	always @(posedge clk) begin
		if (rst) begin
			for (i = 1; i<32; i=i+1 ) begin
				rf[i] <= 0;
			end
		end
		if(wena) begin
			 rf[rw] <= RegWriDate;
		end
	end
	
	//寄存器堆的读不受时钟控制
	assign busA = (ra != 0) ? rf[ra] : 0;
	assign busB = (rb != 0) ? rf[rb] : 0;
endmodule

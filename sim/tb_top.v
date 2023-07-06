module tb_top();
	reg clk;
	reg rst;

	wire[31:0] writedata,dataadr;
	wire memwrite;

	top dut(clk,rst,writedata,dataadr,memwrite);

	initial begin 
		rst <= 1;
		#200;
		rst <= 0;
	end

	always begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	
	end

	always @(negedge clk) begin
		if(memwrite) begin
			/* code */
			if(dataadr === 84 & writedata === 7) begin
				/* code */
				$display("Simulation succeeded");
				$stop;
			end else if(dataadr !== 80) begin
				/* code */
				$display("Simulation Failed");
				$stop;
			end
		end
	end
endmodule


module sort;

	// Inputs
	reg clock;
	reg clk_reset;
	reg cpu_reset;
	reg mem_reset;
	reg start;
	reg enable;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.boardCLK(clock), 
		.cpu_reset(cpu_reset), 
		.clk_reset(clk_reset),
		.mem_reset(mem_reset),
		.start(start), 
		.enable(enable)
	);
	
	always #1 clock = ~clock;

	initial begin
		// Initialize Inputs
		clock = 0;
		cpu_reset = 0;
		clk_reset = 0;
		mem_reset = 0;
		start = 0;
		enable = 0;

		// Wait 50 ns for global reset to finish
		#50
		enable <= 1;
		start <= 0;
		cpu_reset = 1;
		clk_reset = 1;
		mem_reset = 1;
		
		#50 clk_reset = 0;
		#50 cpu_reset = 0;
        #50 mem_reset = 0;
		
		#50 enable = 1;
		#50 start = 1;
		#50 start = 0; 

	end
      
endmodule

module top(
	input wire clk,rst,
	output wire[31:0] writedata,dataadr,
	output wire memwrite
);

	wire[31:0] pc,instr,readdata;

	contrllor
	datapath
	mips mips(clk,rst,pc,instr,memwrite,dataadr,writedata,readdata);
	inst_mem imem(clk,pc[7:2],instr);
	data_mem dmem(~clk,memwrite,dataadr,writedata,readdata);
endmodule

module top(clk, rst);
   input          clk;
   input          rst;

   
   wire [31:0]    instr;
   wire [31:0]    PC;
   wire           MemWrite;
   wire [31:0]    MemAdd, MemWriData, MemRedData;
   wire [2: 0]    Load;
   wire [1: 0]    Store;

        
  // instantiation of single-cycle CPU   
   CPU mips(
         .clk(clk),                 // input:  cpu clock
         .rst(rst),                 // input:  reset
         .instr(instr),             // input:  instruction
         .MemRedData(MemRedData),   // input:  data to cpu  
         .MemWrite(MemWrite),       // output: memory write signal
         .PC(PC),                   // output: PC
         .aluout(MemAdd),          	// output: address from cpu to memory
         .writedata(MemWriData),    // output: data from cpu to memory
         .Load(Load),        		// output: register data
         .Store(Store)
         );
         
  // instantiation of data memory  
   data_ram    datamemory(
         .clk(clk),          		// input:  cpu clock
         .MemWrite(MemWrite),     	// input:  ram write
         .MemAdd(MemAdd), 			// input:  ram address
         .MemWriData(MemWriData),   // input:  data to ram
         .Load(Load),
         .Store(Store),
         .MemRedData(MemRedData)       // output: data from ram
         );

  // instantiation of intruction memory (used for simulation)
   inst_rom instrmemory ( 
    	.RegRedAdd(PC[8:2]),     // input:  rom address
    	.RegRedData(instr)        // output: instruction
   );
        
endmodule

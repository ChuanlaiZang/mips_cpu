// data memory
module dm(clk, DMWr, addr, din, dout);
input          clk;
input          DMWr;
input  [8:2]   addr;
input  [31:0]  din;     //输入数据
output [31:0]  dout;    //输出数据
  
reg [31:0] dmem[127:0]; //宽度32，深度128的RAM

always @(posedge clk)
    if (DMWr) begin
        dmem[addr[8:2]] <= din;
        $display("dmem[0x%8X] = 0x%8X,", addr << 2, din); 
    end

assign dout = dmem[addr[8:2]];
 
endmodule    

module DM(clk, MemWrite, MemAdd, MemWriData, Load, Store, MemRedData);
   input          clk;
   input          MemWrite;
   input  [9:0]   MemAdd;
   input  [31:0]  MemWriData;
   input  [2: 0]  Load;
   input  [1: 0]  Store;
   output reg [31:0]  MemRedData;
    
   reg [8:0] ram[1023:0]; //宽度9，深度1024的RAM
   //reg [31:0] dout = 32'b0; //default

   always @(posedge clk)
    begin
      if (MemWrite) begin
         case(Store)
            2'b00: begin // sw
               ram[MemAdd + 0] = MemWriData[7:0];
               ram[MemAdd + 1] = MemWriData[15:8];
               ram[MemAdd + 2] = MemWriData[23:16];
               ram[MemAdd + 3] = MemWriData[31:24];
            end
            2'b01: begin // sb
               ram[MemAdd + 0] = MemWriData[7:0];
            end
            2'b10: begin // sh
               ram[MemAdd + 0] = MemWriData[7:0];
               ram[MemAdd + 1] = MemWriData[15:8];
            end
         endcase
       
        $display("ram[0x%8X] = 0x%2X 0x%2X 0x%2X 0x%2X ", (MemAdd / 4) << 2, ram[((MemAdd / 4) << 2) + 3], ram[((MemAdd / 4) << 2) + 2], ram[((MemAdd / 4) << 2) + 1], ram[((MemAdd / 4) << 2)]); 
      end
   end

   always @(negedge clk) begin
      case(Load)
         3'b000: begin // lw
            MemRedData[7:0]   = ram[MemAdd + 0];
            MemRedData[15:8]  = ram[MemAdd + 1];
            MemRedData[23:16] = ram[MemAdd + 2];
            MemRedData[31:24] = ram[MemAdd + 3];
         end
         3'b001: begin // lb
            //MemRedData[7:0]   = ram[MemAdd + 0];
            MemRedData = {{24{ram[MemAdd + 0][7]}}, ram[MemAdd + 0][7: 0]};
         end
         3'b010: begin // lbu
            MemRedData = {24'd0, ram[MemAdd + 0][7: 0]};
         end
         3'b011: begin // lh
            MemRedData = {{16{ram[MemAdd + 1][7]}}, ram[MemAdd + 1][7: 0], ram[MemAdd + 0][7: 0]};
         end
         3'b100: begin // lhu
            MemRedData = {16'd0, ram[MemAdd + 1][7: 0], ram[MemAdd + 0][7: 0]};
         end
         default: begin //default
            MemRedData[7:0]   = ram[MemAdd + 0];
            MemRedData[15:8]  = ram[MemAdd + 1];
            MemRedData[23:16] = ram[MemAdd + 2];
            MemRedData[31:24] = ram[MemAdd + 3];
         end
      endcase
      //$display("data_add_load = 0x%8X ", MemAdd);
      //$display("ram[0x%8X] = 0x%2X 0x%2X 0x%2X 0x%2X ", (MemAdd / 4) << 2, ram[((MemAdd / 4) << 2) + 3], ram[((MemAdd / 4) << 2) + 2], ram[((MemAdd / 4) << 2) + 1], ram[((MemAdd / 4) << 2)]);
      //$display("data_in = 0x%8X ", MemWriData);
      //$display("data_out = 0x%8X ", MemRedData);
   end
endmodule 
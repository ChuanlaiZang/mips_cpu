//************* ALU Operation Define *************//
//逻辑运算，算术运算，移位，比较


`define ALU_NOP   5'b0000 
`define ALU_ADD   5'b0001
`define ALU_SUB   5'b0010 
`define ALU_AND   5'b0011
`define ALU_OR    5'b0100
`define ALU_SLT   5'b0101
`define ALU_SLTU  5'b0110
`define ALU_NOR   5'b0111
`define ALU_SLL   5'b1000
`define ALU_SRL   5'b1001
`define ALU_SRA   5'b1010
`define ALU_SLLV  5'b1011
`define ALU_SRLV  5'b1100
`define ALU_SLL16 5'b1101
`define ALU_XOR   5'b1110
`define ALU_SRAV  5'b1111
//`define ALU_MULTI 5'b10000


// ********* MEM SIZE Define *********//

`define MEM_SIZE 1025

// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10
`define NPC_JR      2'b11

// Data Memory signal
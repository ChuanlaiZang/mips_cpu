// instruction memory
module inst_rom(
    input  [8:2]  RegRedAdd,
    output [31:0] RegRedData
    );

    reg  [31:0] rom[127:0];

    assign RegRedData = rom[RegRedAdd]; // word aligned
endmodule  


module extender(
	input wire[15:0] a,
	input wire extop,
	output wire[31:0] y
    );

	localparam zero_ext = 0;
	localparam sign_ext = 1;

	assign y = extop ? {{16{0}},a} : {{16{a[15]}},a};
endmodule

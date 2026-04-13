`timescale 1ns / 1ps

module shaper_tb();


reg  clock = 1;
reg  signed [34-1:0] in = 0;
wire signed [34+14:0] out;

always #5 clock <= ~clock;

reg [63:0] cont = 0;

always@(posedge clock)
begin
	cont <= cont + 1;
	if (cont == 5)
		in <= (2**32);
	else
		in <= 0;
end


shaper sl
(
    .clock(clock), 
    .in(in),
    .out(out)
);


//integer data_out;

//initial
//begin
//	data_out <= $fopen("shaper_tb.txt");
//end


//always@(posedge clock)
//begin
//	$fdisplay(data_out, "%d", out);
//end


endmodule
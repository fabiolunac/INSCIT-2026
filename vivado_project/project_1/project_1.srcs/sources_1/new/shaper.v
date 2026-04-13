`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2026 19:34:24
// Design Name: 
// Module Name: shaper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module shaper
#( 
	parameter BITS_IN = 10,
	parameter G_ENTRADA = 2**32,
	parameter G_SAIDA_LOG = 15
)
(
	input  clock, 
	input  signed [BITS_IN-1:0] in,
	output signed [BITS_IN+21:0] out
);


wire signed [BITS_IN+21:0] out1, out2, out3, out4, out5, out6;
 
// ------------------- Filter 1 -------------------
iir_ordem1
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(-8),  
	.a1(-32766)
) iir1
(
	.clock(clock), 
	.in(in),
	.out(out1)
);

// ------------------- Filter 2 -------------------
iir_ordem1
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(881514),  
	.a1(-19875)
) iir2
(
	.clock(clock), 
	.in(in),
	.out(out2)
);

// ------------------- Filter 3 -------------------
iir_ordem1
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(-991624),  
	.a1(-17983)
) iir3
(
	.clock(clock), 
	.in(in),
	.out(out3)
);

// ------------------- Filter 4 -------------------
iir_ordem2
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(-307994),
	.b1(-885),	
	.a1(843),
	.a2(14)
) iir4
(
	.clock(clock), 
	.in(in),
	.out(out4)
);

// ------------------- Filter 5 -------------------
//iir_ordem2
//#( 
//	.BITS_IN(BITS_IN),
//	.G_ENTRADA(G_ENTRADA),
//	.G_SAIDA_LOG(15),
//	.b0(449386),
//	.b1(-3028),	
//	.a1(-442),
//	.a2(1)
//) iir5
//(
//	.clock(clock), 
//	.in(in),
//	.out(out5)
//);

iir_ordem1
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(293630),  
	.a1(-221)
) iir5
(
	.clock(clock), 
	.in(in),
	.out(out5)
);


// ------------------- Filter 6 -------------------
iir_ordem1
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(155586),  
	.a1(-221)
) iir6
(
	.clock(clock), 
	.in(in),
	.out(out6)
);	

// ------------------- Filter 7 -------------------
iir_ordem1
#( 
	.BITS_IN(BITS_IN),
	.G_ENTRADA(G_ENTRADA),
	.G_SAIDA_LOG(15),
	.b0(17888871),  
	.a1(0)
) iir7
(
	.clock(clock), 
	.in(in),
	.out(out7)
);	

assign out = out1 + out2 + out3 + out4 + out5 + out6 + out7;


endmodule


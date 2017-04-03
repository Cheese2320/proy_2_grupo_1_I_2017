`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2017 19:11:47
// Design Name: 
// Module Name: switchd
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


module switchd(
input wire clk, reset,
input sin,
output sout
);

reg [2:0] contador;

always @ (posedge clk, posedge reset)
  if (reset == 1)
     contador <= 3'b000;
  else
     contador <= {contador[1:0], sin};

assign sout = contador[0] & contador[1] & contador[2];

endmodule

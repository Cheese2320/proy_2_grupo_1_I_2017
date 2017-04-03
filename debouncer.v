`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2017 08:11:58
// Design Name: 
// Module Name: debouncer
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


module debouncer(
input wire clk,reset,In,
output Out
);
reg [1:0] contador;
wire in;
always @ (posedge clk, posedge reset)
  if (reset == 1)
        contador <= 2'b0;
  else
        contador <= {1'b1, In};
assign Out= (contador[0]&contador[1]);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2017 11:28:17
// Design Name: 
// Module Name: nanos
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


module nanos(
input wire clk, reset,
input In,
output Out
);
reg bit, cambio;
wire out;

debouncer vara(.clk(clk),.reset(reset),.In(In),.Out(out));
always @ (posedge clk,posedge reset)
  if (reset == 1)
    begin
     bit <=0;
     cambio<=1;
    end
  else
    case(out)
        1'b1:
        if (cambio)
            begin
                bit<=out;
                cambio<=0;
            end
        else
            begin
                bit<=0;
            end
        default:
            begin
                bit<=0;
                cambio<=1;
            end
    endcase
assign Out = bit;
endmodule

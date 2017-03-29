`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2017 17:45:22
// Design Name: 
// Module Name: Deco_BCD_DEC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Decodificador que convierte un número de 4 bits en un número decimal.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Creado por Anthony Ross, Isabel Vallejos y Sebastián Quesada
// 
//////////////////////////////////////////////////////////////////////////////////


module DECO(
  input enable,
  input [3:0] bcd_num,
  output  reg [1:0] address_out,
  output  reg [3:0] sel_address_out 
    );

always@* begin
	 if(enable) begin
          case(bcd_num)
             4'b0000: begin
                  address_out = 2'h0;
                  sel_address_out=4;end
             4'b0001: begin
                  address_out = 2'h1;
                 sel_address_out = 4;end
             4'b0010: begin
			      address_out = 2'h2;
                  sel_address_out = 4;end
             4'b0011: begin
                    address_out = 2'h3;
                    sel_address_out = 4;end
             4'b0100: begin
                   address_out = 2'h0;
                   sel_address_out = 5;end
             4'b0101: begin
                   address_out = 2'h1;
                   sel_address_out = 5;end
             4'b0110: begin
                    address_out = 2'h2;
                    sel_address_out = 5;end
             4'b0111: begin
                   address_out = 2'h3;
                   sel_address_out = 5;end
             4'b1000: begin
                   address_out = 2'h0;
                   sel_address_out = 6;end
             4'b1001: begin
                   address_out = 2'h1;
                   sel_address_out = 6;end

             default: begin 
             address_out = 0;
             sel_address_out = 0;
             end
        	endcase
		  end
		  else begin
		   address_out = 0;
		   sel_address_out = 0;
		   end
		end
endmodule

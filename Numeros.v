`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2017 07:50:39 PM
// Design Name: 
// Module Name: Numeros
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

module Numeros(
 	input wire rst, clk, //reset y clock
 	input wire video_on, // indica donde pintar
 	input wire [9:0] pixel_x, pixel_y, // posicion coordenadas x, y
 	input [7:0]fechad,fecham,fechaa,fechah,
    //fechamin,fechas,fechaht,fechamint,fechast,
    output wire [3:0] ro,go,bo,
 	output wire [7:0]font1,
 	output [4:0] char1,
 	output fb
);

wire enable; //enable para el decodificador
reg enablereg;

assign enable=enablereg;

//letras
reg [4:0] char2;
wire [3:0] row;
wire [8:0] rom;
wire [2:0] bit;
wire [7:0] word;
wire fontb;

// Se instancia el modulo de ROM, para leer los numeros
fontROM rom2(.addr(rom), .data(word));
assign row = pixel_y[4:1];
assign rom = {char2,row};
assign bit = pixel_x[3:1];
assign fontb = word[~bit];

reg [3:0] bcd_deco; // numero a decodificar

// Se instancia el modulo del decodificador para decodificar el
// numero que esta entrando
DECO Dec1(.enable(enable), .bcd_num(bcd_deco), .address_out(char2));



// ***************Multiplexor de bordes*****************

wire dia1,dia2, mes1,mes2,a1,a2; // Cifras de los dias, meses y años

// Se asigna el valor a cada cifra segun los 8 bits entrantes
assign dia1= ((pixel_x>=192)&&(pixel_x<=207)&&(pixel_y>=64)&&(pixel_y<=95));
assign dia2= ((pixel_x>=220)&&(pixel_x<=235)&&(pixel_y>=64)&&(pixel_y<=95));
assign mes1= ((pixel_x>=220)&&(pixel_x<=235)&&(pixel_y>=64)&&(pixel_y<=95));
assign mes1= ((pixel_x>=220)&&(pixel_x<=235)&&(pixel_y>=64)&&(pixel_y<=95));
assign a1=   ((pixel_x>=220)&&(pixel_x<=235)&&(pixel_y>=64)&&(pixel_y<=95));
assign a2=   ((pixel_x>=220)&&(pixel_x<=235)&&(pixel_y>=64)&&(pixel_y<=95));

reg [3:0]r;
reg [3:0]g;
reg [3:0]b;

always @*
    begin
	   if(dia1)
            begin
                bcd_deco<=fechad[7:4];
                enablereg<=1;
            end
       else if (dia2)
            begin
                bcd_deco<=fechad[3:0];
                enablereg<=1;
	        end
	   else if (mes1)
            begin
                bcd_deco<=fecham[7:4];
                enablereg<=1;
	        end
	   else if (mes2)
            begin
		        bcd_deco<=fecham[3:0];
                enablereg<=1; 
	        end
	   else if (a1)
	       begin
                bcd_deco<=fechaa[7:4];
                enablereg<=1; 
	        end
	   else if (a2)
	        begin
                bcd_deco<=fechaa[3:0];
                enablereg<=1;
	        end
        else 
        char2<=5'b00000; // fondo
    end

always @*
    if(rst|~video_on)
        begin
            r<=1;
            g<=1;
            b<=1;
        end
    else
        begin
            if(BordeIzq_on|BordeDer_on|BordeSup_on|BordeInf_on)
                begin
                    r<=4'h6;
                    g<=4'h0;
                    b<=4'h4;
                end  
          else if(BordeBD_on|BordeBI_on|BordeBS_on|BordeBR_on)
                  begin
                      r<=4'h6;
                      g<=4'h0;
                      b<=4'h4;  
                  end
          else if((fontb==1&&(deok|suok|reok|izqok)))
                  begin
                      r<=4'h0;
                      g<=4'h0;
                      b<=4'h1;  
                  end                  
           else if(cajitafh|(fontb==1&&(dok|tok|puntosfh)))
                begin
                    r<=4'h0;
                    g<=4'h0;
                    b<=4'h1;  
                end   
	       else if(cajitah|(fontb==1 && (hok|rok)))
                begin
                    r<=4'h0;
                    g<=4'h1;
                    b<=4'h0;  
                end
           else if(cajitat|(fontb==1 && (tiok|iok|puntost)))
                begin
                    r<=4'h1;
                    g<=4'h0;
                    b<=4'h0;  
                end
           else
                begin
                    r<=4'h1;
                    g<=4'h1;
                    b<=4'h1;
                end
        end
//salidas finales del rgb en este modulo
 assign ro=r;
 assign go=g;
 assign bo=b;
//son solo para ver en la simulacion, no se utilizan en si al final
 assign char1=char2;
 assign font1=word;
 assign fb=fontb;
endmodule

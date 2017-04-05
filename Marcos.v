`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2017 17:10:01
// Design Name: 
// Module Name: vgastatic_tb
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
module Marcos(
 	input wire rst, //reset
 	input wire video_on, // indica donde pintar
 	input wire [9:0] pixel_x, pixel_y, // posicion coordenadas x, y
 	output wire [3:0] ro,go,bo,
 	output wire [7:0]font1,
 	output [4:0] char1,
 	output fb
);

wire fhv1,fhv2, fhh1, fhh2, cajitafh, hv1, hv2, hh1, hh2, cajitah, tv1, tv2, th1, th2, cajitat;

    // BORDE DE PANTALLA    

// ********** BORDES VERTICALES DE PANTALLA ***********

    // PRIMER BORDE DE PANTALLA
	localparam BordePantallaxIzq =  0;
	localparam BordePantallaxDer = 10;
	localparam BordePantallay    =  0;
	localparam BordePantallayf   = 479;
	wire  BordeIzq_on;
	assign BordeIzq_on = ((pixel_x>=BordePantallaxIzq) && (pixel_x<=BordePantallaxDer) &&
        (pixel_y>=BordePantallay) && (pixel_y<=BordePantallayf));

	// SEGUNDO BORDE DE PANTALLA 
	localparam BordePantalla2xIzq=629;
	localparam BordePantalla2xDer=639;
	localparam BordePantalla2y  = 0;
	localparam BordePantalla2yf  = 479;
	wire  BordeDer_on;
	assign BordeDer_on = ((pixel_x>=BordePantalla2xIzq) && (pixel_x<=BordePantalla2xDer) &&
        (pixel_y>=BordePantalla2y) && (pixel_y<=BordePantalla2yf));

// ******************************************************	

// ********** BORDES HORIZONTALES DE PANTALLA ***********	

	// PRIMER BORDE DE PANTALLA
	localparam BordeSupIzqx=10;
	localparam BordeSupDerx=629;
	localparam BordeSupy = 0;
	localparam BordeSupyf = 10;
	wire  BordeSup_on;
	assign BordeSup_on = ((pixel_x>=BordeSupIzqx) && (pixel_x<=BordeSupDerx) &&
        (pixel_y>=BordeSupy) && (pixel_y<=BordeSupyf));
	
	// SEGUNDO BORDE DE PANTALLA
	localparam BordeInfIzqx=10;
	localparam BordeInfDerx=629;
	localparam BordeInfy = 469;
	localparam BordeInfyf = 479;
	wire  BordeInf_on;
	assign BordeInf_on = ((pixel_x>=BordeInfIzqx) && (pixel_x<=BordeInfDerx) &&
	(pixel_y>=BordeInfy) && (pixel_y<=BordeInfyf));
	
	//Cajita para fecha
	assign fhv1 = ((pixel_x>=160)&&(pixel_x<=175)&&(pixel_y>=32)&&(pixel_y<=127));
	assign fhv2 = ((pixel_x>=448)&&(pixel_x<=463)&&(pixel_y>=32)&&(pixel_y<=127));
	assign fhh1 = ((pixel_x>=160)&&(pixel_x<=463)&&(pixel_y>=32)&&(pixel_y<=47));
	assign fhh2 = ((pixel_x>=160)&&(pixel_x<=463)&&(pixel_y>=112)&&(pixel_y<=127));
	assign cajitafh = (fhv1|fhv2|fhh1|fhh2);
	
	//Cajita para hora
    assign hv1 = ((pixel_x>=128)&&(pixel_x<=144)&&(pixel_y>=192)&&(pixel_y<=287));
    assign hv2 = ((pixel_x>=480)&&(pixel_x<=496)&&(pixel_y>=192)&&(pixel_y<=287));
    assign hh1 = ((pixel_x>=128)&&(pixel_x<=496)&&(pixel_y>=192)&&(pixel_y<=207));
    assign hh2 = ((pixel_x>=128)&&(pixel_x<=496)&&(pixel_y>=272)&&(pixel_y<=287));
    assign cajitah = (hv1|hv2|hh1|hh2);
    
    //Cajita para timer
    assign tv1 = ((pixel_x>=160)&&(pixel_x<=175)&&(pixel_y>=352)&&(pixel_y<=447));
    assign tv2 = ((pixel_x>=448)&&(pixel_x<=463)&&(pixel_y>=352)&&(pixel_y<=447));
    assign th1 = ((pixel_x>=160)&&(pixel_x<=463)&&(pixel_y>=352)&&(pixel_y<=367));
    assign th2 = ((pixel_x>=160)&&(pixel_x<=463)&&(pixel_y>=432)&&(pixel_y<=447));
    assign cajitat = (tv1|tv2|th1|th2);
    
    // letras y simbolos
wire dok,tok,hok,rok,tiok,iok, puntosfh, puntost;
    assign dok= ((pixel_x>=96)&&(pixel_x<=111)&&(pixel_y>=64)&&(pixel_y<=95));
    assign tok= ((pixel_x>=128)&&(pixel_x<=143)&&(pixel_y>=64)&&(pixel_y<=95));
    assign hok= ((pixel_x>=64)&&(pixel_x<=79)&&(pixel_y>=224)&&(pixel_y<=255));
    assign rok= ((pixel_x>=96)&&(pixel_x<=111)&&(pixel_y>=224)&&(pixel_y<=255));
    assign tiok= ((pixel_x>=96)&&(pixel_x<=111)&&(pixel_y>=384)&&(pixel_y<=415));
    assign iok= ((pixel_x>=128)&&(pixel_x<=143)&&(pixel_y>=384)&&(pixel_y<=415));
    assign puntosfh= ((((pixel_x>=256)&&(pixel_x<=271))|((pixel_x>=352)&&(pixel_x<=367)))&&((pixel_y>=64)&&(pixel_y<=95)));
    assign puntost= ((((pixel_x>=256)&&(pixel_x<=271))|((pixel_x>=352)&&(pixel_x<=367)))&&((pixel_y>=384)&&(pixel_y<=415)));
    

//letras
reg [4:0]char2;
wire [3:0] row;
wire [8:0] rom;
wire [2:0] bit;
wire [7:0] word;
wire fontb;

fontROM rom1(.addr(rom), .data(word));
assign row = pixel_y[4:1];
assign rom = {char2,row};
assign bit = pixel_x[3:1];
assign fontb = word[~bit];
    	
// ***************Multiplexor de bordes*****************
reg [3:0]r;
reg [3:0]g;
reg [3:0]b;
always @*
    begin
	   if(dok) //si ven entre los x hay 16 bits y entre los y hay 32 bits
            begin
                char2<=5'b00010; //D
            end
       else if (tok)
            begin
                char2<=5'b01110;//T
	        end
	   else if (hok)
            begin
                char2<=5'b00101;//H
	        end
	   else if (rok)
            begin
		        char2<= 5'b01100;//codigo de R 
	        end
	   else if (tiok)
            begin
		        char2<= 5'b01110;//codigo de t 
	        end
	   else if (iok)
	        begin
            	char2<= 5'b00110;//codigo para la i
	        end
	   else if (puntosfh)
	        begin
	           char2<=5'b11010;//Puntos de separación para los numeros de las horas, minutos y segundos, tanto para el reloj como para el timer
	        end
	   else if(puntost)
	        begin
	           char2<=5'b11010;
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



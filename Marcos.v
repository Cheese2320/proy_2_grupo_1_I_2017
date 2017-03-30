`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2017 01:37:40 PM
// Design Name: 
// Module Name: Marcos
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
 	output [11:0] rgb_text // salida de colores
);

    // BORDE DE PANTALLA    

// ********** BORDES VERTICALES DE PANTALLA ***********

    // PRIMER BORDE DE PANTALLA
	localparam BordePantallaxIzq =  0;
	localparam BordePantallaxDer = 10;
	localparam BordePantallay    =  0;
	localparam BordePantallayf   = 479;
	wire  BordeIzq_on;
	assign BordeIzq_on = (BordePantallaxIzq<=pixel_x) && (pixel_x<=BordePantallaxDer) &&
	(BordePantallay<=pixel_y) && (pixel_y<=BordePantallayf);

	// SEGUNDO BORDE DE PANTALLA 
	localparam BordePantalla2xIzq=629;
	localparam BordePantalla2xDer=639;
	localparam BordePantalla2y  = 0;
	localparam BordePantalla2yf  = 479;
	wire  BordeDer_on;
	assign BordeDer_on = (BordePantalla2xIzq<=pixel_x) && (pixel_x<=BordePantalla2xDer) &&
	(BordePantalla2y <=pixel_y) && (pixel_y<=BordePantalla2yf);

// ******************************************************	

// ********** BORDES HORIZONTALES DE PANTALLA ***********	

	// PRIMER BORDE DE PANTALLA
	localparam BordeSupIzqx=10;
	localparam BordeSupDerx=629;
	localparam BordeSupy = 0;
	localparam BordeSupyf = 10;
	wire  BordeSup_on;
	assign BordeSup_on = (BordeSupIzqx<=pixel_x) && (pixel_x<=BordeSupDerx) &&
	(BordeSupy<=pixel_y) && (pixel_y<=BordeSupyf);
	
	// SEGUNDO BORDE DE PANTALLA
	localparam BordeInfIzqx=10;
	localparam BordeInfDerx=629;
	localparam BordeInfy = 469;
	localparam BordeInfyf = 479;
	wire  BordeInf_on;
	assign BordeInf_on = (BordeInfIzqx<=pixel_x) && (pixel_x<=BordeInfDerx) &&
	(BordeInfy<=pixel_y) && (pixel_y<=BordeInfyf);

// ******************************************************	

endmodule

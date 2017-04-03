`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2017 00:52:28
// Design Name: 
// Module Name: lectura
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


module lectura(clk, reset, re, ad_mux, flec, state, AD, CS, RD, WR, TS,oki) ;
//Declaracion de entradas  salidas
	input clk, re, reset ; 
	output AD, CS, RD, WR, TS, ad_mux, flec,oki; 
	output[2:0] state; 
	
	reg [2:0] next_state, state ; 
	reg [1:0] tsel ; //Selecciona valor de cuenta
	reg tload, flec, AD, CS, RD, WR, TS, ad_mux,oki;
	wire finish; //Termina 
	
parameter [2:0] es0 = 3'b000; //Standby
parameter [2:0] es1 = 3'b001; //Tads
parameter [2:0] es2 = 3'b010; //Access
parameter [2:0] es3 = 3'b011; //Tadt
parameter [2:0] es4 = 3'b100; //Tw
parameter [2:0] es5 = 3'b101; //tCS
parameter [2:0] es6 = 3'b110;  //Tw
parameter [2:0] es7 = 3'b111; //Salida y reinicio
	
	
// Instancia generador de tiempos
tiempos Timer(clk,reset,tload,tsel,finish) ;
// Logica de siguiente estado y salidas  al timer
	always @(state or re or finish) begin
		case(state)
			es0: {tload, tsel, next_state} = {1'b1, 2'b10, re ? es1 : es0} ;
			es1: {tload, tsel, next_state} = {1'b1, 2'b10, es2} ;
			es2: {tload, tsel, next_state} = {finish, 2'b01, finish ? es3 : es2 } ;
			es3: {tload, tsel, next_state} = {finish, 2'b11, finish ? es4 : es3 } ;
			es4: {tload, tsel, next_state} = {finish, 2'b10, finish ? es5 : es4 } ;
			es5: {tload, tsel, next_state} = {finish, 2'b11, finish ? es6 : es5 } ;
			es6: {tload, tsel, next_state} = {finish, 2'b00, finish ? es7 : es6 } ;
			es7: {tload, tsel, next_state} = {1'b1, 2'b00, es0 } ;
			default: {tload, tsel, next_state} = {1'b0, 2'b00, es0 } ;
		endcase
	end
	//Salidas
	always @(state or re or finish) 
	begin 
		case(state)
			es0: {AD, CS, RD, WR, ad_mux, flec,TS,oki} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
			es1: {AD, CS, RD, WR, ad_mux, flec,TS,oki} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0} ;
			es2: {AD, CS, RD, WR, ad_mux, flec,TS,oki}= {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
			es3: {AD, CS, RD, WR, ad_mux, flec,TS,oki}= {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0} ;
			es4: {AD, CS, RD, WR, ad_mux, flec,TS,oki}= {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0} ;
			es5: {AD, CS, RD, WR, ad_mux, flec,TS,oki} = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1} ;
			es6: {AD, CS, RD, WR, ad_mux, flec,TS,oki} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0} ;
			es7: {AD, CS, RD, WR, ad_mux, flec,TS,oki} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0} ;
			default: {AD, CS, RD, WR, ad_mux, flec,TS,oki} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0} ;
		endcase
	end
	//Asignaci�n de siguiente estado
	always @(posedge clk, posedge reset) 
	begin
		if (reset) 
		begin
		state <= es0;
		end
		else 
		begin
		state <= next_state;
		end
	end

endmodule

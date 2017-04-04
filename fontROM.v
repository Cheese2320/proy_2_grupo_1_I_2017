`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2017 09:34:17 AM
// Design Name: 
// Module Name: fontROM
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2017 09:34:17 AM
// Design Name: 
// Module Name: fontROM
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

module fontROM( 
 input wire clk, // Reloj de entrada
 input wire [5:0] addr, // recorre todas las posibilidades de memoria
 output reg [7:0] data // 8 bits del dato de salida
);

reg [5:0] addr_reg; // Guarda la direccion actual
    
/*always @(posedge clk)
    addr_reg <= addr; */ // Actualiza la direccion en cada
                        // cambio de reloj

   // Letras a utilizar DIA MES AÑO HORA HR MIN SEG RING TIMER DERECHA IZQUIERDA
   // D I A M E S Ñ O H R N G T Z Q                


always@*    
   case (addr) // Evalua el valor de la direccion

         //  NULL para completar los 64bits
         6 'h00: data = 8'b00000000;
         6 'h01: data = 8'b00000000;
         6 'h02: data = 8'b00000000;
         6 'h03: data = 8'b00000000;
         6 'h04: data = 8'b00000000;
         6 'h05: data = 8'b00000000;
         6 'h06: data = 8'b00000000;
         6 'h07: data = 8'b00000000;
         6 'h08: data = 8'b00000000;
         6 'h09: data = 8'b00000000;
         6 'h0a: data = 8'b00000000;
         6 'h0b: data = 8'b00000000;
         6 'h0c: data = 8'b00000000;
         6 'h0d: data = 8'b00000000;
         6 'h0e: data = 8'b00000000;
         6 'h0f: data = 8'b00000000;

         //  Primera letra F
         6 'h10: data = 8'b00000000;
         6 'h11: data = 8'b00000000;
         6 'h12: data = 8'b11111110; //        *******
         6 'h13: data = 8'b01100110; //         **  **
         6 'h14: data = 8'b01100010; //         **   *
         6 'h15: data = 8'b01101000; //         ** *
         6 'h16: data = 8'b01111000; //         ****
         6 'h17: data = 8'b01101000; //         ** *
         6 'h18: data = 8'b01100000; //         **
         6 'h19: data = 8'b01100000; //         **
         6 'h1a: data = 8'b01100000; //         **
         6 'h1b: data = 8'b11110000; //        ****
         6 'h1c: data = 8'b00000000;
         6 'h1d: data = 8'b00000000;
         6 'h1e: data = 8'b00000000;
         6 'h1f: data = 8'b00000000;

         // Segunda letra H
         6 'h20: data = 8'b00000000;
         6 'h21: data = 8'b00000000;
         6 'h22: data = 8'b11000110; //       **   ** 
         6 'h23: data = 8'b11000110; //       **   **
         6 'h24: data = 8'b11000110; //       **   **
         6 'h25: data = 8'b11000110; //       **   **
         6 'h26: data = 8'b11111110; //       *******
         6 'h27: data = 8'b11000110; //       **   **
         6 'h28: data = 8'b11000110; //       **   **
         6 'h29: data = 8'b11000110; //       **   **
         6 'h2a: data = 8'b11000110; //       **   **
         6 'h2b: data = 8'b11000110; //       **   **
         6 'h2c: data = 8'b00000000;
         6 'h2d: data = 8'b00000000;
         6 'h2e: data = 8'b00000000;
         6 'h2f: data = 8'b00000000;

      default : data <= 8'b00000000;
      endcase
endmodule
            
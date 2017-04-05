`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2017 17:09:36
// Design Name: 
// Module Name: vgastatic
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


module vgastatic(
input wire clk, reset,
output hsy,vsy,
output [9:0] px, py,
output [3:0] ro,go,bo,
output [7:0] font1,
output [4:0] char1,
output fb
    );
//wire [9:0] px, py;
wire vidon;

//instaciamiento de los modulos
sincronizador test(.clk(clk),
                   .rst(reset),
                   .hsync(hsy),
                   .vsync(vsy),
                   .vidon(vidon),
                   .px(px),
                   .py(py));
Marcos test1(.rst(reset),
             .video_on(vidon),
             .pixel_x(px),
             .pixel_y(py),
             .ro(ro),
             .go(go),
             .bo(bo),
             .font1(font1),
             .char1(char1),
             .fb(fb));
endmodule

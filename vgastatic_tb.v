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


module vgastatic_tb(
    );
    reg reloj;
    reg reset;
    wire hs, vs;
    wire [3:0] r,g,b;
    wire [9:0] x,y;
    wire [7:0] font1;
    wire [2:0] char1;
    wire fb;
    integer img;
    
    //instaciamiento de módulo
    vgastatic static(.clk(reloj),
                     .reset(reset),
                     .hsy(hs),
                     .vsy(vs),
                     .px(x),
                     .py(y),
                     .ro(r),
                     .go(g),
                     .bo(b),
                     .font1(font1),
                     .char1(char1),
                     .fb(fb));
    initial 
    begin
        img=$fopen("vga15.txt","w");
        reloj=0;
        reset=1;
        #10 reset=0;
        #30719890 $fclose(img);
    end 
    always
    begin
        #10 reloj=~reloj;
    end
    always@ (x)
    begin
        $fwrite(img, "_%H",x);
            //$fwrite(id, "\t");
        $fwrite(img, "_%H_",y);
            //$fwrite(id, "\t");
        $fwrite(img, "%H",r);
            //$fwrite(id, "\t");
        $fwrite(img, "%H",g);
            //$fwrite(id, "\t");
        $fwrite(img, "%H",b);
        $fwrite(img, "\n");

    end                 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2017 15:06:13
// Design Name: 
// Module Name: cousuario
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


module cousuario(
input wire clk, rst,
input up, dw, lf, rg, prom, swfh, swt, formato,
//estadaos de las maquinas
input wire [2:0] pstate,
output reg [3:0] sta, dir,
output reg [7:0] dia, mes, year, fhh, fhm, fhs, th, tm, ts
    );
reg [3:0] nxsta;
parameter [3:0] hold=4'b0000; //espera
parameter [3:0] fht=4'b0001; //reloj o timer
parameter [3:0] tipo=4'b0010; //formato de hora
parameter [3:0] resetr=4'b0011; //reset del reloj
parameter [3:0] rdia=4'b0100; //día
parameter [3:0] rmes=4'b0101;//mes
parameter [3:0] ryear=4'b0110;//ano
parameter [3:0] rhora=4'b0111;//hora reloj
parameter [3:0] rmin=4'b1000;//min reloj
parameter [3:0] rseg=4'b1001;// seg reloj
parameter [3:0] resett=4'b1010; // reset timer                              
parameter [3:0] thora=4'b1011;//hora timer
parameter [3:0] tmin=4'b1100;//min timer
parameter [3:0] tseg=4'b1101;//seg timer

//Logica de los siguientes estados
reg horaf;
always@*
begin
    case(sta)
        hold:
            nxsta = (((pstate==3'b010)||(pstate==3'b100))&&(prom==1'b0))?fht:hold;
        fht:
            if(swfh && ~swt)
                nxsta=tipo;
            else if(swt && ~swfh)
                nxsta=resett;
            else
                nxsta=hold;
        tipo:
            if (formato) //1 para 24h, 0 para 12h
                begin
                    nxsta=resetr;
                    horaf<=1;
                end 
            else
                begin
                    nxsta=resetr;
                    horaf<=0;
                 end
        resetr:
            nxsta=rdia;
        rdia:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=rmes;
            else if (lf)
                nxsta=tseg;
            else
                nxsta=rdia;
        rmes:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=ryear;
            else if(lf)
                nxsta=rdia;
            else
                nxsta=rmes;
        ryear:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=rhora;
            else if(lf)
                nxsta=rmes;
            else
                nxsta=ryear;
        rhora:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=rmin;
            else if(lf)
                nxsta=ryear;
            else
                nxsta=rhora;
        rmin:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=rseg;
            else if(lf)
                nxsta=rhora;
            else
                nxsta=rmin;
        rseg:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=thora;
            else if(lf)
                nxsta=rmin;
            else
                nxsta=rseg;
                
        resett:
            nxsta=thora;
        thora:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=tmin;
            else if(lf)
                nxsta=tseg;
            else
                nxsta=thora;
        tmin:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=tseg;
            else if(lf)
                nxsta=thora;
            else
                nxsta=tmin;
        tseg:
            if(prom)
                nxsta=hold;
            else if(rg)
                nxsta=thora;
            else if(lf)
                nxsta=tmin;
            else
                nxsta=tseg;
        default:
            nxsta=hold;       
    endcase
end

//Modificacion de los valores de los registros debido al usuario

always @(posedge clk, posedge rst)
    if(rst==1)
        {dia, mes, year, fhh, fhm, fhs, th, tm, ts}=
        {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};
    else
        begin
            {dia, mes, year, fhh, fhm, fhs, th, tm, ts}=
            {dia, mes, year, fhh, fhm, fhs, th, tm, ts};
        case(sta)
            hold:
                {dia, mes, year, fhh, fhm, fhs, th, tm, ts}=
                {dia, mes, year, fhh, fhm, fhs, th, tm, ts}; 
            resetr:
                {dia, mes, year, fhh, fhm, fhs, th, tm, ts}=
                {8'h01,8'h01,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};
            rdia:
                begin
                    if(up)
                        if(dia==8'h31)
                            dia=8'h01;
                        else if(dia[3:0]==9)
                            dia= dia+8'h07;
                        else
                            dia= dia+8'h01;
                    else
                        if(dw)
                            if(dia==8'h01)
                                dia=8'h31;
                            else if(dia[3:0]==0)
                                dia=dia-8'h07;
                            else
                                dia=dia-9'h01;
                end
            rmes:
                begin
                    if(up)
                        if(mes==8'h12)
                            mes=8'h01;
                        else if (mes[3:0]==9)
                            mes=mes+8'h07;
                        else
                            mes=mes+8'h01;
                    else
                        if(dw)
                            if(mes==8'h01)
                                mes=8'h12;
                            else if(mes[3:0]==0)
                                mes=mes-8'h07;
                            else
                                mes=mes-8'h01;
                end
            ryear:
                begin
                    if(up)
                        if(year==8'h99)
                            year=8'h00;
                        else if(year[3:0]==9)
                            year=8'h07;
                        else
                            year=8'h01;
                    else
                        if(dw)
                            if(year==8'h00)
                                year=8'h99;
                            else if(year[3:0]==0)
                                year=year-8'h07;
                            else
                                year=year-8'h01;
                end
            rhora:
                begin
                end
        endcase
        end
endmodule

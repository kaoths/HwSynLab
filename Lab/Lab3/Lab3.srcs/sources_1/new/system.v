`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 12:17:57 PM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    input [7:0] sw,
    input btnU,
    input btnC,
    input clk
    );
wire targetClk;
wire [20:0] tclk;
assign tclk[0] = clk;
assign an = {an3,an2,an1,an0};    
    
wire [3:0] num0,num1,num2,num3, incSwOut, decSwOut;
wire [7:0] sync;
wire [7:0] pulse;
wire oneCoutPulse, oneBoutPulse, tenCoutPulse, tenBoutPulse, hundredCoutPulse, hundredBoutPulse;

genvar i;
generate for(i=0; i<21; i=i+1)
begin
    clockDiv fdiv(tclk[i+1],tclk[i]);
end endgenerate
clockDiv fdivTarget(targetClk,tclk[20]);

generate for(i=0; i<8; i=i+1)
begin
    synchronizer syncer(sync[i],sw[i],targetClk);
end endgenerate

generate for(i=0; i<8; i=i+1)
begin
    singlePulser pulser(pulse[i],sync[i],targetClk);
end endgenerate
incChecker incCheck(incSwOut,{pulse[7],pulse[5],pulse[3],pulse[1]},num0,num1,num2,num3,targetClk);
decChecker decCheck(decSwOut,{pulse[6],pulse[4],pulse[2],pulse[0]},num0,num1,num2,num3,targetClk);

//bcdCounter one(num0,oneCout,oneBout,cin,bin,pulse[1],pulse[0],btnU,btnC,targetClk);
bcdCounter one(num0,oneCout,oneBout,cin,bin,incSwOut[0],decSwOut[0],btnU,btnC,targetClk);
singlePulser onePulse1(oneBoutPulse,oneBout,targetClk);
singlePulser onePulse2(oneCoutPulse,oneCout,targetClk);

//bcdCounter ten(num1,tenCout,tenBout,oneCoutPulse,oneBoutPulse,pulse[3],pulse[2],btnU,btnC,targetClk);
bcdCounter ten(num1,tenCout,tenBout,oneCoutPulse,oneBoutPulse,incSwOut[1],decSwOut[1],btnU,btnC,targetClk);
singlePulser tenPulse1(tenBoutPulse,tenBout,targetClk);
singlePulser tenPulse2(tenCoutPulse,tenCout,targetClk);

//bcdCounter hundred(num2,hundredCout,hundredBout,tenCoutPulse,tenBoutPulse,pulse[5],pulse[4],btnU,btnC,targetClk);
bcdCounter hundred(num2,hundredCout,hundredBout,tenCoutPulse,tenBoutPulse,incSwOut[2],decSwOut[2],btnU,btnC,targetClk);
singlePulser hundredPulse1(hundredBoutPulse,hundredBout,targetClk);
singlePulser hundredPulse2(hundredCoutPulse,hundredCout,targetClk);

//bcdCounter thousand(num3,thousandCout,thousandBout,hundredCoutPulse,hundredBoutPulse,pulse[7],pulse[6],btnU,btnC,targetClk);
bcdCounter thousand(num3,thousandCout,thousandBout,hundredCoutPulse,hundredBoutPulse,incSwOut[3],decSwOut[3],btnU,btnC,targetClk);


quadSevenSeg q7seg(seg,dp,an0,an1,an2,an3,num0,num1,num2,num3,tclk[18]);
endmodule


//synchronizer sync0(sw0,sw[0]);
//synchronizer sync1(sw1,sw[1]);
//synchronizer sync2(sw2,sw[2]);
//synchronizer sync3(sw3,sw[3]);
//synchronizer sync4(sw4,sw[4]);
//synchronizer sync5(sw5,sw[5]);
//synchronizer sync6(sw6,sw[6]);
//synchronizer sync7(sw7,sw[7]);
//singlePulser sp0(p0,sw0);
//singlePulser sp1(p1,sw1);
//singlePulser sp2(p2,sw2);
//singlePulser sp3(p3,sw3);
//singlePulser sp4(p4,sw4);
//singlePulser sp5(p5,sw5);
//singlePulser sp6(p6,sw6);
//singlePulser sp7(p7,sw7);

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 07:11:04 PM
// Design Name: 
// Module Name: incChecker
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


module decChecker(
    output reg [3:0] swOut,
    input [3:0] swIn,
    input [3:0] num0,
    input [3:0] num1,
    input [3:0] num2,
    input [3:0] num3,
    input clk
    );
always @(posedge clk)
begin
    if(num0 == 0 && num1 == 0 && num2 == 0 && num3 == 0) swOut[0] = 0;
    else swOut[0] = swIn[0];
    if(num1 == 0 && num2 == 0 && num3 == 0) swOut[1] = 0;
    else swOut[1] = swIn[1];
    if(num2 == 0 && num3 == 0) swOut[2] = 0;
    else swOut[2] = swIn[2];
    if(num3 == 0) swOut[3] = 0;
    else swOut[3] = swIn[3];
end
endmodule

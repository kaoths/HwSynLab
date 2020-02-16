`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 11:29:29 AM
// Design Name: 
// Module Name: singlePulser
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


module singlePulser(
    output reg q,
    input d,
    input clk
    );
reg [1:0] ns,ps;

always @(posedge clk) ps = ns;

always @(ps)
begin
    if(d == 0) ns = 2'b00;
    if(d == 1)
    begin
        case(ps)
            2'b00: ns = 2'b01;
            2'b01: ns = 2'b10;
            2'b10: ns = 2'b10;
        endcase
    end
    case(ps)
        2'b00: q = 0;
        2'b01: q = 1;
        2'b10: q = 0;
    endcase
end

endmodule

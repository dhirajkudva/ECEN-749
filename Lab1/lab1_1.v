`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2019 03:29:29 PM
// Design Name: 
// Module Name: lab1_1
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

//input and output declaration
module lab1_1(LEDS, SWITCHES,CLK,RESET);
 input [1:0] SWITCHES;
        output [3:0] LEDS;
     //declaring output as register
       reg [3:0] LEDS;
        input CLK;
        input RESET;
   //clkout is the reduced frequency clock cycle and counter is used to reduce the clock frequency 
 
        reg clkout;   
       reg [27:0] counter;
   //block for reducing the clock frequency to 1GHz     
    always@(posedge CLK)
       begin
 
                   counter <= counter + 1;
                   if ( counter == 125_000_000)
                       begin
                           counter <= 0;
                           clkout <= ~clkout;//clkout will toggle only after reaching the 1250000000( indicating 125 Mhz) thus resulting in a clock of 1GHz
                       end
               end
 //counter logic will trigger only at positive edge of clkout
 always @ (posedge clkout )
 begin

        if (RESET ==1)
        LEDS[3:0]=4'b0000; //resetting the LEDS to zero
        if (SWITCHES[0]==1)
        LEDS[3:0]= LEDS[3:0] + 1'b1;//when switch 0 which is up counter switch is pressed, the output is incremented by 1
        if (SWITCHES[1]==1)
        LEDS[3:0]= LEDS[3:0] - 1'b1;//when switch 1 which is down counter switch is pressed, the output is decremented by 1
       
 end       
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2019 12:21:59 PM
// Design Name: 
// Module Name: jackpot
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

//initialization of module
module jackpot(LEDS,SWITCHES,CLOCK,RESET);
 input [3:0] SWITCHES;
        output [3:0] LEDS;
        input CLOCK ;  
        input RESET;
 
 reg [3:0] LEDS;

 reg [27:0] counter;//counter for reducing the internal clock
 reg clkout;//the reduceed clock frequency


//block for reducing the clock frequency
 always @(posedge CLOCK)
 begin
        counter <= counter + 1;
        if ( counter == 125_000_00)      //the number is choosen so that LEDs blink at 10 Hz
              begin
                    counter <= 0;
                    clkout <= ~clkout;//clkout will toggle only after reaching condition value thus resulting in a clock of 10Hz
              end    
 end

//blinking and jackpot block
always @(posedge clkout)
begin
// the blinking of led will continue until a switch is pressed
if (SWITCHES ==4'b0000)
begin
if (LEDS==4'b0000)
begin
       LEDS<=4'b0001;   //initializing LED
       end        
 else  
 begin
    LEDS<=LEDS *2; //blinking the LED by shifting the bits towards right//this is done by mutiplying by 2.
 end
 end
 //this following looop will check the jackpot condition
 //if a particular switch is pressed and the same LED is glowing, then you hit a JACKPOT and all LEDS will glow.
 //if not the blinking will stop
 else
 begin 
 //jackpot condition: All the LEDs will glow only when the switch corresponding to the LED which is glowing is selected                              
    if(SWITCHES==LEDS && LEDS != 4'b0000)
        begin
            LEDS<=4'b1111;
          
          end
 //the reset condition is to restart the game.
    if (RESET)
        LEDS<=4'b0000;
end  
end
endmodule

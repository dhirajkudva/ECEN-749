`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 02:28:05 PM
// Design Name: 
// Module Name: ir_decoder
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


module ir_decoder(
DUT_CLK,RESET,IR_signal, slv_reg0, slv_reg1, slv_reg2, slv_reg3
    );
   
    // Inputs to the DUT
    input DUT_CLK;
    input IR_signal;
    input RESET;
    // Outputs from the DUT
    output  reg [31:0] slv_reg0;
    output reg [31:0]  slv_reg1;
    output reg [31:0]  slv_reg2;
    output reg [31:0] slv_reg3;
    
 //logic to identify start
reg [31:0] counter0, counter1,counterx;
integer x;
reg  [1:0] state, nextstate;
parameter start_begin=2'b00, idle= 2'b01 , init= 2'b10;
initial 
begin
state=2'b00;
x=0;
slv_reg1=0;
end

always @(*)
begin

case (state)
 2'b00: 
        begin
        slv_reg0=0; //hold the latest demodulated message
        //slv_reg1=0;//running count of the number of messages
        slv_reg2=0;
        slv_reg3=0;
        counter0=0;
        counter1=0;
        counterx=0;
               
     nextstate=2'b01;
       
        end
 2'b01:
 begin
    if(IR_signal)
        nextstate=2'b00;
    else
        nextstate=2'b10;
 end     
 
 
 2'b10:
 begin
       
    if(!IR_signal) 
        counterx = counterx + 1;
         
  /*if (IR_signal)
            x=x+1;*/
      
      if(counterx>0 && counterx <1200001)
            begin
            counter0=counter0 + 1;
            slv_reg0[x]=0;
            x=x+1;
            end
        else if (counterx<2400001 && counterx>1200000)
        begin
        counter1=counter1+1;
        slv_reg0[x]=1;  
        x=x+1;
        end  
 else if (counterx>2400000)
      nextstate=2'b00;
      else
      nextstate=2'b10;         
  end
 endcase         
end 
  
always @(posedge DUT_CLK)
begin
if(!RESET)
    state<=start_begin;
    else
    state<=nextstate;

end
    
endmodule

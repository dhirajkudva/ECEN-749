/********************************************************************
 *
 * Andrew Douglass
 * October 17, 2018
 * ir_demod_tb.v
 *
 *******************************************************************/
`timescale 1ns / 1ps

// ENSURE THE FILE NAME BELOW MATCHES YOURS
//`include "ir_decoder.v"

module ir_demod_tb;

// Inputs to the DUT
reg DUT_CLK;
reg IR_signal;
reg RESET;
// Outputs from the DUT
wire [31:0] slv_reg0;
wire [31:0] slv_reg1;
wire [31:0] slv_reg2;
wire [31:0] slv_reg3;

integer i;
integer j;
reg [11:0] test_vec [2:0];
reg [11:0] curr_vec;

// Init the DUT by connecting the ports
ir_decoder_try1 ird0 (
  /*.CLK(DUT_CLK),
  .RST(RESET),
  .ir_signal(IR_signal),
  .slv_reg0(slv_reg0),
  .slv_reg1(slv_reg1),
  .slv_reg2(slv_reg2),
  .slv_reg3(slv_reg3)*/
  DUT_CLK,RESET,IR_signal, slv_reg0, slv_reg1, slv_reg2, slv_reg3
);

initial begin 

  $dumpfile("IrDemodWave.vcd");   // Output the signals to the waveform file
  $dumpvars(0, ir_demod_tb);      // Dump signals in the top module

  // Default assignments to the signals
  DUT_CLK = 1'b0;
  RESET = 1'b0;    // Hold the DUT in reset 
  IR_signal = 1'b1;
  test_vec[0] = 12'b000010010000;
  test_vec[1] = 12'b010010010000;
  test_vec[2] = 12'b000000010000;

  #10000;   // Wait to ensure DUT is properly reset

  RESET = 1'b1;

  #600000; 

  // Iterate through the test vectors 
  for(j = 0; j < 3; j = j + 1) begin 
    curr_vec = test_vec[j];
    IR_signal = 1'b0;
    #2400000;    // Start Bit
    IR_signal = 1'b1;
    for(i = 11; i >= 0; i = i - 1) begin 
      #600000;
      IR_signal = 1'b0;
      if(curr_vec[i] == 1'b1) begin 
        #1200000;
      end
      else begin 
        #600000;
      end
      IR_signal = 1'b1;
    end
    #3000000;    // Spacing between IR signals 
  end

  $finish;

end

// Generate a 50% duty cycle clock with a period of 13.3ns.
// This is a 75MHz clock
always begin
 #(6.667) DUT_CLK <= ~DUT_CLK;
end

endmodule
// ********************************************************************
//
// Copyright (C) 1294-2014, Synopsys Inc.  All Rights Reserved

// This code was generated by Synopsys's Synphony Model Compiler product and
// is intended for use solely by licensed users of this product.

// VERILOG created by Synphony Model Compiler J-2014.09, Build 015R, Aug 22 2014
// Date written:             Wed Nov  1 20:22:24 2017

// ********************************************************************

// Generated from /w/ee.00/abidi/uneeb93/Projects/TASHIP_Project/MATLAB/FixedPointMultiplier.slx Version 1.8 Last modified date Wed Nov 01 12:36:06 2017
//@
module FixedPointMultiplier (
  input clk,
  input GlobalReset,
  input [11:0] WeightPort, // sfix12_En11
  input [0:0] PixelPort, // sfix10_En0
  output [18:0] Output_syn // sfix12_En11
//@
);
//@

wire [11:0] N_1;  
wire [0:0] N_2;  
wire [11:0] N_3;  
wire [0:0] GlobalEnableSignal1;  
wire GlobalResetSel;
  wire GlobalEnable1;
  assign GlobalEnable1 = 1;
  assign GlobalEnableSignal1 = GlobalEnable1;
  assign N_3 = WeightPort;
  assign N_2 = PixelPort;

assign Output_syn = {7'b0000000,N_1};
  generate
  begin: Multiplier_12b_11f_block
    wire        [11:0] tmpOut;
    wire  	    [0:0] tmpin1;
    wire        [11:0] tmpin2;
    wire   	    [0:0] tmpin1_dly;
    wire        [11:0] tmpin2_dly;
    wire        [11:0] med;
    assign med = tmpOut ;
    synDelayWithEnable #( .bitwidth(12), .preferRAMImpl(2), .delaylength(5) ) multOut_block ( .clk(clk), .en(GlobalEnable1), .grst(GlobalResetSel), .rst(1'b0), .inp(med), .outp(N_1) );
    assign tmpin1 = N_2;
    assign tmpin2 = N_3;
    synDelayWithEnable #( .bitwidth(1), .preferRAMImpl(2), .delaylength(1) ) multInp1_block ( .clk(clk), .en(GlobalEnable1), .grst(GlobalResetSel), .rst(1'b0), .inp(tmpin1), .outp(tmpin1_dly) );
    synDelayWithEnable #( .bitwidth(12), .preferRAMImpl(2), .delaylength(1) ) multInp2_block ( .clk(clk), .en(GlobalEnable1), .grst(GlobalResetSel), .rst(1'b0), .inp(tmpin2), .outp(tmpin2_dly) );
    assign tmpOut = tmpin1_dly * tmpin2_dly;
  end // Multiplier_12b_11f_block
  endgenerate
assign GlobalResetSel = GlobalReset;
endmodule

//-----------------------------------------


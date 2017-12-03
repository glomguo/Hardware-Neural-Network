`timescale 1ns/100ps

module testMultiplier();

reg              clk;
reg              GlobalReset;
reg     [11:0]   WeightPort;
reg     [0:0]    PixelPort;
wire    [18:0]   Output_syn;
reg             LSB;

// Outputs
reg     [11:0]  test_port1;
reg     [11:0]  test_port2;
reg	    [20:0]  test_result;
reg     [20:0]  out;


//////////////////////////////////////////////////////////////////////
//  active-high reset 
FixedPointMultiplier multiplier_0(
  .clk,
  .GlobalReset,
  .WeightPort, // sfix19_En18
  .PixelPort, // sfix10_En0
  .Output_syn // sfix26_En18
//@
);

parameter halfclock=1;
parameter fullclock=2*halfclock;
// Oscillate the clock (cycle time is 100*timescales)
always #halfclock clk = ~clk;

initial begin

	GlobalReset = 1'b0;
	clk = 1'b1;

	
	#halfclock ;
	#fullclock GlobalReset=1'b1;
	#fullclock GlobalReset=1'b0;
   
	test_port2 =  12'b0000_0000_0011_0000;
	test_port1 =  1'b1;
	test_result=  19'b0000000_0000_0000_0011_0000;
	//t1 = 26b'11111111111111111110110001;
	
	WeightPort = test_port2;
	PixelPort = test_port1;
	//assign out = test_port2 * test_port1;
	
	#(6*fullclock);
	
	$display("Actual Result is      %b", test_result);
	//$display("Shown Result is       %b", out);
	$display("19bit Adder Result is %b", Output_syn);
	$stop;
end
	
	
    //if(!pat_error)
	//	$display("\nCongratulations!! Your Verilog Code is correct!!\n");
    //else
    //    $display("\nYour Verilog Code has %d errors. \nPlease read alu_out.txt for details.\n",pat_error);
	//#10 $stop;
	

	
endmodule
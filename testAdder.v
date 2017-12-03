`timescale 1ns/100ps

module testAdder();

reg              clk;
reg              GlobalReset;
reg     [18:0]   Port2;
reg     [18:0]   Port1;
wire    [18:0]   Output_syn;


// Outputs
reg     [18:0]  test_port1;
reg     [18:0]  test_port2;
reg	    [18:0]  test_result;


//////////////////////////////////////////////////////////////////////
//  active-high reset 
FixedPointAdder adder_0(
  .clk    ,
  .GlobalReset  ,
  .Port2  , // sfix26_En18
  .Port1  , // sfix26_En18
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
	//Input_Valid = 1'b0;fal = 0; tot = 10;

	
	#halfclock ;
	#fullclock GlobalReset=1'b1;
	#fullclock GlobalReset=1'b0;
   
	test_port1 =  19'b1000_1000_1000_1000_1000_1000_10;
	test_port2 =  19'b0100_0100_0100_0100_0100_0100_01;
	test_result=  19'b1100_1100_1100_1100_1100_1100_11;

	Port2 = test_port2;
	Port1 = test_port1;
	
	#(2*fullclock);
	
	$display("Actual Result is      %b", test_result);
	$display("26bit Adder Result is %b", Output_syn);
	
end
	
	
    //if(!pat_error)
	//	$display("\nCongratulations!! Your Verilog Code is correct!!\n");
    //else
    //    $display("\nYour Verilog Code has %d errors. \nPlease read alu_out.txt for details.\n",pat_error);
	//#10 $stop;
endmodule
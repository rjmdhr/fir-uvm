`include "uvm_macros.svh"
`include "tb_pkg.sv"

// Code your testbench here
// or browse Examples
module top;

	import uvm_pkg::*;
  	import tb_pkg::*;
  
	logic clk;
	logic rst;

 	decimfir_if vif(
      .clk(clk),
      .rst(rst)
    );
  
  	decimfir DUT
	(
		.clk(clk),
		.rst(rst),
     	.data_in(vif.data_in),
      	.data_out(vif.data_out)
	);
  	
  	always begin
      clk = ~clk;
      #10;
    end
  
  	initial begin
      clk = 1;
      rst = 0;
      #1;
      rst = 1;
      //#100;
      //rst = 1;
    end
  
  	initial begin
      	$dumpfile("dump.vcd");
     	$dumpvars;
      	uvm_config_db#(virtual decimfir_if)::set(null, "uvm_test_top", "vif", vif);
      	run_test("filt_test");
    end
  
endmodule: top
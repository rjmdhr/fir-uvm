// Interface: fir_if
interface decimfir_if (
	input clk,
	input rst
);
	logic [7:0] data_in;
  	logic [15:0] data_out;

endinterface: decimfir_if

// Single multiplier decimation MAC FIR filter
// Decimation factor: 10
// Number of coefficients: 10
// Output frequency: (10/10)*(input sample rate)
module decimfir
(
	// signals
	clk,
	rst,
	data_in,
	data_out
);
	input 			clk;
	input  			rst;
	input	[7:0] 	data_in;
  	output	[15:0] 	data_out;
  
  	logic 	[3:0]	coeff_sel;
  	logic 	[7:0]	coeff;
  
  	logic 	[15:0]	prod;
  	logic 	[15:0]	buff_out;
  	logic	[15:0]	out;
  
  	assign prod = coeff*data_in;
  	assign data_out = out;
  	
  	always_comb begin
      	case (coeff_sel)
        	0:	coeff = 1;
          	1:	coeff = 2;
          	2:	coeff =	3;
          	3:	coeff =	4;
          	4:	coeff =	5;
          	5:	coeff =	6;	
          	6:	coeff =	7;
          	7:	coeff =	8;
          	8:	coeff =	9;
          	9:	coeff =	10;
          	default: coeff = 0;
    	endcase
  	end
          
  	always_ff @(posedge clk) begin
      	if (!rst) begin
        	coeff_sel <= 0;
          	buff_out <= 0;
      	end
      	else begin
        	if (coeff_sel == 9) begin
            	coeff_sel <= 0;
              	buff_out <= 0;
              	out <= buff_out + prod;
            end
            else begin
                coeff_sel <= coeff_sel + 1;
                buff_out <= buff_out + prod;
            end
        end
  	end
   
endmodule
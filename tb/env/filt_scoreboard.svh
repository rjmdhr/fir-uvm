typedef int queue_t[$];

class filt_scoreboard extends uvm_subscriber #(filt_seq_item);

  	`uvm_component_utils(filt_scoreboard)
  	local int h_vec[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  	local int x_vec[$] = zeros_queue(10);
	
  	int decimation_factor = 10;
  	int counter;
  	
  	int actual;
  	int num_errors;
  
	// Standard Methods
  	extern function new(string name = "filt_scoreboard", uvm_component parent = null);
    extern function void write(filt_seq_item t);
    extern function void report_phase(uvm_phase phase);
    extern function queue_t zeros_queue(int size);
    extern function int mult_acc(int x_vec[$], int h_vec[]);

endclass
      
function filt_scoreboard::new(string name = "filt_scoreboard", uvm_component parent = null);
  	super.new(name, parent);
  	counter = 0;	
  	actual = 0;
  	num_errors = 0;
endfunction
      
function void filt_scoreboard::write(filt_seq_item t);
  	// when the counter is 0, output data should be updated
  	// calculate convolution before next input transaction comes in
  	if (t.data_out) begin
      	if (counter == 0) begin
          	actual = mult_acc(x_vec, h_vec);
          	`uvm_info("SB", $sformatf("Output data: %d, Actual: %d", t.data_out, actual), UVM_LOW)
          	if (t.data_out != actual) begin
            	num_errors++;
              	`uvm_error("SB", "Mismatch, output data != actual")
            end     	
   		end
  	end
  	// update data queue with new transaction
  	x_vec[1:(x_vec.size-1)] = x_vec[0:x_vec.size-2];
  	x_vec[0] = t.data_in;
  	// update counter to track when output value is updated
  	if (counter < (decimation_factor-1)) counter += 1; else counter = 0;
endfunction
      
function void filt_scoreboard::report_phase(uvm_phase phase);
  if (num_errors == 0)
    `uvm_info("Report Phase", "UVM Test Passed", UVM_LOW)
  else
    `uvm_fatal("Report Phase", "UVM Test Failed")
endfunction
      
// Returns a queue of zeros with size of input parameter
function queue_t filt_scoreboard::zeros_queue(int size);
  	int queue[$];
  	for(int i = 0; i < size; i++)
      queue.push_back(0);
  	return queue;
endfunction

// Convolves an int queue with a coefficient vector h
// The length of both aggregate data types must be the same
function int filt_scoreboard::mult_acc(int x_vec[$], int h_vec[]);
	int value = 0;
  	foreach (h_vec[i])
      value += x_vec[i]*h_vec[h_vec.size-1-i];
  	return value;
endfunction
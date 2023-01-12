// Transaction object that is sent by sequencer to driver
class filt_seq_item extends uvm_sequence_item;

	// UVM Factory Registration Macro
	`uvm_object_utils(filt_seq_item)

	// Data Members (inputs rand, outputs non-rand)
  	rand logic [7:0] data_in;
  	logic [15:0] data_out;

	//constraint c1 {data_in inside {[0:4]};}

	// Standard Methods
	extern function new(string name = "filt_seq_item");
	extern function string convert2str();	

endclass: filt_seq_item

function filt_seq_item::new(string name = "filt_seq_item");
		super.new(name);
endfunction
	
function string filt_seq_item::convert2str();
  	return $sformatf("Input data: %d, Output data: %d", data_in, data_out);
endfunction
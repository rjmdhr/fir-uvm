 class filt_driver extends uvm_driver #(filt_seq_item);

	// UVM Factory Registration Macro
	`uvm_component_utils(filt_driver)

	// Virtual Interface
	virtual decimfir_if vif;

	// Standard Methods
	extern function new(string name = "filt_driver", uvm_component parent = null);
	extern task run_phase(uvm_phase phase);
	extern task drive_item(filt_seq_item item);
	
endclass: filt_driver


function filt_driver::new(string name = "filt_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction

task filt_driver::run_phase(uvm_phase phase);
	filt_seq_item item;
	forever begin
		seq_item_port.get_next_item(item); // get next item from sequencer
		drive_item(item); // execute item
		seq_item_port.item_done(); // consume request
	end
endtask: run_phase

task filt_driver::drive_item(filt_seq_item item);
  	vif.data_in = item.data_in;
  	@(posedge vif.clk);
endtask
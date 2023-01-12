// Class Description: 
class filt_monitor extends uvm_monitor;

	// UVM Factory Registration Macro
	`uvm_component_utils(filt_monitor)

	// Virtual Interface
	virtual decimfir_if vif;
  	uvm_analysis_port #(filt_seq_item) ap;

	// Standard Methods
	extern function new(string name = "filt_monitor", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

function filt_monitor::new(string name = "filt_monitor", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void filt_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
  	ap = new("ap", this);
endfunction

task filt_monitor::run_phase(uvm_phase phase);
	filt_seq_item item;
	forever begin
      	item = filt_seq_item::type_id::create("item");
      	@(posedge vif.clk)
      	item.data_in = vif.data_in;
		item.data_out = vif.data_out;
      	//`uvm_info("MON", $sformatf("Response: %s", item.convert2str()), UVM_LOW)
      	ap.write(item);
	end
endtask
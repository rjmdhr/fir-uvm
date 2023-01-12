// Class Description: Agent
class filt_agent extends uvm_agent;

	// UVM Factory Registration Macro
	`uvm_component_utils(filt_agent)

	// Component Members
	agent_config agt_cfg;
  	uvm_sequencer #(filt_seq_item) sequencer;
  	filt_driver driver;
  	filt_monitor monitor;
	
	// Standard Methods
	extern function new(string name = "filt_agent", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function filt_agent::new(string name = "filt_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void filt_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
  	if(agt_cfg == null) begin
      if(!uvm_config_db #(agent_config)::get(this, "", "agt_config", agt_cfg)) begin
        `uvm_error("BUILD_PHASE", "Unable to find agent config object in the uvm_config_db")
		end
  	end
  	driver = filt_driver::type_id::create("driver", this);
  	monitor = filt_monitor::type_id::create("monitor", this);
  	sequencer = uvm_sequencer #(filt_seq_item)::type_id::create("sequencer", this);
endfunction

function void filt_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  	driver.vif = agt_cfg.vif;
  	monitor.vif = agt_cfg.vif;
    driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction
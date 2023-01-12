// Class Description: Test
class filt_test extends uvm_test;

	// UVM Macro Registration
	`uvm_component_utils(filt_test)

  	agent_config agt_cfg;
  	env_config env_cfg;
  	filt_env env;

	// Standard Methods
	extern function new(string name = "filt_test", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);

endclass: filt_test

function filt_test::new(string name = "filt_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void filt_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
  	agt_cfg = agent_config::type_id::create("agt_cfg");
  	env_cfg = env_config::type_id::create("env_cfg");
 	env = filt_env::type_id::create("env", this);
  
  	env_cfg.agt_cfg = agt_cfg;
  	env.env_cfg = env_cfg;
  		
  if(!uvm_config_db #(virtual decimfir_if)::get(this, "", "vif", agt_cfg.vif)) begin
      	`uvm_error("BUILD_PHASE", "Unable to find virtual vif in the uvm_config_db")
  	end 
endfunction
      
task filt_test::run_phase(uvm_phase phase);
  	filt_seq seq = filt_seq::type_id::create("seq", this);
	phase.raise_objection(this);
  	seq.start(env.agent.sequencer);
	phase.drop_objection(this);
endtask
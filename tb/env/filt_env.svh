// Class Description: Environment
class filt_env extends uvm_env;
	
	// UVM Factory Registration Macro
	`uvm_component_utils(filt_env)

	// Data Members
	filt_agent agent;
  	filt_scoreboard sb;
	env_config env_cfg;

	// Standard Methods
	extern function new(string name = "filt_env", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function filt_env::new(string name = "filt_env", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void filt_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
  	if(env_cfg == null) begin
  		if(!uvm_config_db #(env_config)::get(this, "", "env_cfg", env_cfg)) begin
			`uvm_error("BUILD_PHASE", "Unable to find environment configuration object in the uvm_config_db")
		end
	end
  	sb = filt_scoreboard::type_id::create("sb", this);
	agent = filt_agent::type_id::create("agent", this);
	agent.agt_cfg = env_cfg.agt_cfg;
endfunction

function void filt_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  	agent.monitor.ap.connect(sb.analysis_export);
endfunction
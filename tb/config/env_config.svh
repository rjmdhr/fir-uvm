class env_config extends uvm_object;

  `uvm_object_utils(env_config)

  function new(string name = "filt_env_config");
    super.new(name);
  endfunction

  agent_config agt_cfg;

endclass: env_config
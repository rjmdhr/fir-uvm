class agent_config extends uvm_object;

  `uvm_object_utils(agent_config)

  function new(string name = "agent_config");
    super.new(name);
  endfunction

  virtual decimfir_if vif;

endclass: agent_config
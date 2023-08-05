class dvf_scoreboard #(type DVF_CONFIG = dvf_env_cfg) extends uvm_component;
  `uvm_component_param_utils(dvf_scoreboard #(DVF_CONFIG))

  DVF_CONFIG    cfg;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      monitor_reset();
      sample_resets();
    join_none
  endtask

  virtual task monitor_reset();
  endtask

  virtual task sample_resets();
  endtask

  virtual function void reset(string kind = "normal");
  endfunction

  virtual function void pre_abort();
    super.pre_abort();
  endfunction : pre_abort

endclass
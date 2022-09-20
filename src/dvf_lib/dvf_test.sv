class dvf_test #(type DVF_CONFIG      = dvf_env_cfg,
                 type DVF_ENVIRONMENT = dvf_env) extends uvm_test;
  `uvm_component_param_utils(dvf_test #(DVF_CONFIG, DVF_ENVIRONMENT))

  DVF_ENVIRONMENT        env;
  DVF_CONFIG             cfg;

  `uvm_component_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = DVF_ENVIRONMENT::type_id::create("env", this);
    cfg = DVF_CONFIG::type_id::create("cfg", this);
    uvm_config_db#(DVF_CONFIG)::set(this, "env", "cfg", cfg);
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
  endtask : run_phase

endclass : dv_base_test
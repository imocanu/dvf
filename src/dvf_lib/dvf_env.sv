class dvf_env #(type DVF_ENV_CFG          = dvf_env_cfg,
                type DVF_VIRTUAL_SEQR     = dvf_virtual_sequencer,
                type DVF_SB               = dvf_scoreboard) extends uvm_env;
                
  `uvm_component_param_utils(dvf_env #( DVF_ENV_CFG, 
                                        DVF_VIRTUAL_SEQR, 
                                        DVF_SB))

  DVF_ENV_CFG             cfg;
  DVF_VIRTUAL_SEQUENCER   virtual_sequencer;
  DVF_SB                  scoreboard;

  `uvm_component_new

  virtual function void build_phase(uvm_phase phase);
    string default_ral_name;
    super.build_phase(phase);
    
    if (!uvm_config_db#(DVF_ENV_CFG)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal(`gfn, $sformatf("failed to get %s from uvm_config_db", cfg.get_type_name()))
    end

  endfunction

endclass
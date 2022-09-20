class dvf_virtual_sequencer #(type DVF_CONFIG = dvf_env_cfg) extends uvm_sequencer;
  `uvm_component_param_utils(dvf_virtual_sequencer #(DVF_CONFIG))

  DVF_CONFIG     cfg;

  `uvm_component_new

endclass
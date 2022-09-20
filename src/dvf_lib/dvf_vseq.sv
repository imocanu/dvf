class dvf_vseq #(type DVF_CONFIG               = dvf_env_cfg,
                 type DVF_VIRTUAL_SEQ = dvf_virtual_sequencer) extends uvm_sequence;
  `uvm_object_param_utils(dv_base_vseq #(DVF_CONFIG, DVF_VIRTUAL_SEQ))
  `uvm_declare_p_sequencer(DVF_VIRTUAL_SEQ)

endclass
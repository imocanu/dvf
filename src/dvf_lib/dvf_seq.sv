class dvf_seq #(type DVF_SEQ       = uvm_sequence_item,
                type DVF_RESPONSE  = DVF_SEQ,
                type DVF_CONFIG    = dvf_agent_cfg,
                type DVF_SEQR      = dvf_sequencer) extends uvm_sequence#(DVF_SEQ, DVF_RESPONSE);
  `uvm_object_param_utils(dv_base_seq #(DVF_SEQ, DVF_RESPONSE, DVF_CONFIG, DVF_SEQR))
  `uvm_declare_p_sequencer(DVF_SEQR)

  DVF_CONFIG cfg;

  `uvm_object_new

  task pre_start();
    super.pre_start();
    cfg = p_sequencer.cfg;
  endtask

  task body();
  endtask : body

endclass
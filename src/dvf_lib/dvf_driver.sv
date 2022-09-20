class dvf_driver #(type DVF_SEQ_ITEM       = uvm_sequence_item,
                   type DVF_CONFIG         = dvf_agent_cfg,
                   type DVF_RESPONSE_ITEM  = DVF_SEQ_ITEM)
  extends uvm_driver #(.REQ(DVF_SEQ_ITEM), .RSP(DVF_RESPONSE_ITEM));

  `uvm_component_param_utils(dv_base_driver #(.DVF_SEQ_ITEM      (DVF_SEQ_ITEM),
                                              .DVF_CONFIG        (DVF_CONFIG),
                                              .DVF_RESPONSE_ITEM (DVF_RESPONSE_ITEM)))

  `uvm_component_new

  virtual task run_phase(uvm_phase phase);
    fork
      get_and_drive();
    join
  endtask

  virtual task get_and_drive();
    `uvm_fatal(`gfn, "get_and_drive()")
  endtask

endclass
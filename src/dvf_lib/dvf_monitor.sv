class dvf_monitor #(type DVF_ITEM     = uvm_sequence_item,
                    type DVF_ITEM_REQ = DVF_ITEM,
                    type DVF_ITEM_RSP = DVF_ITEM,
                    type DVF_CONFIG   = dv_base_agent_cfg) extends uvm_monitor;
  `uvm_component_param_utils(dvf_monitor #(DVF_ITEM, DVF_CONFIG))

  DVF_CONFIG cfg;

  protected bit ok_to_end = 1;
  protected bit phase_ready_to_end_invoked = 0;

  uvm_analysis_port #(DVF_ITEM)     analysis_port;
  uvm_analysis_port #(DVF_ITEM_REQ) req_analysis_port;
  uvm_analysis_port #(DVF_ITEM_RSP) rsp_analysis_port;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_port = new("analysis_port", this);
    req_analysis_port = new("req_analysis_port", this);
    rsp_analysis_port = new("rsp_analysis_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    fork
      collect_trans(phase);
    join
  endtask

  // collect transactions forever
  virtual protected task collect_trans(uvm_phase phase);
    `uvm_fatal(`gfn, "collect_trans()")
  endtask

endclass

class dvf_sequencer #(type DVF_ITEM       = uvm_sequence_item,
                      type DVF_CONFIG     = dv_agent_cfg,
                      type DVF_RESPONSE   = DVF_ITEM)
  extends uvm_sequencer #(.DVF_ITEM(DVF_ITEM), .DVF_RESPONSE(DVF_RESPONSE));

  `uvm_component_param_utils(dvf_sequencer #(.DVF_ITEM     (DVF_ITEM),
                                             .DVF_CONFIG   (DVF_CONFIG),
                                             .DVF_RESPONSE (DVF_RESPONSE)))

  uvm_tlm_analysis_fifo #(DVF_ITEM)     req_analysis_fifo;
  uvm_tlm_analysis_fifo #(DVF_RESPONSE) rsp_analysis_fifo;

  DVF_CONFIG cfg;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (cfg.has_req_fifo) req_analysis_fifo = new("req_analysis_fifo", this);
    if (cfg.has_rsp_fifo) rsp_analysis_fifo = new("rsp_analysis_fifo", this);
  endfunction : build_phase

endclass
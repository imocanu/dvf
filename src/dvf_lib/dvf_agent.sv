class dvf_agent #(type DVF_CFG            = dvf_agent_cfg,
                  type DVF_DRV            = dvf_driver,
                  type DVF_HOST_DRV       = DVF_DRV,
                  type DVF_DEVICE_DRV     = DVF_DRV,
                  type DVF_SEQR           = dvf_sequencer,
                  type DVF_MON            = dvf_monitor) extends uvm_agent;

  `uvm_component_param_utils(dvf_agent #(DVF_CFG, 
                                         DVF_DRV, 
                                         DVF_HOST_DRV, 
                                         DVF_DEVICE_DRV,
                                         DVF_SEQR, 
                                         DVF_MON))

  DVF_CFG   cfg;
  DVF_DRV   driver;
  DVF_SEQR  sequencer;
  DVF_MON   monitor;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(DVF_CFG)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal(`gfn, $sformatf("failed to get %s from uvm_config_db", cfg.get_type_name()))
    end
    `uvm_info(`gfn, $sformatf("\n%0s", cfg.sprint()), UVM_HIGH)

    monitor = DVF_MON::type_id::create("monitor", this);
    monitor.cfg = cfg;
    monitor.cov = cov;

    if (cfg.is_active) begin
      sequencer = DVF_SEQR::type_id::create("sequencer", this);
      sequencer.cfg = cfg;

      if (cfg.has_driver) begin
        if (cfg.if_mode == Host)  driver = DVF_HOST_DRV::type_id::create("driver", this);
        else                      driver = DVF_DEVICE_DRV::type_id::create("driver", this);
        driver.cfg = cfg;
      end
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (cfg.is_active && cfg.has_driver) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction

endclass
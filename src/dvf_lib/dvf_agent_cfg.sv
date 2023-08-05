class dvf_agent_cfg extends uvm_object;

  bit         agent_state = 1'b1;   
  bit         has_driver  = 1'b1;
  bit         has_request_fifo = 1'b0;
  bit         has_respond_fifo = 1'b0;

  `uvm_object_utils_begin(dvf_agent_cfg)
    `uvm_field_int (agent_state,         UVM_DEFAULT)
    `uvm_field_int (has_driver,          UVM_DEFAULT)
    `uvm_field_int (has_request_fifo,    UVM_DEFAULT)
    `uvm_field_int (has_respond_fifo,    UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "dvf_agent_cfg");
    super.new(name);
  endfunction

  //`uvm_object_new

endclass
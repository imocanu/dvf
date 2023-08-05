class dvf_env_cfg extends uvm_object;

  bit is_active         = 1;
  bit en_scb            = 1; 

  `uvm_object_utils_begin(dvf_env_cfg)
    `uvm_field_int   (is_active,   UVM_DEFAULT)
    `uvm_field_int   (en_scb,      UVM_DEFAULT)
  `uvm_object_utils_end

  // `uvm_object_new
  function new(string name = "dvf_env_cfg");
    super.new(name);
  endfunction

endclass
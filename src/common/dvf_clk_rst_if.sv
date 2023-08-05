interface dvf_clk_rst_if #(
  parameter string dvf_debug = "clk_if"
) (
  inout clk,
  inout rst_n
);

  bit drive_clk;
  logic o_clk;
  bit drive_rst_n;
  logic o_rst_n;
  bit clk_gate = 1'b0;
  int clk_period_ps = 20_000;
  int clk_freq_scaling_pc = 0;
  int clk_freq_scaling_chance_pc = 50;
  bit clk_freq_scale_up = 1'b0;
  real clk_freq_mhz = 50;
  bit recompute = 1'b1;
  int clk_hi_ps;
  int clk_lo_ps;
  real clk_hi_modified_ps;
  real clk_lo_modified_ps;
  bit sole_clock = 1'b0;

  int counter = 0;

 
  string msg_id = $sformatf("[%m(dvf_clk_rst_if):%s]", dvf_debug);

  clocking cb @(posedge clk);
  endclocking

  clocking cbn @(negedge clk);
  endclocking

  task automatic wait_clks(int num_clks);
    repeat (num_clks) @cb;
  endtask

  task automatic wait_n_clks(int num_clks);
    repeat (num_clks) @cbn;
  endtask

  task automatic wait_clks_or_rst(int num_clks);
    fork
      wait_clks(num_clks);
      wait_for_reset(.wait_negedge(1'b1), .wait_posedge(1'b0));
    join_any
  endtask

  task automatic wait_for_reset(bit wait_negedge = 1'b1, bit wait_posedge = 1'b1);
    if (wait_negedge && ($isunknown(rst_n) || rst_n === 1'b1)) @(negedge rst_n);
    if (wait_posedge && (rst_n === 1'b0)) @(posedge rst_n);
  endtask

  function automatic void set_freq_khz(int freq_khz);
    clk_freq_mhz = $itor(freq_khz) / 1000;
    clk_period_ps = 1000_000 / clk_freq_mhz;
    recompute = 1'b1;
  endfunction

  function automatic void set_freq_mhz(int freq_mhz);
    set_freq_khz(freq_mhz * 1000);
  endfunction

  function automatic void set_active(bit drive_clk_val = 1'b1, bit drive_rst_n_val = 1'b1);
    drive_clk = drive_clk_val;
    drive_rst_n = drive_rst_n_val;
  endfunction

  task automatic start_clk(bit wait_for_posedge = 1'b0);
    clk_gate = 1'b0;
    if (wait_for_posedge) wait_clks(1);
  endtask


  function automatic void stop_clk();
    clk_gate = 1'b1;
  endfunction

  task automatic drive_rst_pin(logic val = 1'b0);
    o_rst_n = val;
  endtask

 task automatic apply_reset(int pre_reset_dly_clks   = 0,
                             integer reset_width_clks = 'x,
                             int post_reset_dly_clks  = 0,
                             int rst_n_scheme         = 1);
    int dly_ps;
    if ($isunknown(reset_width_clks)) reset_width_clks = $urandom_range(50, 100);
    dly_ps = $urandom_range(0, clk_period_ps);
    wait_clks(pre_reset_dly_clks);
    case (rst_n_scheme)
      0: begin : sync_assert_deassert
        o_rst_n <= 1'b0;
        wait_clks(reset_width_clks);
        o_rst_n <= 1'b1;
      end
      1: begin : async_assert_sync_deassert
        #(dly_ps * 1ps);
        o_rst_n <= 1'b0;
        wait_clks(reset_width_clks);
        o_rst_n <= 1'b1;
      end
      2: begin : async_assert_async_deassert
        #(dly_ps * 1ps);
        o_rst_n <= 1'b0;
        wait_clks(reset_width_clks);
        dly_ps = $urandom_range(0, clk_period_ps);
        #(dly_ps * 1ps);
        o_rst_n <= 1'b1;
      end
      default: begin
        //`dv_fatal($sformatf("rst_n_scheme %0d not supported", rst_n_scheme), msg_id)
      end
    endcase
    wait_clks(post_reset_dly_clks);
  endtask

  initial begin
    bit done;
    fork
      begin
        wait_for_reset(.wait_posedge(1'b0));

        #1ps;
        o_clk = 1'b0;

        done = 1'b1;
      end
      while (!done) #(clk_period_ps * 1ps);
    join

    forever begin
      #10 o_clk = ~o_clk;
      counter = counter +1;
    end
  end

  assign clk   = drive_clk   ? o_clk   : 1'bz;
  assign rst_n = drive_rst_n ? o_rst_n : 1'bz;

endinterface

module top;
    wire clk, rstn;

    dvf_clk_rst_if     axi_clk_if(.clk(clk), .rst_n(rstn));
    axi_ram     dut(.clk(clk), .rst(~rstn));

    always @(posedge clk) begin : counter1
        // $monitor($time,"clk =%d",axi_clk_if.counter);    

        if (axi_clk_if.counter > 100000) begin
            $finish;
        end

    end : counter1


    initial begin

        axi_clk_if.set_active();
        fork
            axi_clk_if.apply_reset(.reset_width_clks (5));
        join_none


    end
    
endmodule
`timescale 1ns/1ps
module aes_top();
    import uvm_pkg::*;
    import aes_pack::*;
    `include "uvm_macros.svh"

    aes_inf in1();

    AES_Encrypt DUT(in1.in, in1.key, in1.out);

    initial begin
        uvm_config_db#(virtual aes_inf)::set(null, "uvm_test_top", "my_vif", in1);
        run_test("aes_test");
    end
endmodule
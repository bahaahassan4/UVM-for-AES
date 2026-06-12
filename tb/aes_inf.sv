interface aes_inf();

    logic [127:0]  in;
    logic [127:0]  key;
    logic [127:0]  out;

    modport aes_if (
        input  in,
        input  key,
        output out
    );

    // Has no clock, so there is no clocking block
endinterface
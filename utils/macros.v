`define assert(sig, val) \
    if (sig !== val) begin \
        $display("ASSERTION FAILED in %m: sig != %0d [original value %0d] in line %0d", val, sig, `__LINE__); \
        $finish; \
    end
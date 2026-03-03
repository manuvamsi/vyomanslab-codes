module Testbench;

    reg clk;
    reg rst;
    wire [3:0] out;

    // Instantiate the design under test
    Mycounter uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Dump waves for GTKWave
        $dumpfile("count.vcd");
        $dumpvars(0, Testbench);

        // Initialize inputs
        rst = 1;

        // Wait 20ns and release reset
        #20;
        rst = 0;

        // Run simulation for some time
        #200;

        // Finish simulation
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%t | rst=%b | out=%d", $time, rst, out);
    end

endmodule

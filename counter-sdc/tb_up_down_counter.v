`timescale 1ns/1ps

module tb_up_down_counter;

    reg clk;
    reg reset_n;
    reg up_down;
    wire [3:0] count;

    // Instantiate DUT (Device Under Test)
    up_down_counter dut (
        .clk(clk),
        .reset_n(reset_n),
        .up_down(up_down),
        .count(count)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Dump waveform (for GTKWave / Questa / VCS etc.)
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_up_down_counter);

        // Initialize signals
        clk = 0;
        reset_n = 0;
        up_down = 0;

        // Hold reset for few cycles
        #20;
        reset_n = 1;

        // Count UP for some cycles
        up_down = 1;
        #100;

        // Count DOWN for some cycles
        up_down = 0;
        #100;

        // Toggle direction
        up_down = 1;
        #50;
        up_down = 0;
        #50;

        // End simulation
        $finish;
    end

    // Monitor values in console
    initial begin
        $monitor("Time=%0t | reset_n=%b | up_down=%b | count=%d",
                  $time, reset_n, up_down, count);
    end

endmodule

// Testbench for Synthesizable Traffic Light Controller
`timescale 1ns/1ps

module TSC_tb;

    // Inputs
    reg X;
    reg clock;
    reg clear;

    // Outputs
    wire [1:0] hwy;
    wire [1:0] cntry;

    // Light names for display
    function [8*6:1] light_name;
        input [1:0] val;
        begin
            case (val)
                2'd0: light_name = "RED   ";
                2'd1: light_name = "YELLOW";
                2'd2: light_name = "GREEN ";
                default: light_name = "UNKNWN";
            endcase
        end
    endfunction

    // Instantiate the sig_control module
    sig_control uut (
        .clock(clock),
        .clear(clear),
        .X(X),
        .hwy(hwy),
        .cntry(cntry)
    );

    // Clock generation: 10ns period
    initial clock = 0;
    always #5 clock = ~clock;

    // Test scenario
    initial begin
        // Dump waveforms
        $dumpfile("t.vcd");
        $dumpvars(0, TSC_tb);

        // Initialize
        X = 0;
        clear = 1;
        
        // Release reset after 20ns
        #20 clear = 0;

        // Stay in S0 (hwy GREEN) for a while
        #50;

        // Car arrives on country road
        X = 1;
        #10;

        // S1 (hwy YELLOW) -> waits Y2RDELAY=3 clocks
        // S2 (both RED)    -> waits R2GDELAY=2 clocks
        // S3 (cntry GREEN) -> stays while X=1
        #80;

        // Car leaves country road
        X = 0;
        #10;

        // S4 (cntry YELLOW) -> waits Y2RDELAY=3 clocks
        // Back to S0 (hwy GREEN)
        #60;

        // Another cycle
        X = 1;
        #100;
        X = 0;
        #80;

        // Test reset mid-operation
        X = 1;
        #30;
        clear = 1;
        #20;
        clear = 0;
        #50;

        $display("=== Simulation Complete ===");
        $finish;
    end

    // Monitor (hwy/cntry: 0=RED, 1=YELLOW, 2=GREEN)
    initial begin
        $monitor("t=%0t | X=%b clear=%b | hwy=%0d cntry=%0d | state=%0d",
                 $time, X, clear, hwy, cntry, uut.state);
    end

endmodule

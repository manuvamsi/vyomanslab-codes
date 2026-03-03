`timescale 1ns/1ps

module tb_traffic_light;

    reg clk;
    reg rst;
    wire red, yellow, green;

    // Instantiate Traffic Light Controller
    traffic_light uut (
        .clk(clk),
        .rst(rst),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Test Sequence
    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb_traffic_light);

        // Reset
        rst = 1;
        #20;
        rst = 0;

        // Run for enough transitions (cycle is ~4*10ns * 3 states = ~120ns)
        #500;
        
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | rst=%b | State(R,Y,G) = %b,%b,%b", $time, rst, red, yellow, green);
    end

endmodule

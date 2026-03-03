// Synthesizable Traffic Light Controller (Highway & Country Road)
// 5-state FSM with counter-based delays
// HWY: GREEN -> YELLOW -> RED
// CNTRY: RED -> GREEN -> YELLOW

module sig_control (
    input wire clock,
    input wire clear,
    input wire X,
    output reg [1:0] hwy,
    output reg [1:0] cntry
);

    // Light encodings
    parameter RED    = 2'd0;
    parameter YELLOW = 2'd1;
    parameter GREEN  = 2'd2;

    // State encodings
    //                          HWY      CNTRY
    parameter S0 = 3'd0;    // GREEN    RED
    parameter S1 = 3'd1;    // YELLOW   RED     (wait Y2RDELAY clocks)
    parameter S2 = 3'd2;    // RED      RED     (wait R2GDELAY clocks)
    parameter S3 = 3'd3;    // RED      GREEN
    parameter S4 = 3'd4;    // RED      YELLOW  (wait Y2RDELAY clocks)

    // Delay parameters (in clock cycles)
    parameter Y2RDELAY = 3;  // Yellow to Red delay
    parameter R2GDELAY = 2;  // Red to Green delay

    reg [2:0] state, next_state;
    reg [2:0] count, next_count;

    // Sequential: state and counter register
    always @(posedge clock) begin
        if (clear) begin
            state <= S0;
            count <= 3'd0;
        end else begin
            state <= next_state;
            count <= next_count;
        end
    end

    // Combinational: next state and next count logic
    always @(*) begin
        next_state = state;
        next_count = 3'd0;

        case (state)
            S0: begin
                if (X)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin  // YELLOW on hwy, wait Y2RDELAY clocks
                if (count == Y2RDELAY - 1) begin
                    next_state = S2;
                    next_count = 3'd0;
                end else begin
                    next_state = S1;
                    next_count = count + 1;
                end
            end

            S2: begin  // RED on both, wait R2GDELAY clocks
                if (count == R2GDELAY - 1) begin
                    next_state = S3;
                    next_count = 3'd0;
                end else begin
                    next_state = S2;
                    next_count = count + 1;
                end
            end

            S3: begin
                if (!X)
                    next_state = S4;
                else
                    next_state = S3;
            end

            S4: begin  // YELLOW on cntry, wait Y2RDELAY clocks
                if (count == Y2RDELAY - 1) begin
                    next_state = S0;
                    next_count = 3'd0;
                end else begin
                    next_state = S4;
                    next_count = count + 1;
                end
            end

            default: next_state = S0;
        endcase
    end

    // Output logic: decode state to light signals
    always @(*) begin
        hwy   = GREEN;
        cntry = RED;

        case (state)
            S0: begin
                hwy   = GREEN;
                cntry = RED;
            end
            S1: begin
                hwy   = YELLOW;
                cntry = RED;
            end
            S2: begin
                hwy   = RED;
                cntry = RED;
            end
            S3: begin
                hwy   = RED;
                cntry = GREEN;
            end
            S4: begin
                hwy   = RED;
                cntry = YELLOW;
            end
            default: begin
                hwy   = GREEN;
                cntry = RED;
            end
        endcase
    end

endmodule

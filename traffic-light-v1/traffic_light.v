module traffic_light (
    input clk,
    input rst,
    output reg red,
    output reg yellow,
    output reg green
);

    // State Encoding
    parameter S_RED    = 2'b00;
    parameter S_GREEN  = 2'b01;
    parameter S_YELLOW = 2'b10;

    reg [1:0] current_state, next_state;
    
    // Timer to stay in each state for a bit (simplified)
    reg [2:0] count;

    // State Transition Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S_RED;
            count <= 0;
        end else begin
            // Simple timer: change state every 4 clocks
            if (count == 3) begin
                count <= 0;
                current_state <= next_state;
            end else begin
                count <= count + 1;
            end
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            S_RED:    next_state = S_GREEN;
            S_GREEN:  next_state = S_YELLOW;
            S_YELLOW: next_state = S_RED;
            default:  next_state = S_RED;
        endcase
    end

    // Output Logic
    always @(*) begin
        red    = 0;
        yellow = 0;
        green  = 0;
        case (current_state)
            S_RED:    red    = 1;
            S_GREEN:  green  = 1;
            S_YELLOW: yellow = 1;
        endcase
    end

endmodule

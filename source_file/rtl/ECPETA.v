`include "full_adder.v"
// Error-Correcting Parallel Prefix Adder with Two-Level Carry Estimation
// https://www.mdpi.com/2079-9292/9/3/471
module RCA #(parameter N = 8)
            (X,
             Y,
             Ci,
             Sum,
             Co);
    input [N-1:0] X; // Two N-bit inputs
    input [N-1:0] Y; // Two N-bit inputs
    input Ci;
    output wire [N-1:0] Sum;
    output wire Co;
    wire [N-2:0] w; // Intermediate carry wires
    genvar i;
    
    generate
    for (i = 0; i < N; i = i + 1) begin : adder_stage
    if (i == 0) begin
        full_adder FA(.cin({X[0], Y[0], Ci}),.Cout(w[0]),.S(Sum[0]));// First stage with carry-in = 0
    end
    else if (i == N-1) begin
        full_adder FA(.cin({X[N-1], Y[N-1], w[N-2]}),.Cout(Co),.S(Sum[N-1]));// Last stage with final carry-out
    end
    else begin
        full_adder FA(.cin({X[i], Y[i], w[i-1]}),.Cout(w[i]),.S(Sum[i]));// Intermediate stages
    end
    end
    endgenerate
endmodule
    
    
    module ECPETA #(parameter TOTAL_BITS = 16,           // Total bit width of operands
        parameter HIGH_PART_BITS = 8)
        (input [TOTAL_BITS-1:0] operand_a,     // First operand
        input [TOTAL_BITS-1:0] operand_b,    // Second operand
        output [TOTAL_BITS-1:0] sum_result); // Sum result
        
        //----------------------------------------------------------
        // Structural Definitions
        //----------------------------------------------------------
        wire high_part_carry_out;  // Carry from high-order part
        
        // Low-order part signals
        wire carry_estimate;        // Estimated carry from low-order part
        wire pre_carry_high;        // Pre-calculation for carry estimation
        wire pre_carry_low;         // Pre-calculation for carry estimation
        wire carry_estimate_inv;    // Inverted carry estimate
        
        // Parallel prefix adder signals
        wire [TOTAL_BITS-HIGH_PART_BITS-4:0] gen_chain;  // Generate chain
        wire [TOTAL_BITS-HIGH_PART_BITS-4:0] prop_chain; // Propagate chain
        wire [TOTAL_BITS-HIGH_PART_BITS-4:0] carry_chain;// Carry chain
        
        //----------------------------------------------------------
        // Carry Estimation Logic (Two-Level)
        //----------------------------------------------------------
        // Level 1: Key position calculations
        assign pre_carry_low = operand_a[TOTAL_BITS-HIGH_PART_BITS-2] &
        operand_b[TOTAL_BITS-HIGH_PART_BITS-2];
        
        assign pre_carry_high = operand_a[TOTAL_BITS-HIGH_PART_BITS-1] &
        operand_b[TOTAL_BITS-HIGH_PART_BITS-1];
        
        // Final carry estimate for high-order part
        assign carry_estimate = pre_carry_low | pre_carry_high;
        
        //----------------------------------------------------------
        // Low-Order Part Processing (Parallel Prefix Network)
        //----------------------------------------------------------
        // Stage 0: Special case for sum[TOTAL_BITS-HIGH_PART_BITS-1]
        assign carry_estimate_inv = ~(operand_a[TOTAL_BITS-HIGH_PART_BITS-1] |
        operand_b[TOTAL_BITS-HIGH_PART_BITS-1]);
        assign sum_result[TOTAL_BITS-HIGH_PART_BITS-1] = ~(carry_estimate_inv | carry_estimate);
        
        // Stage 1: Special case for sum[TOTAL_BITS-HIGH_PART_BITS-2]
        assign sum_result[TOTAL_BITS-HIGH_PART_BITS-2] = operand_a[TOTAL_BITS-HIGH_PART_BITS-2] |
        operand_b[TOTAL_BITS-HIGH_PART_BITS-2];
        
        // Stage 2: Initialize carry chain for parallel prefix
        assign prop_chain[TOTAL_BITS-HIGH_PART_BITS-4] = operand_a[TOTAL_BITS-HIGH_PART_BITS-3] |
        operand_b[TOTAL_BITS-HIGH_PART_BITS-3];
        
        assign gen_chain[TOTAL_BITS-HIGH_PART_BITS-4] = operand_a[TOTAL_BITS-HIGH_PART_BITS-3] &
        operand_b[TOTAL_BITS-HIGH_PART_BITS-3];
        
        assign sum_result[TOTAL_BITS-HIGH_PART_BITS-3]  = pre_carry_low | prop_chain[TOTAL_BITS-HIGH_PART_BITS-4];
        assign carry_chain[TOTAL_BITS-HIGH_PART_BITS-4] = pre_carry_low | gen_chain[TOTAL_BITS-HIGH_PART_BITS-4];
        
        //----------------------------------------------------------
        // Parallel Prefix Network Generation
        //----------------------------------------------------------
        genvar bit_idx;
        generate
        for (bit_idx = TOTAL_BITS-HIGH_PART_BITS-4; bit_idx > 0; bit_idx = bit_idx - 1)
            begin : prefix_network
            // Propagate/generate for current bit pair
            assign prop_chain[bit_idx-1] = operand_a[bit_idx] | operand_b[bit_idx];
            assign gen_chain[bit_idx-1]  = operand_a[bit_idx] & operand_b[bit_idx];
        
        // Sum calculation
        assign sum_result[bit_idx] = prop_chain[bit_idx-1] | carry_chain[bit_idx];
        
        // Carry propagation
        assign carry_chain[bit_idx-1] = carry_chain[bit_idx] | gen_chain[bit_idx-1];
        end
        endgenerate
        
        //----------------------------------------------------------
        // Final Stage Processing
        //----------------------------------------------------------
        assign sum_result[0] = (operand_a[0] | operand_b[0]) | carry_chain[0];
        
        //----------------------------------------------------------
        // High-Order Part Processing (Ripple Carry Adder)
        //----------------------------------------------------------
        RCA #(.N(HIGH_PART_BITS)) high_order_adder (
        .X  (operand_a[TOTAL_BITS-1 -: HIGH_PART_BITS]),  // High-order part of A
        .Y  (operand_b[TOTAL_BITS-1 -: HIGH_PART_BITS]),  // High-order part of B
        .Ci (carry_estimate),                             // Carry from low-order part
        .Sum  (sum_result[TOTAL_BITS-1 -: HIGH_PART_BITS]), // High-order sum
        .Co (high_part_carry_out)                         // Final carry (unused)
        );
        
    endmodule
        

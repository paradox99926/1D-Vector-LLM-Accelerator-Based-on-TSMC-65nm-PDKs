`timescale 1ns / 1ps

module Controller(clk,
                  reset,
                  inst,
                  s_axi_awid,
                  s_axi_awaddr,
                  s_axi_awlen,
                  s_axi_awsize,
                  s_axi_awburst,
                  s_axi_awlock,
                  s_axi_awcache,
                  s_axi_awprot,
                  s_axi_awqos,
                  s_axi_awregion,
                  s_axi_awuser,
                  s_axi_awvalid,
                  s_axi_awready,
                  s_axi_wdata,
                  s_axi_wstrb,
                  s_axi_wlast,
                  s_axi_wuser,
                  s_axi_wvalid,
                  s_axi_wready,
                  s_axi_bid,
                  s_axi_bresp,
                  s_axi_buser,
                  s_axi_bvalid,
                  s_axi_bready,
                  s_axi_arid,
                  s_axi_araddr,
                  s_axi_arlen,
                  s_axi_arsize,
                  s_axi_arburst,
                  s_axi_arlock,
                  s_axi_arcache,
                  s_axi_arprot,
                  s_axi_arqos,
                  s_axi_arregion,
                  s_axi_aruser,
                  s_axi_arvalid,
                  s_axi_arready,
                  s_axi_rid,
                  s_axi_rdata,
                  s_axi_rresp,
                  s_axi_rlast,
                  s_axi_ruser,
                  s_axi_rvalid,
                  s_axi_rready);
    parameter DATA_WIDTH      = 32; // Width of data bus in bits
    parameter ADDR_WIDTH      = 16;// Width of address bus in bits
    parameter STRB_WIDTH      = (DATA_WIDTH/8);// Width of wstrb (width of data bus in words)
    parameter ID_WIDTH        = 8;// Width of ID signal
    parameter AWUSER_ENABLE   = 0;// Propagate awuser signal
    parameter AWUSER_WIDTH    = 1;// Width of awuser signal
    parameter WUSER_ENABLE    = 0;// Propagate wuser signal
    parameter WUSER_WIDTH     = 1;// Width of wuser signal
    parameter BUSER_ENABLE    = 0;// Propagate buser signal
    parameter BUSER_WIDTH     = 1;// Width of buser signal
    parameter ARUSER_ENABLE   = 0;// Propagate aruser signal
    parameter ARUSER_WIDTH    = 1;// Width of aruser signal
    parameter RUSER_ENABLE    = 0;// Propagate ruser signal
    parameter RUSER_WIDTH     = 1;// Width of ruser signal
    parameter AUSER_WIDTH     = (ARUSER_ENABLE && (!AWUSER_ENABLE || ARUSER_WIDTH > AWUSER_WIDTH)) ? ARUSER_WIDTH : AWUSER_WIDTH;// Width of auser output
    parameter PIPELINE_OUTPUT = 0; // Extra pipeline register on output
    parameter INTERLEAVE      = 0;// Interleave read and write burst cycles
    parameter total_cycle     = 8;// how many streamed Q vectors will be processed
    parameter bw              = 8;// Q & K vector bit precision
    parameter bw_psum         = 2*bw+4;// partial sum bit precision
    parameter pr              = 8;// how many products added in each dot product
    parameter cor             = 2;
    parameter col             = 8;// how many dot product units are equipped
    parameter RESET_CYCLES    = 2;
    
    input wire clk;
    input wire reset;
    output [20:0] inst;
    //write address response
    input wire [ID_WIDTH-1:0] s_axi_awid;
    input wire [ADDR_WIDTH-1:0] s_axi_awaddr;
    input wire [7:0] s_axi_awlen;
    input wire [2:0] s_axi_awsize;
    input wire [1:0] s_axi_awburst;
    input wire s_axi_awlock;
    input wire [3:0] s_axi_awcache;
    input wire [2:0] s_axi_awprot;
    input wire [3:0] s_axi_awqos;
    input wire [3:0] s_axi_awregion;
    input wire [AWUSER_WIDTH-1:0] s_axi_awuser;
    input wire s_axi_awvalid;
    output wire s_axi_awready;
    //write data response
    input wire [DATA_WIDTH-1:0] s_axi_wdata;
    input wire [STRB_WIDTH-1:0] s_axi_wstrb;
    input wire s_axi_wlast;
    input wire [WUSER_WIDTH-1:0] s_axi_wuser;
    input wire s_axi_wvalid;
    output wire s_axi_wready;
    //write response
    output wire [ID_WIDTH-1:0] s_axi_bid;
    output wire [1:0] s_axi_bresp;
    output wire [BUSER_WIDTH-1:0] s_axi_buser;
    output wire s_axi_bvalid;
    input wire s_axi_bready;
    //read address response
    input wire [ID_WIDTH-1:0] s_axi_arid;
    input wire [ADDR_WIDTH-1:0] s_axi_araddr;
    input wire [7:0] s_axi_arlen;
    input wire [2:0] s_axi_arsize;
    input wire [1:0] s_axi_arburst;
    input wire s_axi_arlock;
    input wire [3:0] s_axi_arcache;
    input wire [2:0] s_axi_arprot;
    input wire [3:0] s_axi_arqos;
    input wire [3:0] s_axi_arregion;
    input wire [ARUSER_WIDTH-1:0] s_axi_aruser;
    input wire s_axi_arvalid;
    output wire s_axi_arready;
    //read data response
    output wire [ID_WIDTH-1:0] s_axi_rid;
    output wire [DATA_WIDTH-1:0] s_axi_rdata;
    output wire [1:0] s_axi_rresp;
    output wire s_axi_rlast;
    output wire [RUSER_WIDTH-1:0] s_axi_ruser;
    output wire s_axi_rvalid;
    input wire s_axi_rready;
    
    // State definitions
    localparam [3:0] IDLE = 4'd0,
    READING_RESULT = 4'd1,
    WRITING_Q = 4'd2,
    WRITING_K = 4'd3,
    LOAD_K = 4'd4,
    EXECUTE = 4'd5,
    FIFO_READ = 4'd6,
    NORM = 4'd7;
    
    
    reg [3:0] current_state;
    reg [3:0] next_state;
    reg [7:0] counter;
    
    reg START;
    reg WRITING_Q_DONE;
    reg WRITING_K_DONE;
    reg LOAD_K_DONE;
    reg EXECUTE_DONE;
    reg FIFO_READ_DONE;
    reg NORM_DONE;
    reg READING_RESULT_DONE;
    
    reg sfp_sel         = 0;
    reg sfp_wr2pmem     = 0;
    reg acc             = 0;
    reg div             = 0;
    reg fifo_ext_rd     = 0;
    reg ofifo_rd        = 0;
    reg qmem_rd         = 0;
    reg qmem_wr         = 0;
    reg kmem_rd         = 0;
    reg kmem_wr         = 0;
    reg pmem_rd         = 0;
    reg pmem_wr         = 0;
    reg execute         = 0;
    reg load            = 0;
    reg [3:0] qkmem_add = 0;
    reg [3:0] pmem_add  = 0;
    
    assign inst[20]    = sfp_sel;
    assign inst[19]    = div;
    assign inst[18]    = acc;
    assign inst[17]    = sfp_wr2pmem;
    assign inst[16]    = ofifo_rd;
    assign inst[15:12] = qkmem_add;
    assign inst[11:8]  = pmem_add;
    assign inst[7]     = execute;
    assign inst[6]     = load;
    assign inst[5]     = qmem_rd;
    assign inst[4]     = qmem_wr;
    assign inst[3]     = kmem_rd;
    assign inst[2]     = kmem_wr;
    assign inst[1]     = pmem_rd;
    assign inst[0]     = pmem_wr;
    
    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counter       <= 0;
        end
        else begin
            current_state <= next_state;
            if (current_state != next_state)
                counter <= 0;
            else
                counter <= counter + 1;
        end
    end
    
    // State transition logic (based on counter)
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (START)
                    next_state = WRITING_Q;
                else
                    next_state = IDLE;
            end
            WRITING_Q: begin
                if (WRITING_Q_DONE)
                    next_state = WRITING_K;
                else
                    next_state = WRITING_Q;
            end
            WRITING_K: begin
                if (WRITING_K_DONE)
                    next_state = LOAD_K;
                else
                    next_state = WRITING_K;
            end
            LOAD_K: begin
                if (LOAD_K_DONE)
                    next_state = EXECUTE;
                else
                    next_state = LOAD_K;
            end
            EXECUTE: begin
                if (EXECUTE_DONE)
                    next_state = FIFO_READ;
                else
                    next_state = EXECUTE;
            end
            FIFO_READ: begin
                if (FIFO_READ_DONE)
                    next_state = NORM;
                else
                    next_state = FIFO_READ;
            end
            NORM: begin
                if (NORM_DONE)
                    next_state = READING_RESULT;
                else
                    next_state = NORM;
            end
            READING_RESULT: begin
                if (READING_RESULT_DONE)
                    next_state = IDLE;
                else
                    next_state = READING_RESULT;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
    // Output logic (control signal generation)
    always @(posedge clk) begin
        case (current_state)
            IDLE: begin
                sfp_sel             <= 1;
                div                 <= 0;
                acc                 <= 0;
                sfp_wr2pmem         <= 0;
                ofifo_rd            <= 0;
                qkmem_add           <= 0;
                pmem_add            <= 0;
                execute             <= 0;
                load                <= 0;
                qmem_rd             <= 0;
                qmem_wr             <= 0;
                kmem_rd             <= 0;
                kmem_wr             <= 0;
                pmem_rd             <= 0;
                pmem_wr             <= 0;
                START               <= 0;
                WRITING_Q_DONE      <= 0;
                WRITING_K_DONE      <= 0;
                LOAD_K_DONE         <= 0;
                EXECUTE_DONE        <= 0;
                FIFO_READ_DONE      <= 0;
                NORM_DONE           <= 0;
                READING_RESULT_DONE <= 0;
                START               <= s_axi_awvalid||s_axi_awready;
            end
            
            WRITING_Q: begin
                if (s_axi_bvalid && s_axi_bready)begin
                    WRITING_Q_DONE <= 1;
                end
            end
            
            WRITING_K: begin
                if (s_axi_bvalid && s_axi_bready)begin
                    WRITING_K_DONE <= 1;
                end
            end
            
            LOAD_K: begin
                if (counter < col+1) begin
                    if (counter == 1) begin
                        load    <= 1;
                        kmem_rd <= 1;
                    end
                    if (counter>1)begin
                        qkmem_add <= qkmem_add + 1;
                    end
                end
                if (counter == col+1) begin
                    kmem_rd   <= 0;
                    qkmem_add <= 0;
                end
                if (counter == col+2)begin
                    load <= 0;
                end
                if (counter == col+12)begin
                    LOAD_K_DONE <= 1;
                end
            end
            
            EXECUTE: begin
                if (counter < total_cycle) begin
                    execute <= 1;
                    qmem_rd <= 1;
                    if (counter > 0)begin
                        qkmem_add <= qkmem_add + 1;
                    end
                end
                if (counter == total_cycle+1) begin
                    qmem_rd   <= 0;
                    qkmem_add <= 0;
                    execute   <= 0;
                end
                if (counter == total_cycle+11)begin
                    EXECUTE_DONE <= 0;
                end
            end
            
            FIFO_READ: begin
                if (counter < total_cycle) begin
                    ofifo_rd <= 1;
                    pmem_wr  <= 1;
                    if (counter > 0)begin
                        pmem_add <= pmem_add + 1;
                    end
                end
                if (counter == total_cycle) begin
                    pmem_wr  <= 0;
                    pmem_add <= 0;
                    ofifo_rd <= 0;
                end
            end
            
            NORM: begin
                case (counter)
                    0: begin
                        pmem_rd  <= 1;
                        acc      <= 1;
                        pmem_add <= 0;
                    end
                    1,3,5,7,9,11,13,15: begin
                        pmem_add <= pmem_add + 1;
                    end
                    17: begin
                        pmem_rd  <= 0;
                        pmem_add <= 0;
                        acc      <= 0;
                    end
                    18: begin
                        div <= 1;
                    end
                    19: begin
                        pmem_rd <= 1;
                    end
                    20,21,22: begin
                        sfp_wr2pmem <= 1;
                    end
                    26,30,34,38,42,46,50,54: begin
                        pmem_add <= pmem_add + 1;
                    end
                    23,24,27,28,31,32,35,36,39,40,43,44,47,48,51,52,55,56: begin
                        div     <= 1;
                        pmem_wr <= 1;
                    end
                    57: pmem_add <= 0;
                    58,61,64,67,70,73,76,79: begin
                        div      <= 1;
                        pmem_add <= pmem_add + 1;
                    end
                    default: div <= 0;
                endcase
                if (s_axi_arvalid||s_axi_arready)begin
                    NORM_DONE <= 1;
                end
            end

            READING_RESULT: begin
                if (s_axi_bvalid && s_axi_bready)begin
                    READING_RESULT_DONE <= 1;
                end
            end
            
            default: begin
                execute   <= 0;
                load      <= 0;
                qmem_wr   <= 0;
                kmem_wr   <= 0;
                pmem_wr   <= 0;
                ofifo_rd  <= 0;
                qkmem_add <= 0;
                pmem_add  <= 0;
            end
        endcase
    end
    
    axi_ram_wr_rd_if #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .STRB_WIDTH(STRB_WIDTH),
    .ID_WIDTH(ID_WIDTH),
    .AWUSER_ENABLE(AWUSER_ENABLE),
    .AWUSER_WIDTH(AWUSER_WIDTH),
    .WUSER_ENABLE(WUSER_ENABLE),
    .WUSER_WIDTH(WUSER_WIDTH),
    .BUSER_ENABLE(BUSER_ENABLE),
    .BUSER_WIDTH(BUSER_WIDTH),
    .ARUSER_ENABLE(ARUSER_ENABLE),
    .ARUSER_WIDTH(ARUSER_WIDTH),
    .RUSER_ENABLE(RUSER_ENABLE),
    .RUSER_WIDTH(RUSER_WIDTH),
    .AUSER_WIDTH(AUSER_WIDTH),
    .PIPELINE_OUTPUT(PIPELINE_OUTPUT),
    .INTERLEAVE(INTERLEAVE)
    )axi_ram_wr_rd_if_instance(
    .s_axi_awid(axi_awid),
    .s_axi_awaddr(axi_awaddr),
    .s_axi_awlen(axi_awlen),
    .s_axi_awsize(axi_awsize),
    .s_axi_awburst(axi_awburst),
    .s_axi_awlock(axi_awlock),
    .s_axi_awcache(axi_awcache),
    .s_axi_awprot(axi_awprot),
    .s_axi_awqos(axi_awqos),
    .s_axi_awregion(axi_awregion),
    .s_axi_awuser(axi_awuser),
    .s_axi_awvalid(axi_awvalid),
    .s_axi_awready(axi_awready),
    .s_axi_wdata(axi_wdata),
    .s_axi_wstrb(axi_wstrb),
    .s_axi_wlast(axi_wlast),
    .s_axi_wuser(axi_wuser),
    .s_axi_wvalid(axi_wvalid),
    .s_axi_wready(axi_wready),
    .s_axi_bid(axi_bid),
    .s_axi_bresp(axi_bresp),
    .s_axi_buser(axi_buser),
    .s_axi_bvalid(axi_bvalid),
    .s_axi_bready(axi_bready),
    .s_axi_arid(axi_arid),
    .s_axi_araddr(axi_araddr),
    .s_axi_arlen(axi_arlen),
    .s_axi_arsize(axi_arsize),
    .s_axi_arburst(axi_arburst),
    .s_axi_arlock(axi_arlock),
    .s_axi_arcache(axi_arcache),
    .s_axi_arprot(axi_arprot),
    .s_axi_arqos(axi_arqos),
    .s_axi_arregion(axi_arregion),
    .s_axi_aruser(axi_aruser),
    .s_axi_arvalid(axi_arvalid),
    .s_axi_arready(axi_arready),
    .s_axi_rid(axi_rid),
    .s_axi_rdata(axi_rdata),
    .s_axi_rresp(axi_rresp),
    .s_axi_rlast(axi_rlast),
    .s_axi_ruser(axi_ruser),
    .s_axi_rvalid(axi_rvalid),
    .s_axi_rready(axi_rready),
    /*RAM interface*/
    .ram_cmd_id(),
    .ram_cmd_addr(),
    .ram_cmd_lock(),
    .ram_cmd_cache(),
    .ram_cmd_prot(),
    .ram_cmd_qos(),
    .ram_cmd_region(),
    .ram_cmd_auser(),
    .ram_cmd_wr_data(),
    .ram_cmd_wr_strb(),
    .ram_cmd_wr_user(),
    .ram_cmd_wr_en(),
    .ram_cmd_rd_en(),
    .ram_cmd_last(),
    .ram_cmd_ready(),
    .ram_rd_resp_id(),
    .ram_rd_resp_data(),
    .ram_rd_resp_last(),
    .ram_rd_resp_user(),
    .ram_rd_resp_valid(),
    .ram_rd_resp_ready()
    );
endmodule

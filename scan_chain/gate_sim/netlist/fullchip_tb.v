// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission
`timescale 1ns/1ps

module fullchip_tb();
    
    parameter total_cycle = 8;   // how many streamed Q vectors will be processed
    parameter bw          = 8;            // Q & K vector bit precision
    parameter bw_psum     = 2*bw+4;  // partial sum bit precision
    parameter pr          = 8;           // how many products added in each dot product
    parameter cor         = 2;
    parameter col         = 8;           // how many dot product units are equipped
    parameter mode_sel    = 1;     //1:Q,K-norm; 0:norm,V
    parameter test_sel    = 0;
    
    integer qk_file ; // file handler
    integer qk_scan_file ; // file handler
    
    
    integer  captured_data;
    `define NULL 0
    
    
    integer  K[col-1:0][cor*pr-1:0];
    integer  Q[total_cycle-1:0][cor*pr-1:0];
    integer  result[total_cycle-1:0][cor*col-1:0];
    integer  norm_ref[total_cycle-1:0][cor*col-1:0];
    integer  norm[total_cycle-1:0][cor*col-1:0];
    integer  row_sum;
    integer total_error;
    integer max_error;
    integer error;
    integer average_error;
    
    integer i,j,k,t,q;
    
    reg test_mode      = 0;
    reg SE             = 0;

    reg sfp_sel        = 0;
    // reg clk_en_sfp  = 0;
    // reg clk_en_fifo = 0;
    // reg clk_en_mac  = 0;
    
    reg sfp_wr2pmem = 0;
    reg acc         = 0;
    reg div         = 0;
    reg fifo_ext_rd = 0;
    
    reg reset = 0;
    reg clk   = 0;
    reg [cor*pr*bw-1:0] mem_in;
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
    // reg [bw_psum*col*cor-1:0] out_ref [col-1:0];
    
    wire [20:0] inst;
    wire [bw_psum*col*cor-1:0] out_2core;
    
    // assign inst[22] = clk_en_sfp;
    // assign inst[21] = clk_en_fifo;
    // assign inst[20] = clk_en_mac;
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
    
    // reg [bw_psum-1:0] temp5b;
    // reg [bw_psum+3:0] temp_sum;
    // reg [bw_psum*col-1:0] temp16b;
    
    
    fullchip #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr), .cor(cor)) fullchip_instance (
    .reset(reset),
    .clk(clk),
    .mem_in(mem_in),
    .inst(inst),
    .out(out_2core),
    .test_mode(test_mode),
    .clk_scan(),
    .reset_scan(),
    .SI(),
    .SE(SE),
    .SO()
    );
    
    
    initial begin
        
        $dumpfile("fullchip_tb.vcd");
        $dumpvars(0,fullchip_tb);
        
        #0.5 clk = 1'b0;
        reset = 0;
        #0.5 clk = 1'b1;
        #0.5 clk = 1'b0;
        reset = 1;
        #0.5 clk = 1'b1;
        #0.5 clk = 1'b0;
        reset = 0;
        #0.5 clk = 1'b1;

        sfp_sel        = mode_sel;
        test_mode      = test_sel;
        SE             = 0;
        ///// Q data txt reading /////
        if (mode_sel) begin
            $display("##### Q data txt reading #####");
            qk_file = $fopen("../testdata/qdata_sparse.txt", "r");
        end
        else begin
            $display("##### V data txt reading #####");
            qk_file = $fopen("../testdata/vdata_sparse.txt", "r");
        end
        
        for (q = 0; q<total_cycle; q = q+1) begin
            for (j = 0; j<pr; j = j+1) begin
                qk_scan_file = $fscanf(qk_file, "%d", captured_data);
                Q[q][j]      = captured_data;
            end
        end
        
        $fclose(qk_file);
        
        for (q = 0; q<total_cycle; q = q+1) begin
            for (j = pr; j<cor*pr; j = j+1) begin
                Q[q][j] = Q[q][j-pr];
            end
        end
        
        /////////////////////////////////
        
        
        for (q = 0; q<2; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        
        
        
        
        ///// K data txt reading /////
        if (mode_sel)
            $display("##### K data txt reading #####");
        else
            $display("##### norm data txt reading #####");
        
        for (q = 0; q<10; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        reset = 0;
        
        if (mode_sel)
            qk_file = $fopen("../testdata/kdata_core0_sparse.txt", "r");
        else
            qk_file = $fopen("../testdata/norm_core0_sparse.txt", "r");
        
        for (q = 0; q<col; q = q+1) begin
            for (j = 0; j<pr; j = j+1) begin
                qk_scan_file = $fscanf(qk_file, "%d", captured_data);
                K[q][j]      = captured_data;
            end
        end
        
        $fclose(qk_file);
        
        if (mode_sel)
            qk_file = $fopen("../testdata/kdata_core1_sparse.txt", "r");
        else
            qk_file = $fopen("../testdata/norm_core1_sparse.txt", "r");
        
        for (q = 0; q<col; q = q+1) begin
            for (j = pr; j<cor*pr; j = j+1) begin
                qk_scan_file = $fscanf(qk_file, "%d", captured_data);
                K[q][j]      = captured_data;
            end
        end
        
        $fclose(qk_file);
        /////////////////////////////////
        
        
        
        
        /////////////// Estimated result printing /////////////////
        
        
        $display("##### Estimated multiplication result #####");
        
        for (t = 0; t<total_cycle; t = t+1) begin
            for (q = 0; q<col*pr; q = q+1) begin
                result[t][q] = 0;
            end
        end
        
        for (t = 0; t<total_cycle; t = t+1) begin
            for (q = 0; q<col; q = q+1) begin
                for (k = 0; k<pr; k = k+1) begin
                    result[t][q] = result[t][q] + Q[t][k] * K[q][k];
                end
            end
        end
        for (t = 0; t<total_cycle; t = t+1) begin
            for (q = 0; q<col; q = q+1) begin
                for (k = 0; k<pr; k = k+1) begin
                    result[t][q+col] = result[t][q+col] + Q[t][k+pr] * K[q][k+pr];
                end
            end
        end
        
        //////////////////////////////////////////////
        
        
        
        ///// Qmem writing  /////
        
        $display("##### Qmem writing  #####");
        
        for (q = 0; q<total_cycle; q = q+1) begin
            
            #0.5 clk = 1'b0;
            qmem_wr  = 1;  if (q>0) qkmem_add  = qkmem_add + 1;
            
            mem_in[1*bw-1:0*bw]   = Q[q][0];
            mem_in[2*bw-1:1*bw]   = Q[q][1];
            mem_in[3*bw-1:2*bw]   = Q[q][2];
            mem_in[4*bw-1:3*bw]   = Q[q][3];
            mem_in[5*bw-1:4*bw]   = Q[q][4];
            mem_in[6*bw-1:5*bw]   = Q[q][5];
            mem_in[7*bw-1:6*bw]   = Q[q][6];
            mem_in[8*bw-1:7*bw]   = Q[q][7];
            mem_in[9*bw-1:8*bw]   = Q[q][8];
            mem_in[10*bw-1:9*bw]  = Q[q][9];
            mem_in[11*bw-1:10*bw] = Q[q][10];
            mem_in[12*bw-1:11*bw] = Q[q][11];
            mem_in[13*bw-1:12*bw] = Q[q][12];
            mem_in[14*bw-1:13*bw] = Q[q][13];
            mem_in[15*bw-1:14*bw] = Q[q][14];
            mem_in[16*bw-1:15*bw] = Q[q][15];
            
            #0.5 clk = 1'b1;
            
        end
        
        
        #0.5 clk  = 1'b0;
        qmem_wr   = 0;
        qkmem_add = 0;
        #0.5 clk  = 1'b1;
        ///////////////////////////////////////////
        
        
        
        
        
        ///// Kmem writing  /////
        
        $display("##### Kmem writing #####");
        
        for (q = 0; q<col; q = q+1) begin
            
            #0.5 clk = 1'b0;
            kmem_wr  = 1; if (q>0) qkmem_add  = qkmem_add + 1;
            
            mem_in[1*bw-1:0*bw]   = K[q][0];
            mem_in[2*bw-1:1*bw]   = K[q][1];
            mem_in[3*bw-1:2*bw]   = K[q][2];
            mem_in[4*bw-1:3*bw]   = K[q][3];
            mem_in[5*bw-1:4*bw]   = K[q][4];
            mem_in[6*bw-1:5*bw]   = K[q][5];
            mem_in[7*bw-1:6*bw]   = K[q][6];
            mem_in[8*bw-1:7*bw]   = K[q][7];
            mem_in[9*bw-1:8*bw]   = K[q][8];
            mem_in[10*bw-1:9*bw]  = K[q][9];
            mem_in[11*bw-1:10*bw] = K[q][10];
            mem_in[12*bw-1:11*bw] = K[q][11];
            mem_in[13*bw-1:12*bw] = K[q][12];
            mem_in[14*bw-1:13*bw] = K[q][13];
            mem_in[15*bw-1:14*bw] = K[q][14];
            mem_in[16*bw-1:15*bw] = K[q][15];
            
            #0.5 clk = 1'b1;
            
        end
        
        #0.5 clk  = 1'b0;
        kmem_wr   = 0;
        qkmem_add = 0;
        #0.5 clk  = 1'b1;
        ///////////////////////////////////////////
        
        
        
        for (q = 0; q<2; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        
        
        
        /////  K data loading  /////
        $display("##### Data loading to processor #####");
        
        for (q = 0; q<col+1; q = q+1) begin
            #0.5 clk = 1'b0;
            load     = 1;
            if (q == 1) kmem_rd    = 1;
            if (q>1) begin
                qkmem_add = qkmem_add + 1;
            end
            
            #0.5 clk = 1'b1;
        end
        
        #0.5 clk = 1'b0;
        kmem_rd  = 0; qkmem_add  = 0;
        #0.5 clk = 1'b1;
        
        #0.5 clk = 1'b0;
        load     = 0;
        #0.5 clk = 1'b1;
        
        ///////////////////////////////////////////
        
        for (q = 0; q<10; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        
        
        
        
        
        ///// execution  /////
        $display("##### execute #####");
        // clk_en_fifo = 1;
        for (q = 0; q<total_cycle; q = q+1) begin
            #0.5 clk = 1'b0;
            execute  = 1;
            qmem_rd  = 1;
            
            if (q>0) begin
                qkmem_add = qkmem_add + 1;
            end
            
            #0.5 clk = 1'b1;
        end
        
        #0.5 clk = 1'b0;
        qmem_rd  = 0; qkmem_add  = 0; execute  = 0;
        #0.5 clk = 1'b1;
        
        
        ///////////////////////////////////////////
        
        for (q = 0; q<10; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        
        
        
        
        ////////////// output fifo rd and wb to psum mem ///////////////////
        
        $display("##### move ofifo to pmem #####");
        
        for (q = 0; q<total_cycle; q = q+1) begin
            #0.5 clk = 1'b0;
            ofifo_rd = 1;
            pmem_wr  = 1;
            
            if (q>0) begin
                pmem_add = pmem_add + 1;
            end
            
            #0.5 clk = 1'b1;
        end
        
        #0.5 clk = 1'b0;
        pmem_wr  = 0; pmem_add  = 0; ofifo_rd  = 0;
        #0.5 clk = 1'b1;
        
        ///////////////////////////////////////////
        
        
        
        
        ////////////////// norm ///////////////////
        if(mode_sel) begin
        $display("##### calculate sum in sfp by psum from pmem #####");
        
        #0.5 clk = 1'b0;
        pmem_rd  = 1;
        acc      = 1;
        #0.5 clk = 1'b1;
        
        for (q = 0; q<total_cycle; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
            //$display("prd @PMEM Add%2d: %40h", q, pmem_out);
            pmem_add = pmem_add + 1;
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
            
        end
        
        #0.5 clk = 1'b0;
        pmem_rd  = 0; pmem_add  = 0; acc  = 0;
        #0.5 clk = 1'b1;
        
        // $display("##### realize norm's division in sfp #####");
        #0.5 clk = 1'b0; div = 1;
        #0.5 clk = 1'b1;
        #0.5 clk = 1'b0; pmem_rd = 1; div = 0;
        #0.5 clk = 1'b1;
        #0.5 clk = 1'b0; sfp_wr2pmem = 1;
        #0.5 clk = 1'b1;
        #0.5 clk = 1'b0;
        #0.5 clk = 1'b1;
        
        for (q = 0; q<total_cycle+1; q = q+1) begin
            #0.5 clk = 1'b0; div = 1; pmem_wr = 1;
            #0.5 clk = 1'b1;
            #0.5 clk = 1'b0; if (q<total_cycle) pmem_add = pmem_add + 1; pmem_wr = 0;
            #0.5 clk = 1'b1;
            #0.5 clk = 1'b0; div = 0;
            #0.5 clk = 1'b1;
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        end
        ///////////////////////////////////////////


        
        ////////////////// write results to norm ///////////////////
        $display("##### write results to norm #####");
        #0.5 clk = 1'b0;
        pmem_add = 0;
        #0.5 clk = 1'b1;
        
        for (q = 0; q<total_cycle; q = q+1) begin
            div      = 1;
            pmem_rd  = 1;
            #0.5 clk = 1'b0;
            if (q>0) begin
                pmem_add = pmem_add + 1;
            end
            #0.5 clk = 1'b1;
            div      = 0;
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
            for (k = 0; k<col; k = k+1) begin
                norm[q][col-k-1]     = $signed(out_2core[(k+1)*bw_psum-1 -:bw_psum]);
                norm[q][cor*col-k-1] = $signed(out_2core[(k+col+1)*bw_psum-1 -:bw_psum]);
            end
        end
        #0.5 clk = 1'b0;
        pmem_rd  = 0; pmem_add  = 0; div  = 0;
        #0.5 clk = 1'b1;
        
        ///////////////////////////////////////////
        
        
        
        
        ////////////// verification ///////////////////
        
        $display("##### verification #####");
        for (q = 0; q<10; q = q+1) begin
            #0.5 clk = 1'b0;
            #0.5 clk = 1'b1;
        end
        reset = 0;
        
        
        if (mode_sel) begin
            for (q = 0; q < col; q = q + 1) begin
                row_sum = 0;
                for (j = 0; j < col*cor; j = j + 1) begin
                    row_sum = row_sum + (result[q][j] < 0 ? -result[q][j] : result[q][j]);
                end
                for (j = 0; j < col*cor; j = j + 1) begin
                    norm_ref[q][j] = ((result[q][j] < 0 ? -result[q][j] : result[q][j])*128) / (row_sum);
                end
            end
        end
        else begin
            for (q = 0; q < col; q = q + 1) begin
                for (j = 0; j < col*cor; j = j + 1) begin
                    norm_ref[q][j] = result[q][j];
                end
            end
        end
        ///////////////////////////////////////////
        
        
        
        ////////////// Calculate error ///////////////////
        total_error = 0;
        max_error   = 0;
        $display("##### Calculate error #####");
        for (i = 0; i < total_cycle; i = i + 1) begin
            for (j = 0; j < cor * col; j = j + 1) begin
                error       = (norm_ref[i][j] > norm[i][j]) ? (norm_ref[i][j] - norm[i][j]) : (norm[i][j] - norm_ref[i][j]);
                total_error = total_error + error;
                if (error > max_error) begin
                    max_error = error;
                end
            end
        end
        
        average_error = (total_error*100) / (total_cycle * cor * col);
        
        $display("Average Error: %0.4f /100", average_error);
        $display("Max Error: %0d", max_error);
        
        ///////////////////////////////////////////
        
        #10 $finish;
        
    end
    
endmodule
    
    
    
    

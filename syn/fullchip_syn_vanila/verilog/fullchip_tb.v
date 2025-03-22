`timescale 1ns/1ps

module fullchip_tb;

parameter total_cycle = 8;   // how many streamed Q vectors will be processed
parameter bw = 8;            // Q & K vector bit precision
parameter bw_psum = 2*bw+4;  // partial sum bit precision
parameter pr = 8;           // how many products added in each dot product 
parameter col = 8;           // how many dot product units are equipped
parameter mode_sel = 1;      // 0: norm*V, 1: K*Q
parameter core = 2;           // how many cores are equipped

integer qk_file ; // file handler
integer qk_scan_file ; // file handler


integer  captured_data;
integer  weight [col*pr-1:0];
`define NULL 0




integer  K[col-1:0][pr*core-1:0];
integer  Q[total_cycle-1:0][pr*core-1:0];
integer  result[total_cycle-1:0][col*core-1:0];
integer  sum[total_cycle-1:0];

integer i,j,k,t,p,q,s,u, m;





reg reset = 1;
reg clk = 0;
reg [pr*bw*core-1:0] mem_in; 
reg ofifo_rd = 0;
wire [19:0] inst; 
reg qmem_rd = 0;
reg qmem_wr = 0; 
reg kmem_rd = 0; 
reg kmem_wr = 0;
reg pmem_rd = 0; 
reg pmem_wr = 0; 
reg execute = 0;
reg load = 0;
reg [3:0] qkmem_add = 0;
reg [3:0] pmem_add = 0;
reg sfp_wr2pmem = 0;
reg sfp_div = 0;
reg sfp_acc = 0;
wire [bw_psum*col*core-1:0] pmem_out;

assign inst[19] = sfp_wr2pmem;
assign inst[18] = sfp_div;
assign inst[17] = sfp_acc;
assign inst[16] = ofifo_rd;
assign inst[15:12] = qkmem_add;
assign inst[11:8]  = pmem_add;
assign inst[7] = execute;
assign inst[6] = load;
assign inst[5] = qmem_rd;
assign inst[4] = qmem_wr;
assign inst[3] = kmem_rd;
assign inst[2] = kmem_wr;
assign inst[1] = pmem_rd;
assign inst[0] = pmem_wr;


// reg for multiplication result
reg [bw_psum*2-1:0] temp5b;
reg [bw_psum-1:0] temp5b_core0;
reg [bw_psum-1:0] temp5b_core1;
reg [bw_psum+3:0] temp_sum_core0;
reg [bw_psum+3:0] temp_sum_core1;
reg [bw_psum+4:0] temp_sum;
reg [bw_psum*col*2-1:0] temp16b;
reg [bw_psum*col-1:0] temp16b_core0;
reg [bw_psum*col-1:0] temp16b_core1;

// reg for norm result
reg [bw_psum*2-1:0] norm5b;
reg [bw_psum-1:0] norm5b_core0;
reg [bw_psum-1:0] norm5b_core1;
reg [(bw_psum+4)*2-1:0] temp_norm;
reg [bw_psum*col*2-1:0] norm16b;
reg [bw_psum*col-1:0] norm16b_core0;
reg [bw_psum*col-1:0] norm16b_core1;

fullchip #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) fullchip_instance (
      .reset(reset),
      .clk(clk), 
      .mem_in(mem_in), 
      .inst(inst),
      .out(pmem_out)
);


initial begin 

  $dumpfile("fullchip_tb.vcd");
  $dumpvars(0,fullchip_tb);


///// Q or V data txt reading /////

  if (mode_sel) begin
      $display("##### Q data txt reading #####");
      qk_file = $fopen("../../testdata/qdata.txt", "r");
      //qk_file = $fopen("../../../source_file/testdata/qdata_sparse.txt", "r");
      //qk_file = $fopen("qdata_sparse.txt", "r");
  end
  else begin
      $display("##### V data txt reading #####");
      qk_file = $fopen("../../testdata/vdata.txt", "r");
      //qk_file = $fopen("../../../source_file/testdata/vdata_sparse.txt", "r");
      //qk_file = $fopen("vdata_sparse.txt", "r");
  end


  for (q=0; q<total_cycle; q=q+1) begin
    for (j=0; j<pr; j=j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d\n", captured_data);
          Q[q][j] = captured_data;
          Q[q][j+total_cycle] = captured_data;
          //$display("%d\n", K[q][j]);
    end
  end
/////////////////////////////////




  for (q=0; q<2; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
  end




///// K or norm data txt reading /////

  if (mode_sel)
      $display("##### K data txt reading #####");
  else
      $display("##### norm data txt reading #####");

  for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
  end
  reset = 0;

  if (mode_sel)
      qk_file = $fopen("../../testdata/kdata_core0.txt", "r");
      //qk_file = $fopen("../../../source_file/testdata/kdata_core0_sparse.txt", "r");
      //qk_file = $fopen("kdata_core0_sparse.txt", "r");
  else
      qk_file = $fopen("../../testdata/norm_core0.txt", "r");
      //qk_file = $fopen("../../../source_file/testdata/norm_core0_sparse.txt", "r");
      //qk_file = $fopen("norm_core0_sparse.txt", "r");
  
  for (q=0; q<col; q=q+1) begin
    for (j=0; j<pr; j=j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d\n", captured_data);
          K[q][j] = captured_data;
          //$display("##### %d\n", K[q][j]);
    end
  end
  $fclose(qk_file);


  if (mode_sel)
      qk_file = $fopen("../../testdata/kdata_core1.txt", "r");
      //qk_file = $fopen("../../../source_file/testdata/kdata_core1_sparse.txt", "r");
      //qk_file = $fopen("kdata_core1_sparse.txt", "r");
  else
      qk_file = $fopen("../../testdata/norm_core1.txt", "r");
      //qk_file = $fopen("../../../source_file/testdata/norm_core1_sparse.txt", "r");
      //qk_file = $fopen("norm_core1_sparse.txt", "r");
  
  for (q = 0; q<col; q = q+1) begin
      for (j = pr; j<core*pr; j = j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d", captured_data);
          K[q][j]      = captured_data;
      end
  end

/////////////////////////////////






/////////////// Estimated result printing /////////////////


$display("##### Estimated multiplication and norm result #####");

  for (t=0; t<total_cycle; t=t+1) begin
     for (q=0; q<col*core; q=q+1) begin
       result[t][q] = 0;
       temp_sum_core0 = 0;
       temp_sum_core1 = 0;
     end
  end

  for (t=0; t<total_cycle; t=t+1) begin
    temp_sum = 0;
    temp_sum_core0 = 0;
    temp_sum_core1 = 0;
    for (q=0; q<col; q=q+1) begin
      for (k=0; k<pr; k=k+1) begin
        result[t][q] = result[t][q] + Q[t][k] * K[q][k];
        //$display("prd @cycle%2d: %80h", t, result[t][q]);
        result[t][q+col] = result[t][q+col] + Q[t][k+pr] * K[q][k+pr];
      end

        temp5b_core0 = result[t][q];
        temp5b_core1 = result[t][q+col];
        //$display("prd core0 @cycle%2d: %5h", t, temp5b_core0);
        //$display("prd core1 @cycle%2d: %5h", t, temp5b_core1);
        temp16b_core0 = {temp16b_core0[139:0], temp5b_core0};
        temp16b_core1 = {temp16b_core1[139:0], temp5b_core1};
        temp5b_core0 = temp5b_core0[bw_psum-1] ? (~temp5b_core0 + 1) : temp5b_core0;  // abs
        temp5b_core1 = temp5b_core1[bw_psum-1] ? (~temp5b_core1 + 1) : temp5b_core1;  // abs
        temp_sum_core0 = temp_sum_core0 + temp5b_core0;
        temp_sum_core1 = temp_sum_core1 + temp5b_core1;
        
        temp_sum = temp_sum_core0[bw_psum+3:6] + temp_sum_core1[bw_psum+3:6];
    end
    sum[t] = temp_sum;
    $display("prd sum0@cycle%2d: %6h",t, temp_sum_core0);
    $display("prd sum1@cycle%2d: %6h",t, temp_sum_core1);
    //$display("%d %d %d %d %d %d %d %d", result[t][0], result[t][1], result[t][2], result[t][3], result[t][4], result[t][5], result[t][6], result[t][7]);
    $display("sum two core @cycle%2d: %6h", t, sum[t]);
    $display("prd core0&core1 @cycle%2d: %80h", t, {temp16b_core0, temp16b_core1});
  end



$display("##### Estimated norm result #####");

  for (t=0; t<total_cycle; t=t+1) begin
    for (q=0; q<col; q=q+1) begin
        temp5b_core0 = result[t][q];
        temp5b_core1 = result[t][q+col];
        temp5b_core0 = temp5b_core0[bw_psum-1] ? (~temp5b_core0 + 1) : temp5b_core0;
        temp5b_core1 = temp5b_core1[bw_psum-1] ? (~temp5b_core1 + 1) : temp5b_core1;
        norm5b_core0 = temp5b_core0 / sum[t];
        norm5b_core1 = temp5b_core1 / sum[t];
        //$display("norm5b[%2d][%2d]: %5h", t, q, norm5b);
        norm16b_core0 = {norm16b_core0[139:0], norm5b_core0};
        norm16b_core1 = {norm16b_core1[139:0], norm5b_core1};
        norm16b = {norm16b_core0, norm16b_core1};
    end
    //$display("sum[%2d][23:0]: %24b", t, sum[t]);
    //$display("sum[%2d][23:7]: %17b", t, sum[t][23:7]);
    $display("norm core0&core1 @cycle%2d: %80h", t, norm16b);
  end


//////////////////////////////////////////////





///// Qmem writing  /////

$display("##### Qmem writing  #####");

  for (q=0; q<total_cycle; q=q+1) begin

    #0.5 clk = 1'b0;  
    qmem_wr = 1;  if (q>0) qkmem_add = qkmem_add + 1; 
    
    mem_in[1*bw-1:0*bw] = Q[q][0];
    mem_in[2*bw-1:1*bw] = Q[q][1];
    mem_in[3*bw-1:2*bw] = Q[q][2];
    mem_in[4*bw-1:3*bw] = Q[q][3];
    mem_in[5*bw-1:4*bw] = Q[q][4];
    mem_in[6*bw-1:5*bw] = Q[q][5];
    mem_in[7*bw-1:6*bw] = Q[q][6];
    mem_in[8*bw-1:7*bw] = Q[q][7];
    mem_in[9*bw-1:8*bw] = Q[q][8];
    mem_in[10*bw-1:9*bw] = Q[q][9];
    mem_in[11*bw-1:10*bw] = Q[q][10];
    mem_in[12*bw-1:11*bw] = Q[q][11];
    mem_in[13*bw-1:12*bw] = Q[q][12];
    mem_in[14*bw-1:13*bw] = Q[q][13];
    mem_in[15*bw-1:14*bw] = Q[q][14];
    mem_in[16*bw-1:15*bw] = Q[q][15];

    #0.5 clk = 1'b1;  

  end


  #0.5 clk = 1'b0;  
  qmem_wr = 0; 
  qkmem_add = 0;
  #0.5 clk = 1'b1;  
///////////////////////////////////////////





///// Kmem writing  /////

$display("##### Kmem writing #####");

  for (q=0; q<col; q=q+1) begin

    #0.5 clk = 1'b0;  
    kmem_wr = 1; if (q>0) qkmem_add = qkmem_add + 1; 
    
    mem_in[1*bw-1:0*bw] = K[q][0];
    mem_in[2*bw-1:1*bw] = K[q][1];
    mem_in[3*bw-1:2*bw] = K[q][2];
    mem_in[4*bw-1:3*bw] = K[q][3];
    mem_in[5*bw-1:4*bw] = K[q][4];
    mem_in[6*bw-1:5*bw] = K[q][5];
    mem_in[7*bw-1:6*bw] = K[q][6];
    mem_in[8*bw-1:7*bw] = K[q][7];
    mem_in[9*bw-1:8*bw] = K[q][8];
    mem_in[10*bw-1:9*bw] = K[q][9];
    mem_in[11*bw-1:10*bw] = K[q][10];
    mem_in[12*bw-1:11*bw] = K[q][11];
    mem_in[13*bw-1:12*bw] = K[q][12];
    mem_in[14*bw-1:13*bw] = K[q][13];
    mem_in[15*bw-1:14*bw] = K[q][14];
    mem_in[16*bw-1:15*bw] = K[q][15];

    #0.5 clk = 1'b1;  

  end

  #0.5 clk = 1'b0;  
  kmem_wr = 0;  
  qkmem_add = 0;
  #0.5 clk = 1'b1;  
///////////////////////////////////////////



  for (q=0; q<2; q=q+1) begin
    #0.5 clk = 1'b0;  
    #0.5 clk = 1'b1;   
  end




/////  K data loading  /////
$display("##### K data loading to processor #####");

  for (q=0; q<col+1; q=q+1) begin
    #0.5 clk = 1'b0;  
    load = 1; 
    if (q==1) kmem_rd = 1;
    if (q>1) begin
       qkmem_add = qkmem_add + 1;
    end

    #0.5 clk = 1'b1;  
  end

  #0.5 clk = 1'b0;  
  kmem_rd = 0; qkmem_add = 0;
  #0.5 clk = 1'b1;  

  #0.5 clk = 1'b0;  
  load = 0; 
  #0.5 clk = 1'b1;  

///////////////////////////////////////////

 for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
 end





///// execution  /////
$display("##### execute #####");

  for (q=0; q<total_cycle; q=q+1) begin
    #0.5 clk = 1'b0;  
    execute = 1; 
    qmem_rd = 1;

    if (q>0) begin
       qkmem_add = qkmem_add + 1;
    end

    #0.5 clk = 1'b1;  
  end

  #0.5 clk = 1'b0;  
  qmem_rd = 0; qkmem_add = 0; execute = 0;
  #0.5 clk = 1'b1;  


///////////////////////////////////////////

 for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
 end




////////////// output fifo rd and wb to psum mem ///////////////////

$display("##### move psum from ofifo to pmem #####");

  for (q=0; q<total_cycle; q=q+1) begin
    #0.5 clk = 1'b0;  
    ofifo_rd = 1; 
    pmem_wr = 1; 

    if (q>0) begin
       pmem_add = pmem_add + 1;
    end

    #0.5 clk = 1'b1;  
  end

  #0.5 clk = 1'b0;  
  pmem_wr = 0; pmem_add = 0; ofifo_rd = 0;
  #0.5 clk = 1'b1;  

///////////////////////////////////////////





////////////// output multiplication result from pmem ///////////////////

$display("##### display multiplication result from pmem #####");

#0.5 clk = 1'b0;  
pmem_rd = 1; 
#0.5 clk = 1'b1; 

  for (q=0; q<total_cycle; q=q+1) begin
    #0.5 clk = 1'b0; 
    #0.5 clk = 1'b1; 
    $display("prd @PMEM Add%2d: %40h", q, pmem_out);
    pmem_add = pmem_add + 1;
    #0.5 clk = 1'b0; 
    #0.5 clk = 1'b1; 
 
  end

  #0.5 clk = 1'b0;  
  pmem_rd = 0; pmem_add = 0;
  #0.5 clk = 1'b1;  

///////////////////////////////////////////




////////////// norm ///////////////////

$display("##### calculate sum in sfp by psum from pmem #####");

#0.5 clk = 1'b0;  
pmem_rd = 1; 
sfp_acc = 1;
#0.5 clk = 1'b1; 

  for (q=0; q<total_cycle; q=q+1) begin
    #0.5 clk = 1'b0; 
    #0.5 clk = 1'b1; 
    //$display("prd @PMEM Add%2d: %40h", q, pmem_out);
    pmem_add = pmem_add + 1;
    #0.5 clk = 1'b0; 
    #0.5 clk = 1'b1; 

  end

  #0.5 clk = 1'b0;
  pmem_rd = 0; pmem_add = 0; sfp_acc = 0;
  #0.5 clk = 1'b1;

$display("##### realize norm's division in sfp #####");
  #0.5 clk = 1'b0; sfp_div = 1;
  #0.5 clk = 1'b1;
  #0.5 clk = 1'b0; pmem_rd = 1; sfp_div = 0;
  #0.5 clk = 1'b1;
  #0.5 clk = 1'b0; 
  #0.5 clk = 1'b1;
  #0.5 clk = 1'b0;
  #0.5 clk = 1'b1;
  for (q=0; q<total_cycle+1; q=q+1) begin
    #0.5 clk = 1'b0; sfp_div = 1; sfp_wr2pmem = 1; pmem_wr = 1;
    #0.5 clk = 1'b1;
    #0.5 clk = 1'b0; pmem_add = pmem_add + 1; pmem_wr = 0;
    #0.5 clk = 1'b1;
    #0.5 clk = 1'b0; sfp_div = 0;
    #0.5 clk = 1'b1; 
    #0.5 clk = 1'b0;
    #0.5 clk = 1'b1;
  end



$display("##### display norm results from pmem #####");

#0.5 clk = 1'b0;  
pmem_rd = 1; pmem_add = 1;
#0.5 clk = 1'b1; 

  for (q=1; q<total_cycle+1; q=q+1) begin
    #0.5 clk = 1'b0; 
    #0.5 clk = 1'b1; 
    $display("norm @PMEM Add%2d: %40h", q, pmem_out);
    pmem_add = pmem_add + 1;
    #0.5 clk = 1'b0; 
    #0.5 clk = 1'b1; 
 
  end

  #0.5 clk = 1'b0;  
  pmem_rd = 0; pmem_add = 0;
  #0.5 clk = 1'b1;  



///////////////////////////////////////////



  #10 $finish;


end

endmodule





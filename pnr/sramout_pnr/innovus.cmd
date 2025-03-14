#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Mar  9 16:34:45 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v15.23-s045_1 (64bit) 04/22/2016 12:32 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 15.23-s045_1 NR160414-1105/15_23-UB (database version 2.30, 317.6.1) {superthreading v1.26}
#@(#)CDS: AAE 15.23-s014 (64bit) 04/22/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 15.23-s022_1 () Apr 22 2016 09:38:45 ( )
#@(#)CDS: SYNTECH 15.23-s008_1 () Apr 12 2016 21:52:59 ( )
#@(#)CDS: CPE v15.23-s045
#@(#)CDS: IQRC/TQRC 15.1.4-s213 (64bit) Tue Feb  9 17:31:28 PST 2016 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_pwr_net VDD
set init_gnd_net VSS
set init_verilog ./netlist/sram_w16_out.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell sram_w16_out
set init_lef_file /home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef
create_library_set -name WC_LIB -timing $worst_timing_lib
create_library_set -name BC_LIB -timing $best_timing_lib
create_rc_corner -name Cmax -cap_table $worst_captbl -T 125
create_rc_corner -name Cmin -cap_table $best_captbl -T -40
create_delay_corner -name WC -library_set WC_LIB -rc_corner Cmax
create_delay_corner -name BC -library_set BC_LIB -rc_corner Cmin
create_constraint_mode -name CON -sdc_file [list $sdc]
create_analysis_view -name WC_VIEW -delay_corner WC -constraint_mode CON
create_analysis_view -name BC_VIEW -delay_corner BC -constraint_mode CON
init_design -setup WC_VIEW -hold BC_VIEW
set_interactive_constraint_modes {CON}
setDesignMode -process 65
floorPlan -s 500 100 10 10 10 10
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 15 -spacing 1 -layer M4 -width 1 -nets { VSS VDD } -start_from left -start 20 -stop 490
sroute
pan -1.340 26.788
pan -31.936 -1.694
pan -101.612 -6.048
pan -53.468 0.242
pan -75.242 -1.452
pan -55.645 -3.387
pan -82.258 16.693
pan 40.852 7.032
pan 48.889 1.340
pan 48.889 0.000
pan 51.568 -0.335
pan 65.967 7.032
floorPlan -s 500 100 10 10 10 10
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 25 -spacing 1 -layer M4 -width 1 -nets { VSS VDD } -start_from left -start 20 -stop 490
sroute
pan 87.733 15.404
pan -54.582 -6.362
pan -106.150 -4.688
pan -96.774 -8.372
pan -59.605 -5.358
pan 43.867 -2.679
pan 75.678 4.353
pan 87.063 7.032
pan 84.049 -2.344
pan 92.086 3.349
pan 33.821 -2.009
pan -43.306 -14.274
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection counterclockwise -side Bottom -layer 4 -spreadType center -spacing 4 -pin {{D[0]} {D[1]} {D[2]} {D[3]} {D[4]} {D[5]} {D[6]} {D[7]} {D[8]} {D[9]} {D[10]} {D[11]} {D[12]} {D[13]} {D[14]} {D[15]} {D[16]} {D[17]} {D[18]} {D[19]} {D[20]} {D[21]} {D[22]} {D[23]} {D[24]} {D[25]} {D[26]} {D[27]} {D[28]} {D[29]} {D[30]} {D[31]} {D[32]} {D[33]} {D[34]} {D[35]} {D[36]} {D[37]} {D[38]} {D[39]} {D[40]} {D[41]} {D[42]} {D[43]} {D[44]} {D[45]} {D[46]} {D[47]} {D[48]} {D[49]} {D[50]} {D[51]} {D[52]} {D[53]} {D[54]} {D[55]} {D[56]} {D[57]} {D[58]} {D[59]} {D[60]} {D[61]} {D[62]} {D[63]} {D[64]} {D[65]} {D[66]} {D[67]} {D[68]} {D[69]} {D[70]} {D[71]} {D[72]} {D[73]} {D[74]} {D[75]} {D[76]} {D[77]} {D[78]} {D[79]} {D[80]} {D[81]} {D[82]} {D[83]} {D[84]} {D[85]} {D[86]} {D[87]} {D[88]} {D[89]} {D[90]} {D[91]} {D[92]} {D[93]} {D[94]} {D[95]} {D[96]} {D[97]} {D[98]} {D[99]} {D[100]} {D[101]} {D[102]} {D[103]} {D[104]} {D[105]} {D[106]} {D[107]} {D[108]} {D[109]} {D[110]} {D[111]} {D[112]} {D[113]} {D[114]} {D[115]} {D[116]} {D[117]} {D[118]} {D[119]} {D[120]} {D[121]} {D[122]} {D[123]} {D[124]} {D[125]} {D[126]} {D[127]} {D[128]} {D[129]} {D[130]} {D[131]} {D[132]} {D[133]} {D[134]} {D[135]} {D[136]} {D[137]} {D[138]} {D[139]} {D[140]} {D[141]} {D[142]} {D[143]} {D[144]} {D[145]} {D[146]} {D[147]} {D[148]} {D[149]} {D[150]} {D[151]} {D[152]} {D[153]} {D[154]} {D[155]} {D[156]} {D[157]} {D[158]} {D[159]}}
pan -81.532 10.162
pan -87.823 13.065
pan -67.258 6.532
pan -31.936 0.000
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection counterclockwise -side Bottom -layer 1 -spreadType center -spacing 3 -pin {{D[0]} {D[1]} {D[2]} {D[3]} {D[4]} {D[5]} {D[6]} {D[7]} {D[8]} {D[9]} {D[10]} {D[11]} {D[12]} {D[13]} {D[14]} {D[15]} {D[16]} {D[17]} {D[18]} {D[19]} {D[20]} {D[21]} {D[22]} {D[23]} {D[24]} {D[25]} {D[26]} {D[27]} {D[28]} {D[29]} {D[30]} {D[31]} {D[32]} {D[33]} {D[34]} {D[35]} {D[36]} {D[37]} {D[38]} {D[39]} {D[40]} {D[41]} {D[42]} {D[43]} {D[44]} {D[45]} {D[46]} {D[47]} {D[48]} {D[49]} {D[50]} {D[51]} {D[52]} {D[53]} {D[54]} {D[55]} {D[56]} {D[57]} {D[58]} {D[59]} {D[60]} {D[61]} {D[62]} {D[63]} {D[64]} {D[65]} {D[66]} {D[67]} {D[68]} {D[69]} {D[70]} {D[71]} {D[72]} {D[73]} {D[74]} {D[75]} {D[76]} {D[77]} {D[78]} {D[79]} {D[80]} {D[81]} {D[82]} {D[83]} {D[84]} {D[85]} {D[86]} {D[87]} {D[88]} {D[89]} {D[90]} {D[91]} {D[92]} {D[93]} {D[94]} {D[95]} {D[96]} {D[97]} {D[98]} {D[99]} {D[100]} {D[101]} {D[102]} {D[103]} {D[104]} {D[105]} {D[106]} {D[107]} {D[108]} {D[109]} {D[110]} {D[111]} {D[112]} {D[113]} {D[114]} {D[115]} {D[116]} {D[117]} {D[118]} {D[119]} {D[120]} {D[121]} {D[122]} {D[123]} {D[124]} {D[125]} {D[126]} {D[127]} {D[128]} {D[129]} {D[130]} {D[131]} {D[132]} {D[133]} {D[134]} {D[135]} {D[136]} {D[137]} {D[138]} {D[139]} {D[140]} {D[141]} {D[142]} {D[143]} {D[144]} {D[145]} {D[146]} {D[147]} {D[148]} {D[149]} {D[150]} {D[151]} {D[152]} {D[153]} {D[154]} {D[155]} {D[156]} {D[157]} {D[158]} {D[159]}}
pan 38.226 7.984
pan 85.645 -3.387
pan 76.694 0.000
pan 104.032 3.871
pan -47.661 0.000
pan -89.999 -1.210
pan -98.467 0.000
pan -92.177 -14.032
pan -55.645 -2.419
pan 18.146 9.678
pan 47.419 7.742
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.09 -pinDepth 0.47 -fixOverlap 1 -unit MICRON -spreadDirection counterclockwise -side Bottom -layer 1 -spreadType center -spacing 4 -pin {{D[0]} {D[1]} {D[2]} {D[3]} {D[4]} {D[5]} {D[6]} {D[7]} {D[8]} {D[9]} {D[10]} {D[11]} {D[12]} {D[13]} {D[14]} {D[15]} {D[16]} {D[17]} {D[18]} {D[19]} {D[20]} {D[21]} {D[22]} {D[23]} {D[24]} {D[25]} {D[26]} {D[27]} {D[28]} {D[29]} {D[30]} {D[31]} {D[32]} {D[33]} {D[34]} {D[35]} {D[36]} {D[37]} {D[38]} {D[39]} {D[40]} {D[41]} {D[42]} {D[43]} {D[44]} {D[45]} {D[46]} {D[47]} {D[48]} {D[49]} {D[50]} {D[51]} {D[52]} {D[53]} {D[54]} {D[55]} {D[56]} {D[57]} {D[58]} {D[59]} {D[60]} {D[61]} {D[62]} {D[63]} {D[64]} {D[65]} {D[66]} {D[67]} {D[68]} {D[69]} {D[70]} {D[71]} {D[72]} {D[73]} {D[74]} {D[75]} {D[76]} {D[77]} {D[78]} {D[79]} {D[80]} {D[81]} {D[82]} {D[83]} {D[84]} {D[85]} {D[86]} {D[87]} {D[88]} {D[89]} {D[90]} {D[91]} {D[92]} {D[93]} {D[94]} {D[95]} {D[96]} {D[97]} {D[98]} {D[99]} {D[100]} {D[101]} {D[102]} {D[103]} {D[104]} {D[105]} {D[106]} {D[107]} {D[108]} {D[109]} {D[110]} {D[111]} {D[112]} {D[113]} {D[114]} {D[115]} {D[116]} {D[117]} {D[118]} {D[119]} {D[120]} {D[121]} {D[122]} {D[123]} {D[124]} {D[125]} {D[126]} {D[127]} {D[128]} {D[129]} {D[130]} {D[131]} {D[132]} {D[133]} {D[134]} {D[135]} {D[136]} {D[137]} {D[138]} {D[139]} {D[140]} {D[141]} {D[142]} {D[143]} {D[144]} {D[145]} {D[146]} {D[147]} {D[148]} {D[149]} {D[150]} {D[151]} {D[152]} {D[153]} {D[154]} {D[155]} {D[156]} {D[157]} {D[158]} {D[159]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection counterclockwise -side Bottom -layer 3 -spreadType center -spacing 4.0 -pin {{D[0]} {D[1]} {D[2]} {D[3]} {D[4]} {D[5]} {D[6]} {D[7]} {D[8]} {D[9]} {D[10]} {D[11]} {D[12]} {D[13]} {D[14]} {D[15]} {D[16]} {D[17]} {D[18]} {D[19]} {D[20]} {D[21]} {D[22]} {D[23]} {D[24]} {D[25]} {D[26]} {D[27]} {D[28]} {D[29]} {D[30]} {D[31]} {D[32]} {D[33]} {D[34]} {D[35]} {D[36]} {D[37]} {D[38]} {D[39]} {D[40]} {D[41]} {D[42]} {D[43]} {D[44]} {D[45]} {D[46]} {D[47]} {D[48]} {D[49]} {D[50]} {D[51]} {D[52]} {D[53]} {D[54]} {D[55]} {D[56]} {D[57]} {D[58]} {D[59]} {D[60]} {D[61]} {D[62]} {D[63]} {D[64]} {D[65]} {D[66]} {D[67]} {D[68]} {D[69]} {D[70]} {D[71]} {D[72]} {D[73]} {D[74]} {D[75]} {D[76]} {D[77]} {D[78]} {D[79]} {D[80]} {D[81]} {D[82]} {D[83]} {D[84]} {D[85]} {D[86]} {D[87]} {D[88]} {D[89]} {D[90]} {D[91]} {D[92]} {D[93]} {D[94]} {D[95]} {D[96]} {D[97]} {D[98]} {D[99]} {D[100]} {D[101]} {D[102]} {D[103]} {D[104]} {D[105]} {D[106]} {D[107]} {D[108]} {D[109]} {D[110]} {D[111]} {D[112]} {D[113]} {D[114]} {D[115]} {D[116]} {D[117]} {D[118]} {D[119]} {D[120]} {D[121]} {D[122]} {D[123]} {D[124]} {D[125]} {D[126]} {D[127]} {D[128]} {D[129]} {D[130]} {D[131]} {D[132]} {D[133]} {D[134]} {D[135]} {D[136]} {D[137]} {D[138]} {D[139]} {D[140]} {D[141]} {D[142]} {D[143]} {D[144]} {D[145]} {D[146]} {D[147]} {D[148]} {D[149]} {D[150]} {D[151]} {D[152]} {D[153]} {D[154]} {D[155]} {D[156]} {D[157]} {D[158]} {D[159]}}
pan -39.563 5.123
pan -91.936 1.708
pan 0.624 -1.419
pan 0.561 -0.903
pan 0.037 -0.175

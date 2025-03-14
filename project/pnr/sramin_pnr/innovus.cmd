#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Mar  9 15:40:31 2025                
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
set init_verilog ./netlist/sram_w16_in.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell sram_w16_in
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
floorPlan -s 250 50 10 10 10 10
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose
setAddStripeMode -break_at block_ring
addStripe -number_of_sets 15 -spacing 1 -layer M4 -width 1 -nets { VSS VDD } -start_from left -start 20 -stop 250
sroute
setPinAssignMode -pinEditInBatch true
editPin -fixedPin True -pinWidth 0.1 -pinDepth 0.52 -fixOverlap 1 -unit MICRON -spreadDirection counterclockwise -side Bottom -layer 4 -spreadType center -spacing 4 -pin {{D[0]} {D[1]} {D[2]} {D[3]} {D[4]} {D[5]} {D[6]} {D[7]} {D[8]} {D[9]} {D[10]} {D[11]} {D[12]} {D[13]} {D[14]} {D[15]} {D[16]} {D[17]} {D[18]} {D[19]} {D[20]} {D[21]} {D[22]} {D[23]} {D[24]} {D[25]} {D[26]} {D[27]} {D[28]} {D[29]} {D[30]} {D[31]} {D[32]} {D[33]} {D[34]} {D[35]} {D[36]} {D[37]} {D[38]} {D[39]} {D[40]} {D[41]} {D[42]} {D[43]} {D[44]} {D[45]} {D[46]} {D[47]} {D[48]} {D[49]} {D[50]} {D[51]} {D[52]} {D[53]} {D[54]} {D[55]} {D[56]} {D[57]} {D[58]} {D[59]} {D[60]} {D[61]} {D[62]} {D[63]}}
setPinAssignMode -pinEditInBatch true
editPin -fixedPin True -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 4 -spreadType center -spacing 4.0 -pin {{Q[0]} {Q[1]} {Q[2]} {Q[3]} {Q[4]} {Q[5]} {Q[6]} {Q[7]} {Q[8]} {Q[9]} {Q[10]} {Q[11]} {Q[12]} {Q[13]} {Q[14]} {Q[15]} {Q[16]} {Q[17]} {Q[18]} {Q[19]} {Q[20]} {Q[21]} {Q[22]} {Q[23]} {Q[24]} {Q[25]} {Q[26]} {Q[27]} {Q[28]} {Q[29]} {Q[30]} {Q[31]} {Q[32]} {Q[33]} {Q[34]} {Q[35]} {Q[36]} {Q[37]} {Q[38]} {Q[39]} {Q[40]} {Q[41]} {Q[42]} {Q[43]} {Q[44]} {Q[45]} {Q[46]} {Q[47]} {Q[48]} {Q[49]} {Q[50]} {Q[51]} {Q[52]} {Q[53]} {Q[54]} {Q[55]} {Q[56]} {Q[57]} {Q[58]} {Q[59]} {Q[60]} {Q[61]} {Q[62]} {Q[63]}}
setPinAssignMode -pinEditInBatch true
editPin -fixedPin True -pinWidth 0.1 -pinDepth 0.52 -fixOverlap 1 -unit MICRON -spreadDirection counterclockwise -side Left -layer 3 -spreadType center -spacing 4.0 -pin {{A[0]} {A[1]} {A[2]} {A[3]} CEN CLK WEN}
setMaxRouteLayer 4
saveDesign floorplan.enc
pan -31.797 10.598
pan -27.254 -7.873
pan -29.980 4.543
pan -21.954 -0.606
pan -22.258 4.240
pan -24.680 6.359
pan -20.290 2.119
pan 34.370 -6.359
pan 36.187 3.482

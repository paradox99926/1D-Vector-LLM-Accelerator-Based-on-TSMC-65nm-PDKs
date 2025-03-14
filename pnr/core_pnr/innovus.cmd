#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Mar 12 20:00:38 2025                
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
set init_verilog ./netlist/core.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell core
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_in.lef}
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_out.lef}
create_library_set -name WC_LIB -timing "$worst_timing_lib ./subckt/sram_w16_in_WC.lib ./subckt/sram_w16_out_WC.lib"
set init_pwr_net VDD
set init_gnd_net VSS
set init_verilog ./netlist/core.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell core
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_in.lef}
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_out.lef}
create_library_set -name WC_LIB -timing "$worst_timing_lib ./subckt/sram_w16_in_WC.lib ./subckt/sram_w16_out_WC.lib"
set init_pwr_net VDD
set init_gnd_net VSS
set init_verilog ./netlist/core.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell core
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_in.lef}
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_out.lef}
create_library_set -name WC_LIB -timing "$worst_timing_lib ./subckt/sram_w16_in_WC.lib ./subckt/sram_w16_out_WC.lib"
create_library_set -name BC_LIB -timing "$best_timing_lib ./subckt/sram_w16_in_BC.lib ./subckt/sram_w16_out_BC.lib"
create_rc_corner -name Cmax -cap_table $worst_captbl -T 125
create_rc_corner -name Cmin -cap_table $best_captbl -T -40
create_delay_corner -name WC -library_set WC_LIB -rc_corner Cmax
create_delay_corner -name BC -library_set BC_LIB -rc_corner Cmin
create_constraint_mode -name CON -sdc_file [list $sdc]
create_analysis_view -name WC_VIEW -delay_corner WC -constraint_mode CON
create_analysis_view -name BC_VIEW -delay_corner BC -constraint_mode CON
init_design -setup WC_VIEW -hold BC_VIEW
set init_pwr_net VDD
set init_gnd_net VSS
set init_verilog ./netlist/core.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell core
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_in.lef}
set init_lef_file {/home/linux/ieng6/ee260bwi25/xiz225/PDKdata/lef/tcbn65gplus_8lmT2.lef ./subckt/sram_w16_out.lef}
create_library_set -name WC_LIB -timing "$worst_timing_lib ./subckt/sram_w16_in_WC.lib ./subckt/sram_w16_out_WC.lib"
create_library_set -name BC_LIB -timing "$best_timing_lib ./subckt/sram_w16_in_BC.lib ./subckt/sram_w16_out_BC.lib"
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

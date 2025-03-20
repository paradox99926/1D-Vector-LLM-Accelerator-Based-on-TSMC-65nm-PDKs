streamOut ${design}.gds2 
# The stripe was done with M4. Thus, we define the PG layer to be "4".
# In addition, setting "-specifyTopLayer 4" is important. This will block all the routing under M4 layer during the top level PnR. So, power stripe should use >4 layer.
write_lef_abstract -stripePin -PGPinLayers {4} -extractBlockPGPinLayers {4} ${design}.lef -specifyTopLayer 4
defOut -netlist -routing ${design}.def
saveNetlist ${design}.pnr.v

setAnalysisMode -setup
set_analysis_view -setup WC_VIEW -hold WC_VIEW
do_extract_model -view WC_VIEW -format dotlib ${design}_WC.lib
write_sdf -view WC_VIEW ${design}_WC.sdf

setAnalysisMode -setup
set_analysis_view -setup TC_VIEW -hold TC_VIEW
do_extract_model -view TC_VIEW -format dotlib ${design}_TC.lib
write_sdf -view TC_VIEW ${design}_TC.sdf

setAnalysisMode -hold
set_analysis_view -setup BC_VIEW -hold BC_VIEW
do_extract_model -view BC_VIEW -format dotlib ${design}_BC.lib
write_sdf -view BC_VIEW ${design}_BC.sdf

setPinAssignMode -pinEditInBatch true
editPin -fixedPin True -fixOverlap True -unit MICRON -spreadDirection clockwise -side Top -layer 4 -spreadType center -spacing 4 -pin {clk clk_o {inst[*]} reset		 {sum_in[*]} fifo_ext_rd		 {sum_out[*]} div_ready}
editPin -fixedPin True -fixOverlap True -unit MICRON -spreadDirection counterclockwise -side Bottom -layer 4 -spreadType center -spacing 4 -pin {{out[*]}}
editPin -fixedPin True -fixOverlap True -unit MICRON -spreadDirection counterclockwise -side Right -layer 3 -spreadType center -spacing 4 -pin {SO SE SI clk_scan test_mode reset_scan}
editPin -fixedPin True -fixOverlap True -unit MICRON -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 4 -pin {{mem_in[*]}}
uiSetTool select
pan 339.771 22.652
fit
getPinAssignMode -pinEditInBatch -quiet
getPinAssignMode -pinEditInBatch -quiet
uiSetTool getLocation Rda_PE::Attr:getStartCoord
uiSetTool getLocation Rda_PE::Attr:getStartCoord
pan 11.491 -105.000
pan -4.755 18.622
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.1 -pinDepth 0.52 -fixedPin 1 -fixOverlap 1 -global_location -unit MICRON -spreadDirection clockwise -side Left -layer 3 -spreadType start -spacing 4 -start 0.0 300.0 -pin {{mem_in[0]} {mem_in[1]} {mem_in[2]} {mem_in[3]} {mem_in[4]} {mem_in[5]} {mem_in[6]} {mem_in[7]} {mem_in[8]} {mem_in[9]} {mem_in[10]} {mem_in[11]} {mem_in[12]} {mem_in[13]} {mem_in[14]} {mem_in[15]} {mem_in[16]} {mem_in[17]} {mem_in[18]} {mem_in[19]} {mem_in[20]} {mem_in[21]} {mem_in[22]} {mem_in[23]} {mem_in[24]} {mem_in[25]} {mem_in[26]} {mem_in[27]} {mem_in[28]} {mem_in[29]} {mem_in[30]} {mem_in[31]} {mem_in[32]} {mem_in[33]} {mem_in[34]} {mem_in[35]} {mem_in[36]} {mem_in[37]} {mem_in[38]} {mem_in[39]} {mem_in[40]} {mem_in[41]} {mem_in[42]} {mem_in[43]} {mem_in[44]} {mem_in[45]} {mem_in[46]} {mem_in[47]} {mem_in[48]} {mem_in[49]} {mem_in[50]} {mem_in[51]} {mem_in[52]} {mem_in[53]} {mem_in[54]} {mem_in[55]} {mem_in[56]} {mem_in[57]} {mem_in[58]} {mem_in[59]} {mem_in[60]} {mem_in[61]} {mem_in[62]} {mem_in[63]}}
pan -129.962 -13.075
pan -207.847 25.775
pan -187.484 113.097

uiSetTool getLocation Rda_PE::Attr:getStartCoord
uiSetTool getLocation Rda_PE::Attr:getStartCoord
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.1 -pinDepth 0.52 -fixedPin 1 -fixOverlap 1 -global_location -unit MICRON -spreadDirection clockwise -side Top -layer 4 -spreadType start -spacing 4 -start 450.0 650.0 -pin {clk clk_o div_ready fifo_ext_rd {inst[0]} {inst[1]} {inst[2]} {inst[3]} {inst[4]} {inst[5]} {inst[6]} {inst[7]} {inst[8]} {inst[9]} {inst[10]} {inst[11]} {inst[12]} {inst[13]} {inst[14]} {inst[15]} {inst[16]} {inst[17]} {inst[18]} {inst[19]} {inst[20]} reset {sum_in[0]} {sum_in[1]} {sum_in[2]} {sum_in[3]} {sum_in[4]} {sum_in[5]} {sum_in[6]} {sum_in[7]} {sum_in[8]} {sum_in[9]} {sum_in[10]} {sum_in[11]} {sum_in[12]} {sum_in[13]} {sum_in[14]} {sum_in[15]} {sum_in[16]} {sum_in[17]} {sum_in[18]} {sum_in[19]} {sum_in[20]} {sum_in[21]} {sum_in[22]} {sum_in[23]} {sum_out[0]} {sum_out[1]} {sum_out[2]} {sum_out[3]} {sum_out[4]} {sum_out[5]} {sum_out[6]} {sum_out[7]} {sum_out[8]} {sum_out[9]} {sum_out[10]} {sum_out[11]} {sum_out[12]} {sum_out[13]} {sum_out[14]} {sum_out[15]} {sum_out[16]} {sum_out[17]} {sum_out[18]} {sum_out[19]} {sum_out[20]} {sum_out[21]} {sum_out[22]} {sum_out[23]}}
pan -27.743 100.005
pan -4.554 71.350
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.1 -pinDepth 0.52 -fixedPin 1 -fixOverlap 1 -global_location -unit MICRON -spreadDirection counterclockwise -side Right -layer 3 -spreadType start -spacing 4 -start 900.0 380.0 -pin {clk_scan reset_scan SE SI SO test_mode}
checkPinAssignment

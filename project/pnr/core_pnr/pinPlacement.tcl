getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 3 -spreadType center -spacing 4 -pin {clk x[7] x[6] x[5] x[4] x[3] x[2] x[1] x[0] y[7] y[6] y[5] y[4] y[3] y[2] y[1] y[0] z[7] z[6] z[5] z[4] z[3] z[2] z[1] z[0]} -fixedPin true
editPin -fixOverlap 1 -unit MICRON -spreadDirection counterClockwise -side Right -layer 3 -spreadType center -spacing 8 -pin {out[6] out[5] out[4] out[3] out[2] out[1] out[0] } -fixedPin true

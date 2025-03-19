# Assign pins
# S S
# R R
# A A
# M M
# i i
# n n
#    S R A M O U T
setPinAssignMode -pinEditInBatch true

# Top edge
# Assign D (input data) pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection clockwise		\
	-side Top				\
	-layer 4				\
	-spreadType center			\
	-spacing 4				\
	-pin {clk clk_o {inst[*]} reset		\
		{sum_in[*]} fifo_ext_rd		\
		{sum_out[*]} div_ready}


# Bottom edge
# Assign Q (output data) pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Bottom				\
	-layer 4				\
	-spreadType center			\
	-spacing 4				\
	-pin {{out[*]}}


# Right edge
# Assign scan chain pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Right				\
	-layer 3				\
	-spreadType center			\
	-spacing 4				\
	-pin {SO SE SI clk_scan test_mode reset_scan}


# Left Edge
# Assign other pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection clockwise		\
	-side Left				\
	-layer 3				\
	-spreadType center			\
	-spacing 4				\
	-pin {{mem_in[*]}}



# Floorplan
#    S R A M O U T
# S S
# R R
# A A
# M M
# i i
# n n
#
# S S
# R R
# A A
# M M
# i i
# n n
#    S R A M O U T
#
#    sramout: 900*650
floorPlan -site core -s 1100 1600 50.0 50.0 50.0 50.0

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

# Add ring
addRing -spacing {top 5 bottom 5 left 5 right 5} 	\
	-width {top 10 bottom 10 left 10 right 10}	\
	-layer {top M1 bottom M1 left M2 right M2}	\
       	-center 1 					\
	-type core_rings				\
	-nets {VSS  VDD}

# Add stripe
setAddStripeMode -break_at {block_ring}
addStripe	-skip_via_on_wire_shape Noshape		\
		-block_ring_top_layer_limit M1		\
		-max_same_layer_jog_length 0.8		\
		-padcore_ring_bottom_layer_limit M1	\
		-number_of_sets 20			\
		-skip_via_on_pin Standardcell		\
		-stacked_via_top_layer M8		\
		-padcore_ring_top_layer_limit M1	\
		-spacing 0.4				\
		-merge_stripes_value 0.1		\
		-direction horizontal			\
		-layer M7				\
		-block_ring_bottom_layer_limit M1	\
		-width 2				\
		-area {}				\
		-nets {VDD VSS}				\
		-stacked_via_bottom_layer M1

# Add Submodule instance
setObjFPlanBox Instance core_instance0 150 150 1050 800
setObjFPlanBox Instance core_instance1 150 900 1050 1550
flipOrRotateObject -flip MX -name core_instance1

# Add halo for sub module instance
addHaloToBlock {3 3 3 3} core_instance0
addHaloToBlock {3 3 3 3} core_instance1

# Add ring for sub module instance
addRing -nets {VDD VSS}						\
	-type block_rings					\
	-around each_block 					\
	-layer {top M1 bottom M1 left M2 right M2} 		\
	-width   {top 0.5 bottom 0.5 left 0.5 right 0.5}	\
	-spacing {top 0.5 bottom 0.5 left 0.5 right 0.5}

# Connect PG pins between top module and sub module
globalNetConnect VDD -type pgpin -pin VDD -sinst core_instance0 -verbose -override      
globalNetConnect VSS -type pgpin -pin VSS -sinst core_instance1 -verbose -override

sroute 



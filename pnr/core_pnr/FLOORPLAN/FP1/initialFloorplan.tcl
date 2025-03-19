# Floorplan
# SRAMin SRAMin
#
#
# S R A M o u t
floorPlan -site core -s 780 480 10.0 10.0 10.0 10.0

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

# Add ring
addRing -spacing {top 1 bottom 1 left 1 right 1} 	\
	-width {top 2 bottom 2 left 2 right 2}		\
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
		-number_of_sets 15			\
		-skip_via_on_pin Standardcell		\
		-stacked_via_top_layer M8		\
		-padcore_ring_top_layer_limit M1	\
		-spacing 1				\
		-merge_stripes_value 0.1		\
		-direction vertical			\
		-layer M5				\
		-block_ring_bottom_layer_limit M1	\
		-width 1				\
		-area {}				\
		-nets {VDD VSS}				\
		-stacked_via_bottom_layer M1

# Add sub-module instance
setObjFPlanBox Instance qmem_instance 465 370 735 440
setObjFPlanBox Instance kmem_instance 65 370 335 440
setObjFPlanBox Instance psum_mem_instance 65 60 735 180

flipOrRotateObject -flip MX -name qmem_instance
flipOrRotateObject -flip MX -name kmem_instance
flipOrRotateObject -flip MX -name psum_mem_instance

addHaloToBlock {3 3 3 3} qmem_instance
addHaloToBlock {3 3 3 3} kmem_instance
addHaloToBlock {3 3 3 3} psum_mem_instance


addRing -nets {VDD VSS}						\
	-type block_rings					\
	-around each_block 					\
	-layer {top M1 bottom M1 left M2 right M2} 		\
	-width   {top 0.5 bottom 0.5 left 0.5 right 0.5}	\
	-spacing {top 0.5 bottom 0.5 left 0.5 right 0.5}


globalNetConnect VDD -type pgpin -pin VDD -sinst psum_mem_instance -verbose -override
globalNetConnect VSS -type pgpin -pin VSS -sinst qmem_instance -verbose -override        
globalNetConnect VSS -type pgpin -pin VSS -sinst kmem_instance -verbose -override

sroute 



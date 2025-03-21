# Floorplan
# S S
# R R
# A A
# M M
# i i
# n n
#    S R A M O U T
#
#    sramin: 320*120
#    sramout: 720*130
floorPlan -site core -s 800 550 50.0 50.0 50.0 50.0

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

# Add ring
addRing -spacing {top 5 bottom 5 left 5 right 5} 	\
	-width {top 10 bottom 10 left 10 right 10}		\
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
		-number_of_sets 10			\
		-skip_via_on_pin Standardcell		\
		-stacked_via_top_layer M8		\
		-padcore_ring_top_layer_limit M1	\
		-spacing 1				\
		-merge_stripes_value 0.1		\
		-direction horizontal			\
		-layer M5				\
		-block_ring_bottom_layer_limit M1	\
		-width 2				\
		-area {}				\
		-nets {VDD VSS}				\
		-stacked_via_bottom_layer M1



setObjFPlanBox Instance qmem_instance 40 150 110 420
flipOrRotateObject -rotate R90 -name qmem_instance
flipOrRotateObject -flip MY -name qmem_instance
setObjFPlanBox Instance kmem_instance 140 150 210 420
flipOrRotateObject -rotate R90 -name kmem_instance
flipOrRotateObject -flip MY -name kmem_instance
setObjFPlanBox Instance psum_mem_instance 240 60 910 180
flipOrRotateObject -flip MX -name psum_mem_instance
pan -307.474 8.977
uiSetTool move
selectInst psum_mem_instance
setObjFPlanBox Instance psum_mem_instance 374.6605 80.199 1104.6605 210.199
deselectAll
selectInst kmem_instance
setObjFPlanBox Instance kmem_instance 274.6605 271.1945 394.6605 591.1945
deselectAll
selectInst qmem_instance
setObjFPlanBox Instance qmem_instance 93.864 268.95 213.864 588.95
fit
setObjFPlanBox Instance qmem_instance 93.865 267.1735 213.865 587.1735
deselectAll
selectInst kmem_instance
setObjFPlanBox Instance kmem_instance 271.107 265.8655 391.107 585.8655

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



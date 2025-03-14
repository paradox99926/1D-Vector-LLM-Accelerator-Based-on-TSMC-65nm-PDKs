# Placement
saveDesign floorplan.enc
#setPlaceMode -timingDriven true -reorderScan false -congEffort medium -modulePlan false -placeIOPins false 

#Note it is important not to use "-modulePlan false" (default is true. So, you could remove the part as well)
setPlaceMode -timingDriven true -reorderScan false -congEffort medium -modulePlan True -placeIOPins false 

setOptMode -effort high -powerEffort high -leakageToDynamicRatio 0.5 -fixFanoutLoad true -restruct true -verbose true 
place_opt_design

addFiller -cell {DCAP DCAP4 DCAP8 DCAP16 DCAP32} -merge true

saveDesign placement.enc

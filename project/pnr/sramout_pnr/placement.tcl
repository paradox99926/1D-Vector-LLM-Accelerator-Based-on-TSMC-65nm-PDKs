# Placement
# Make sure that the max route is maintained to be up to MX.
# This should be consistent with lef gen command in outputgen tcl.
setMaxRouteLayer 4 
saveDesign floorplan.enc
setPlaceMode -timingDriven true -reorderScan false -congEffort medium -modulePlan false
setOptMode -effort high -powerEffort high -leakageToDynamicRatio 0.5 -fixFanoutLoad true -restruct true -verbose true
place_opt_design

#addFiller -cell {FILL FILL4 FILL8 FILL16 DCAP DCAP4 DCAP8 DCAP16 DCAP32}
addFiller -cell {FILL FILL4 DCAP8 DCAP16 DCAP32}

saveDesign placement.enc

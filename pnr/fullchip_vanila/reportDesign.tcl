# DRV Check
verifyGeometry > ./summaryReport/${design}.geom.rpt
verifyConnectivity > ./summaryReport/${design}.conn.rpt

# Timing report
report_timing -max_paths 5 > ./summaryReport/${design}.post_route.timing.rpt

# Power report
report_power -outfile ./summaryReport/${design}.post_route.power.rpt

# Design report
summaryReport -nohtml -outfile ./summaryReport/${design}.post_route.summary.rpt



set patterns { \
    "innovus.log*" \
    "command.log*" \
    ".cadence" \
    "*old" \
    "*asrt*" \
    "*.cmd" \
    "*.rs*" \
    "*.tif*" \
    "*.nfs*" \
    "*rpt"}

foreach pattern $patterns {
    set files [glob -nocomplain $pattern]
    foreach f $files {
        if {[file exists $f]} {
            puts "Deleting: $f"
            file delete -force $f}}}

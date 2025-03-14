if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name WC_LIB\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn65gpluswc.lib]
create_library_set -name BC_LIB\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn65gplusbc.lib]
create_rc_corner -name Cmin\
   -cap_table ${::IMEX::libVar}/mmmc/cln65g+_1p08m+alrdl_top2_cbest.captable\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T -40
create_rc_corner -name Cmax\
   -cap_table ${::IMEX::libVar}/mmmc/cln65g+_1p08m+alrdl_top2_cworst.captable\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 125
create_delay_corner -name WC\
   -library_set WC_LIB\
   -rc_corner Cmax
create_delay_corner -name BC\
   -library_set BC_LIB\
   -rc_corner Cmin
create_constraint_mode -name CON\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/sram_w16_in.sdc]
create_analysis_view -name WC_VIEW -constraint_mode CON -delay_corner WC
create_analysis_view -name BC_VIEW -constraint_mode CON -delay_corner BC
set_analysis_view -setup [list WC_VIEW] -hold [list BC_VIEW]

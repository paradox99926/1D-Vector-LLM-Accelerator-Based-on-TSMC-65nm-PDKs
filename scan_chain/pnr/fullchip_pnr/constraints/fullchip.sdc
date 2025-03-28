
set clock_cycle 1.0 
# set clock_cycle_scan 5.0 
set io_delay 0.2 

set clock_port clk
# set clock_port_out clk_o
# set clock_port_scan clk_scan

set_false_path -from [get_ports reset]
create_clock -name clk -period $clock_cycle [get_ports $clock_port]
# create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]

set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {inst}]
set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {mem_in}]
set_false_path -from [get_ports {reset reset_scan}]

set_output_delay -clock $clock_port -add_delay -max $io_delay [get_ports {out}]



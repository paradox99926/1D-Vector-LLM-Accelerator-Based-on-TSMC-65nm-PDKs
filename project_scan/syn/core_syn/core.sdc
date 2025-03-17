
set clock_cycle 1.0 
# set clock_cycle_scan 5.0 
set io_delay 0.2 

set clock_port clk
set clock_port_out clk_o
# set clock_port_scan clk_scan

create_clock -name clk -period $clock_cycle [get_ports $clock_port]
create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]
# create_clock -name clk_scan -period $clock_cycle_scan [get_ports $clock_port_scan]

set_input_delay -clock $clock_port -add_delay -max $io_delay [remove_from_collection [all_inputs] \
    [get_ports {clk clk_o reset test_mode clk_scan reset_scan SI SE}]]
set_output_delay -clock $clock_port -add_delay -max $io_delay [remove_from_collection [all_outputs] [get_ports {sum_out SO}]]

set_output_delay -clock $clock_port_out -add_delay -max $io_delay [get_ports {sum_out}] 

# set_intput_delay -clock $clock_port_scan -add_delay -max $io_delay [get_ports {test_mode clk_scan SI SE}] 
# set_output_delay -clock $clock_port_scan -add_delay -max $io_delay [get_ports {SO}] 




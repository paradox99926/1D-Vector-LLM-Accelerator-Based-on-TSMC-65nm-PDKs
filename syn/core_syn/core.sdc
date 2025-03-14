
set clock_cycle 1.0 
set io_delay 0.2 

set clock_port clk
set clock_port_out clk_o

create_clock -name clk -period $clock_cycle [get_ports $clock_port]
create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]

set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {*}] -exclude [get_ports reset]
set_output_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {*}] -exclude [get_ports sum_out]

set_output_delay -clock [get_clocks clk_o] -add_delay -max $io_delay [get_ports {sum_out}] 




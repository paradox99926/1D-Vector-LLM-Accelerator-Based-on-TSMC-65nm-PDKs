
set clock_cycle 1.0 
set io_delay 0.2 

set clock_port clk
set clock_port_out clk_o

create_clock -name clk -period $clock_cycle [get_ports $clock_port]
create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]

#innovus says ERROR: (IMPTCM-48):	"-exclude" is not a legal option for command "set_output_delay". Either the current option or an option prior to it is not specified correctly."
#so I am gonna set all the delay one by one.
#set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {*}] -exclude [get_ports reset]
#set_output_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {*}] -exclude [get_ports sum_out]
set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {sum_in}]
set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {mem_in}]
set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {inst}]
set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {fifo_ext_rd}]

set_output_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {out}]
set_output_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {div_ready}]



set_input_delay -clock [get_clocks clk_o] -add_delay -max $io_delay [get_ports {reset}] 
set_output_delay -clock [get_clocks clk_o] -add_delay -max $io_delay [get_ports {sum_out}] 




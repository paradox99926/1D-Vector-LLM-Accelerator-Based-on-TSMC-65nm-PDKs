
set clock_cycle 1.0 
# set clock_cycle_scan 5.0 
set io_delay 0.2 

set clock_port clk
set clock_port_out clk_o
# set clock_port_scan clk_scan

create_clock -name clk -period $clock_cycle [get_ports $clock_port]
create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]
# create_clock -name clk_scan -period $clock_cycle_scan [get_ports $clock_port_scan]

set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {inst}]
set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {sum_in}]
set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {mem_in}]

set_output_delay -clock $clock_port -add_delay -max $io_delay [get_ports {div_ready}]
set_output_delay -clock $clock_port -add_delay -max $io_delay [get_ports {out}]

set_output_delay -clock $clock_port_out -add_delay -max $io_delay [get_ports {sum_out}] 
set_input_delay -clock $clock_port_out -add_delay -max $io_delay [get_ports {fifo_ext_rd}] 

# set_intput_delay -clock $clock_port_scan -add_delay -max $io_delay [get_ports {test_mode clk_scan SI SE}] 
# set_output_delay -clock $clock_port_scan -add_delay -max $io_delay [get_ports {SO}] 

set_multicycle_path 2 -setup -from [get_cells "sfp_row_instance/sfp_in_temp_reg*"] -to [get_cells "psum_mem_instance/memory_reg*"]
set_multicycle_path 1 -hold -from  [get_cells "sfp_row_instance/sfp_in_temp_reg*"] -to [get_cells "psum_mem_instance/memory_reg*"]


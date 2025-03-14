
set clock_cycle 1.0 
set io_delay 0.2 

set clock_port clk
set clock_port_out clk_o

create_clock -name clk -period $clock_cycle [get_ports $clock_port]
create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]

set_input_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {*}] -exclude [get_ports reset]
set_output_delay -clock [get_clocks clk] -add_delay -max $io_delay [get_ports {*}] -exclude [get_ports sum_out]

set_output_delay -clock [get_clocks clk_o] -add_delay -max $io_delay [get_ports {sum_out}] 

set_multicycle_path -setup 2 -from [get_cells  mac_array_instance/col_idx_4__mac_col_inst/key_q_reg*/CP* ] -to [get_cells mac_array_instance/col_idx_4__mac_col_inst/mac_8in_instance/temp_reg_0__14_/D*]
set_multicycle_path -hold 1 -from [get_cells  mac_array_instance/col_idx_4__mac_col_inst/key_q_reg*/CP* ] -to [get_cells mac_array_instance/col_idx_4__mac_col_inst/mac_8in_instance/temp_reg_0__14_/D*]



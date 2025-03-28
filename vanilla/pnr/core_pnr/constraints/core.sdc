
set clock_cycle 1.0 
# set clock_cycle_scan 5.0 
set io_delay 0.2 

set clock_port clk
set clock_port_out clk_o
# set clock_port_scan clk_scan

set_false_path -from [get_ports reset]
create_clock -name clk -period $clock_cycle [get_ports $clock_port]
create_clock -name clk_o -period $clock_cycle [get_ports $clock_port_out]

set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {inst}]
set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {sum_in}]
set_input_delay -clock $clock_port -add_delay -max $io_delay [get_ports {mem_in}]

set_output_delay -clock $clock_port -add_delay -max $io_delay [get_ports {div_ready}]
set_output_delay -clock $clock_port -add_delay -max $io_delay [get_ports {out}]

set_output_delay -clock $clock_port_out -add_delay -max $io_delay [get_ports {sum_out}] 
set_input_delay -clock $clock_port_out -add_delay -max $io_delay [get_ports {fifo_ext_rd}] 

# set_load 0.1 [get_ports *]
# set_max_capacitance 0.5 [get_ports *]
# set_driving_cell -lib_cell DFF1 -pin Q [get_ports *]

set_multicycle_path 3 -setup -from [get_cells "sfp_row_instance/sfp_in_temp_reg*"] -to [get_pins "sfp_row_instance/sfp_out"]
set_multicycle_path 3 -setup -from [get_cells "sfp_row_instance/sum_2core_temp_reg*"] -to [get_pins "sfp_row_instance/sfp_out"]

set_multicycle_path 2 -hold -from  [get_cells "sfp_row_instance/sfp_in_temp_reg*"] -to [get_pins "sfp_row_instance/sfp_out"]
set_multicycle_path 2 -hold -from  [get_cells "sfp_row_instance/sum_2core_temp_reg*"] -to [get_pins "sfp_row_instance/sfp_out"]


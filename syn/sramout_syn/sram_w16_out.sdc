# Synopsis design constraints for sramout
set clock_cycle 1.0 
set io_delay 0.2

set clock_port CLK
create_clock -name CLK -period $clock_cycle [get_ports $clock_port]

set_input_delay  -clock $clock_port -add_delay -max $io_delay [all_inputs]
set_output_delay -clock $clock_port -add_delay -max $io_delay [all_outputs]

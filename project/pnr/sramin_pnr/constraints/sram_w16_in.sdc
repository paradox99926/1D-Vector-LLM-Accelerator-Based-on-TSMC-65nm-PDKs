
set clock_cycle 1
set io_delay 0.2 

set clock_port CLK

create_clock -name CLK -period $clock_cycle [get_ports $clock_port]


set_input_delay -clock [get_clocks CLK] -add_delay -max $io_delay [get_ports {WEN}]
set_input_delay -clock [get_clocks CLK] -add_delay -max $io_delay [get_ports {CEN}]
set_input_delay -clock [get_clocks CLK] -add_delay -max $io_delay [get_ports {D}]
set_input_delay -clock [get_clocks CLK] -add_delay -max $io_delay [get_ports {A}]

set_output_delay -clock [get_clocks CLK] -add_delay -max $io_delay [get_ports {Q}]



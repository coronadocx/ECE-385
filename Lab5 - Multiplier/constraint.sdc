#**************************************************************
# Create Clock (where ‘CLK’ is the user-defined system clock name)
#**************************************************************
create_clock -name {CLK} -period 20ns -waveform {0.000 5.000}
[get_ports {CLK}]
#creates a clock, applies it to all ports named "CLK" in toplevel
#note: -waveform specifies duty cycle, in this case 50%
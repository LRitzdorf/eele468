onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Testbench Controls}
add wave -noupdate /adc_controller_tb/clk
add wave -noupdate /adc_controller_tb/reset
add wave -noupdate -radix binary /adc_controller_tb/config
add wave -noupdate /adc_controller_tb/sdo
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /adc_controller_tb/dut/current_state
add wave -noupdate /adc_controller_tb/dut/next_state
add wave -noupdate /adc_controller_tb/dut/state_counter
add wave -noupdate /adc_controller_tb/dut/pause
add wave -noupdate /adc_controller_tb/dut/discard_sample
add wave -noupdate /adc_controller_tb/dut/traverser_launch
add wave -noupdate /adc_controller_tb/dut/traverser_found
add wave -noupdate -divider Outputs
add wave -noupdate /adc_controller_tb/sample_wr
add wave -noupdate /adc_controller_tb/dut/convst
add wave -noupdate /adc_controller_tb/dut/sck
add wave -noupdate /adc_controller_tb/dut/sdi
add wave -noupdate /adc_controller_tb/dut/sdo
add wave -noupdate -divider {Shift Registers}
add wave -noupdate /adc_controller_tb/dut/shift_clk
add wave -noupdate /adc_controller_tb/dut/config_idx
add wave -noupdate -radix binary /adc_controller_tb/dut/config_data
add wave -noupdate /adc_controller_tb/dut/config_load
add wave -noupdate /adc_controller_tb/dut/sample
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 216
configure wave -valuecolwidth 73
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update

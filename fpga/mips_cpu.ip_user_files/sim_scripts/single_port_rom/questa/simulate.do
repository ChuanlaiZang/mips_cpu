onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib single_port_rom_opt

do {wave.do}

view wave
view structure
view signals

do {single_port_rom.udo}

run -all

quit -force

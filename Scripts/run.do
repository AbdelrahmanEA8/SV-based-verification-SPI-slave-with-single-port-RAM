vlib work
vlog -cover sbceft -f file.txt
vsim -voptargs=+acc work.TOP -cover

add wave -position 1 -color white sim:/TOP/MySpi_if/clk
add wave -position 2 -radix unsigned sim:/TOP/MySpi_if/rst_n
add wave -position 3 -radix unsigned sim:/TOP/MySpi_if/SS_n
add wave -position 4 -radix unsigned sim:/TOP/DUT/SPI/rx_valid
add wave -position 5 -color yellow -radix hexadecimal sim:/TOP/DUT/SPI/rx_data
add wave -position 6 -radix unsigned sim:/TOP/DUT/SPI/tx_valid
add wave -position 7 -color yellow -radix hexadecimal sim:/TOP/DUT/SPI/tx_data
add wave -position 8 -color yellow -radix unsigned sim:/TOP/MySpi_if/MOSI
add wave -position 9 -color yellow -radix unsigned sim:/TOP/MySpi_if/MISO
add wave -position 10 -color orange -radix hexadecimal sim:/TOP/DUT/SPI/shift_reg
add wave -position 11 -radix unsigned sim:/TOP/DUT/SPI/PREV_Read_ADD
add wave -position 12 -radix unsigned sim:/TOP/DUT/SPI/ns
add wave -position 13 -radix unsigned sim:/TOP/DUT/SPI/cs
add wave -position 14 -radix unsigned sim:/TOP/DUT/SPI/counter_1
add wave -position 15 -color orange -radix hexadecimal sim:/TOP/DUT/Ram/dout
add wave -position 16 -color yellow -radix hexadecimal sim:/TOP/DUT/Ram/din
add wave -position insertpoint  \
sim:/shared_pkg::is_write \
sim:/shared_pkg::is_read_data

coverage save TOP.ucdb -onexit
run -all
coverage report -output Scover_report.txt -srcfile=RAM.v -srcfile=SPI_wrapper.v -srcfile=SPI_slave.v -detail -all -dump -annotate -option -assert -directive -cvg -codeAll
coverage report -detail -cvg -directive -comments -output fcover_report.txt {}
coverage exclude -cvgpath /spi_coverage_pkg/spi_coverage/spi_transaction_cg
vcover report -html -output coverage_html TOP.ucdb
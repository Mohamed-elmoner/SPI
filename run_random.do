vlib work
vlog Project.v Project_Ram.v SPI.v tb2_SPI.v
vsim -voptargs=+acc work.SPI_Wrapper_tb_random
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb_random/clk \
sim:/SPI_Wrapper_tb_random/rst_n \
sim:/SPI_Wrapper_tb_random/SS_n \
sim:/SPI_Wrapper_tb_random/MOSI \
sim:/SPI_Wrapper_tb_random/MISO \
sim:/SPI_Wrapper_tb_random/dut/SPI_BLOCK/tx_valid\
sim:/SPI_Wrapper_tb_random/dut/SPI_BLOCK/rx_valid\
sim:/SPI_Wrapper_tb_random/dut/SPI_BLOCK/cs\
sim:/SPI_Wrapper_tb_random/i \
sim:/SPI_Wrapper_tb_random/dut/RAM_BLOCK/write_addr\
sim:/SPI_Wrapper_tb_random/dut/RAM_BLOCK/read_addr\
sim:/SPI_Wrapper_tb_random/dut/SPI_BLOCK/tx_data\
sim:/SPI_Wrapper_tb_random/dut/RAM_BLOCK/mem
run -all
#quit -sim
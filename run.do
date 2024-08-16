vlib work
vlog Project.v Project_Ram.v SPI.v tb_SPI.v
vsim -voptargs=+acc work.SPI_Wrapper_tb_directed
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb_directed/clk \
sim:/SPI_Wrapper_tb_directed/rst_n \
sim:/SPI_Wrapper_tb_directed/SS_n \
sim:/SPI_Wrapper_tb_directed/MOSI \
sim:/SPI_Wrapper_tb_directed/MISO \
sim:/SPI_Wrapper_tb_directed/dut/SPI_BLOCK/tx_valid\
sim:/SPI_Wrapper_tb_directed/dut/SPI_BLOCK/rx_valid\
sim:/SPI_Wrapper_tb_directed/dut/SPI_BLOCK/cs\
sim:/SPI_Wrapper_tb_directed/dut/RAM_BLOCK/write_addr\
sim:/SPI_Wrapper_tb_directed/dut/RAM_BLOCK/read_addr\
sim:/SPI_Wrapper_tb_directed/dut/SPI_BLOCK/tx_data\
sim:/SPI_Wrapper_tb_directed/dut/RAM_BLOCK/mem
run -all
#quit -sim
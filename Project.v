module SPI_Wrapper(clk, rst_n,MOSI, SS_n,MISO);
input clk,rst_n,MOSI,SS_n;
output MISO;
wire [9:0] rx_data;
wire rx_valid,tx_valid;
wire [7:0] tx_data;
SPI SPI_BLOCK(.MOSI(MOSI),.MISO(MISO),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.tx_data(tx_data),.tx_valid(tx_valid),.rx_data(rx_data),.rx_valid(rx_valid));
RAM RAM_BLOCK(.din(rx_data),.rx_valid(rx_valid),.clk(clk),.rst_n(rst_n),.dout(tx_data),.tx_valid(tx_valid));
endmodule
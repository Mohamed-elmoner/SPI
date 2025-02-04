module RAM (clk,rst_n,din,rx_valid,dout,tx_valid);
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;
input clk, rst_n;
input [ADDR_SIZE+1:0] din;
input rx_valid;
output reg [ADDR_SIZE-1:0]dout;
output reg tx_valid;
reg [ADDR_SIZE-1:0]write_addr,read_addr;
reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
    always @(posedge clk) begin
        if (~rst_n) begin
            dout <= 0;
            tx_valid <= 0;
        end else if (rx_valid) begin
            if (din[ADDR_SIZE+1:ADDR_SIZE] == 2'b00) begin
                write_addr <= din[ADDR_SIZE-1:0];
                tx_valid <= 0;
            end else if (din[ADDR_SIZE+1:ADDR_SIZE]==2'b01) begin
                mem[write_addr] <= din[ADDR_SIZE-1:0];
                tx_valid <= 0;
            end else if (din[ADDR_SIZE+1:ADDR_SIZE]==2'b10) begin
                read_addr <= din[ADDR_SIZE-1:0];
                tx_valid <= 0;
            end else if (din[ADDR_SIZE+1:ADDR_SIZE]==2'b11) begin
                dout <= mem[read_addr];
                tx_valid <= 1;
            end
        end 
    end
endmodule
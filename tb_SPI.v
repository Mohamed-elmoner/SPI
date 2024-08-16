module SPI_Wrapper_tb_directed();
reg  MOSI,SS_n,clk,rst_n;
wire MISO;
SPI_Wrapper dut(clk, rst_n,MOSI, SS_n,MISO);
initial begin
	clk=0;
	forever
	#1  clk=~clk;
end

initial begin
	$readmemh("mem.dat",dut.RAM_BLOCK.mem);
	@(negedge clk);
    SS_n=1;
	rst_n=0;
    repeat(2)
	@(negedge clk); 
    rst_n=1;
    @(negedge clk); 
	SS_n=0;
	repeat(3) begin
    @(negedge clk);
    MOSI=0;
    end
	repeat (4) begin
   @(negedge clk);//directed test to write in address 00001111
    MOSI=0;
    end
    repeat (4) begin
    @(negedge clk);//directed test to write in address 00001111
    MOSI=1;
    end
    @(negedge clk);
    SS_n=1;
    @(negedge clk); 
	SS_n=0;
	repeat(2) begin
    @(negedge clk);
    MOSI=0;
    end
    @(negedge clk);
    MOSI=1;
	repeat (2) begin
    @(negedge clk);//directed test to write  11000010
    MOSI=1;
    end
    repeat (4) begin
    @(negedge clk);//directed test to write  11000010
    MOSI=0;
    end
    repeat (1) begin
    @(negedge clk);//directed test to write 11000010
    MOSI=1;
    end
     repeat (1) begin
    @(negedge clk);//directed test to write 11000010
    MOSI=0;
    end
   @(negedge clk); 
    SS_n=1;
    @(negedge clk); 
	SS_n=0;
    repeat(2) begin
    @(negedge clk);
    MOSI=1;
    end
    @(negedge clk);
    MOSI=0;
	repeat (4) begin
@(negedge clk);//directed test to read address 00001111
    MOSI=0;
    end
    repeat (4) begin
    @(negedge clk);//directed test to read address 00001111
    MOSI=1;
    end
 @(negedge clk); 
    SS_n=1;
    @(negedge clk); 
	SS_n=0;
    repeat(3) begin
     @(negedge clk); 
    MOSI=1;
    end
	repeat (8) begin
    @(negedge clk);//dummy    
    MOSI=$random;
    end
    repeat (9) begin
    @(negedge clk);//dummy
    end
    @(negedge clk);
    SS_n=1;
	$stop;
end

endmodule
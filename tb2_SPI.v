module SPI_Wrapper_tb_random();
reg  MOSI;
reg SS_n,clk,rst_n;
wire MISO;
integer i;
SPI_Wrapper dut(clk, rst_n,MOSI, SS_n,MISO);
initial begin
	clk=0;
	forever
	#1  clk=~clk;
end

initial begin
	$readmemh("mem.dat",dut.RAM_BLOCK.mem);
	rst_n=0;
    SS_n=1;
	@(negedge clk); 
    rst_n=1;
	for(i=0;i<4;i=i+1) begin
	  @(negedge clk);
	  SS_n=0; //test write
	  @(negedge clk); 
      MOSI=0;
	  @(negedge clk); 
      MOSI=0;
	  @(negedge clk); 
      MOSI=0;
	  repeat (8) begin
	  @(negedge clk); 
      MOSI=$random;
      end
	  @(negedge clk); 
      SS_n=1;
	  @(negedge clk); 
      SS_n=0; 
	  @(negedge clk); 
      MOSI=0;
	  @(negedge clk); 
      MOSI=0;
	  @(negedge clk); 
      MOSI=1;
	  repeat (8) begin
	  @(negedge clk); 
      MOSI=$random;
      end
	  @(negedge clk); 
      SS_n=1;
	
	  @(negedge clk); 
      SS_n=0;  
	  @(negedge clk); 
      MOSI=1;
	  @(negedge clk); 
      MOSI=1;
	  @(negedge clk); 
      MOSI=0;
	 repeat (8) begin
	  @(negedge clk); 
      MOSI=$random;
      end
	  @(negedge clk); 
      SS_n=1;
	  @(negedge clk); 
      SS_n=0;
	  @(negedge clk); 
      MOSI=1;
	  @(negedge clk); 
      MOSI=1;
	  @(negedge clk); 
      MOSI=1;
	  repeat (8) begin
	  @(negedge clk); 
      MOSI=$random;
      end
	  repeat (8) begin
	  @(negedge clk); 
      MOSI=$random;
      end
	  @(negedge clk); 
      SS_n=1;
	end

@(negedge clk); 
$stop;
end

endmodule
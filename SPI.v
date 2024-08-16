module SPI(MOSI,MISO,SS_n,clk,rst_n,tx_data,tx_valid,rx_data,rx_valid);
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD =3'b011;
parameter READ_DATA=3'b100;
input MOSI;
input  [7:0] tx_data;
input SS_n,clk,rst_n,tx_valid;
output reg MISO;
output reg rx_valid;
output reg [9:0] rx_data;
reg[3:0] counter,i; 
(*fsm_encoding="gray"*)
reg [2:0] cs, ns;
reg read_flag;
//ns logic
always @ (*) begin
  case (cs)
    IDLE:
       if(!SS_n)
       ns=CHK_CMD;
       else 
       ns=IDLE;
    CHK_CMD:
          if(SS_n==0 && MOSI==0)
          ns=WRITE;
          else if(SS_n==0 && MOSI==1 &&read_flag==0 ) 
          ns=READ_ADD;
          else if(SS_n==0 && MOSI==1 &&read_flag==1) 
          ns=READ_DATA;
          else
          ns=IDLE;
    WRITE:          
            if(SS_n)
            ns=IDLE;
            else
            ns=WRITE;
    READ_ADD:
            if(SS_n) 
            ns=IDLE;
            else 
            ns=READ_ADD;
    READ_DATA:
              if(SS_n)
              ns=IDLE;
              else
              ns=READ_DATA;
    default :
              ns=IDLE;
    endcase                
end

// state memory
always @(posedge clk) begin
  if(~rst_n) begin
  cs<=IDLE;
  read_flag<=0;
  end
   else begin
    cs<=ns;
    if(ns==READ_ADD)
    read_flag<=1;
    else if(ns==READ_DATA)
    read_flag<=0;
  end
end

// output logic
always @ (posedge clk) begin
  case (cs)
  IDLE:{i,counter,rx_data,rx_valid,MISO}<=0;
    CHK_CMD:
         {i,counter,rx_data,rx_valid,MISO}<=0;
  WRITE:begin 
             rx_data<={rx_data[8:0],MOSI};
             if(counter==9) begin
             rx_valid<=1;
             counter<=0;
             end
             else
             rx_valid<=0;
             MISO<=0; 
             counter<=counter+1;
        end
    READ_ADD:begin
             rx_data<={rx_data[8:0],MOSI};
             if(counter==9) begin
             rx_valid<=1;
             counter<=0;
             end
             else begin
             rx_valid<=0;
             MISO<=0;
             counter<=counter+1;
             end
           end      
    READ_DATA:
             begin
              rx_data<={rx_data[8:0],MOSI}; 
              if(counter==9) begin
              rx_valid<=1;
              counter<=0;
              end
              else begin
              rx_valid<=0;
              counter<=counter+1;
              end
              if(tx_valid)begin
              MISO<=tx_data[7-i];
              if(i==7) 
              i<=0;
             else
              i<=i+1;
              end
              else 
              MISO<=0;
            end  
    default :{rx_data,rx_valid,MISO}<=0;
    endcase
end
endmodule
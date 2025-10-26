`timescale 1ps/1ps
module SPIProtocol (
    input  clk,
    input  rst,
    input  [15:0]dat_in,
    output spi_mclk,
    output spi_dat,
    output spi_ssal,
    output [4:0]bit_count
);
reg [15:0] MOSI;
reg [4:0] count;
reg ssal;
reg mclk;
reg [1:0] state;
always @ (posedge clk or posedge rst)
if (rst)
    begin
        MOSI    <= 16'b0;
        count   <= 5'd16;
        ssal    <= 1'b1;
        mclk    <= 1'b0;
    end
else
    begin
        case (state)
            0:begin
                mclk    <= 1'b0;
                ssal    <= 1'b1;
                state   <= 1;
              end
            1:begin
                mclk    <= 1'b0;
                ssal    <= 1'b0;
                MOSI    <= dat_in[count-1];
                count   <= count-1;
                state   <= 2;
              end
            
            2:begin
                mclk    <= 1'b1;
                if (count > 0)
                    state <= 1;
                    
                else
                    begin
                        count <= 16;
                        state <= 0;
                    end
              end
            default:  state <= 0;
        endcase
    end
    assign spi_ssal = ssal;
    assign spi_mclk = mclk;
    assign spi_dat  = MOSI;
    assign bit_count = count;
endmodule

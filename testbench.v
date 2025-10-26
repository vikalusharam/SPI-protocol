`timescale 1ps/1ps
`include "SPI.v"
module SPIProtocol_tb;
    reg clk;
    reg rst;
    reg [15:0] dat_in;
    wire spi_ssal;
    wire spi_mclk;
    wire spi_dat;
    wire [4:0] bit_count;
    
    SPIProtocol uut (
        .clk(clk),
        .rst(rst),
        .dat_in(dat_in),
        .spi_ssal(spi_ssal),
        .spi_mclk(spi_mclk),
        .spi_dat(spi_dat),
        .bit_count(bit_count)
    );
    initial 
        begin
         $dumpfile("SPI.vcd");
         $dumpvars(0,SPIProtocol_tb);
        end
    initial
        begin
           clk      = 0;
           rst      = 1;
           dat_in   = 0;     
        end
    
    always #5 clk = ~clk;
    initial 
        begin
            #10     rst     = 1'b0;
            #10     dat_in  = 16'hA563;
            #355    dat_in  = 16'hFFFF;
            #355    dat_in  = 16'h89DD;       
            #355    dat_in  = 16'h246E;
            #355    rst     = 1'b1; 
            #400    $finish;
        end
    initial
        begin
            $monitor(
                $time,"clk = %b, rst = %b, dat_in = %h, spi_ssal = %b, spi_mclk = %b, spi_dat = %h, bit_count = %d",
                clk, rst, dat_in, spi_ssal, spi_mclk, spi_dat, bit_count
            );   
        end
endmodule

module SPI_Wrapper (
    input   MOSI, 
    input   wclk, 
    input   wrst_n,
    input   SS_n,
    output          MISO
);
    // Internal signals
    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;

    wire          rxvalid;
    wire          txvalid;
    wire   [9:0]  rxdata;
    wire   [7:0]  txdata;

    // Instantiate SPI Slave module
    SPI_SLAVE SPI (
        .MOSI(MOSI),
        .MISO(MISO),
        .SS_n(SS_n),
        .clk(wclk),
        .rst_n(wrst_n),
        .rx_data(rxdata),
        .rx_valid(rxvalid),
        .tx_valid(txvalid),
        .tx_data(txdata)
    );

    // Instantiate RAM module
    RAM #(MEM_DEPTH, ADDR_SIZE) Ram (
        .din(rxdata),
        .rx_valid(rxvalid),
        .dout(txdata),
        .tx_valid(txvalid),
        .clk(wclk),
        .rst_n(wrst_n)
    );
endmodule
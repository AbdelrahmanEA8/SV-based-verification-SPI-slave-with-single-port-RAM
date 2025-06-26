module SPI_Wrapper_sv (spi_if.wrapper wrapper_if);
    // Internal signals
    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;

    wire          rxvalid;
    wire          txvalid;
    wire   [9:0]  rxdata;
    wire   [7:0]  txdata;

    // Instantiate SPI Slave module
    SPI_SLAVE SPI (
        .MOSI(wrapper_if.MOSI),
        .MISO(wrapper_if.MISO),
        .SS_n(wrapper_if.SS_n),
        .clk(wrapper_if.clk),
        .rst_n(wrapper_if.rst_n),
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
        .clk(wrapper_if.clk),
        .rst_n(wrapper_if.rst_n)
    );
endmodule
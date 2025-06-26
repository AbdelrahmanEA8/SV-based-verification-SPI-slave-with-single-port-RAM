////////////////////////////////////////////////////////////////////////////////
// Module       : TOP
// Author       : Abdelrahman Essam Fahmy
// Date         : 6/15/2024
// Description  : Testbench top-level for SPI verification
// Components   :
//   - Clock generator (500MHz)
//   - DUT (SPI)
//   - Testbench driver
//   - Golden reference model
//   - Verification monitor
////////////////////////////////////////////////////////////////////////////////

module TOP();
    // Clock generation (500MHz, 2ns period)
    logic clk;
    initial begin
        clk = 0;
        forever #1 clk = ~clk;  // 1ns half-period
    end

    // Main FIFO interface with clock
    spi_if MySpi_if(clk);

    // Device Under Test - actual RTL implementation
    // SPI_Wrapper_sv DUT (MySpi_if.wrapper);
    SPI_Wrapper DUT (
        .MOSI(MySpi_if.MOSI),
        .wclk(MySpi_if.clk),
        .wrst_n(MySpi_if.rst_n),
        .SS_n(MySpi_if.SS_n),
        .MISO(MySpi_if.MISO)
    );

    // Testbench - stimulus generator and checks
    Wrapper_TB tb (MySpi_if.wrapper_tb);

    // Golden Model - reference implementation
    // Golden_Model golden_model (.MySpi_if(MySpi_if.golden_model));

    // Monitor - verification scoreboarding
    Monitor monitor (MySpi_if.wrapper_monitor);
endmodule
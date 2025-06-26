module SPI_Wrapper_TB ();
    reg wclk;
    reg wrst_n;
    reg MOSI;
    reg SS_n;
    wire MISO;

    SPI_Wrapper uut (
        .wclk(wclk),
        .wrst_n(wrst_n),
        .MOSI(MOSI),
        .MISO(MISO),
        .SS_n(SS_n)
    );

    // Clock generation
    always #4 wclk = ~wclk;

    initial begin
        // Initialization
        wrst_n = 0;
        wclk = 0;
        MOSI = 0;
        SS_n = 1;
        @(negedge wclk); wrst_n = 1;

        // Test write address
        SS_n = 0;
        @(negedge wclk); MOSI = 0;
        @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); SS_n = 1;

        // Test write data
        @(negedge wclk); SS_n = 0;
        @(negedge wclk); MOSI = 0;
        @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); SS_n = 1;

        // Test read address
        @(negedge wclk); SS_n = 0;
        @(negedge wclk); MOSI = 1;
        @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); SS_n = 1;

        // Test read data
        @(negedge wclk); SS_n = 0;
        @(negedge wclk); MOSI = 1;
        @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 0; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1; @(negedge wclk); MOSI = 1;
        repeat(10) @(negedge wclk);
        @(negedge wclk); SS_n = 1;

        repeat(2) @(negedge wclk);
        $stop;
    end
endmodule

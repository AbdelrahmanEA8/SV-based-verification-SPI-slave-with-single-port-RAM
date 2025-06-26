///////////////////////////////////////////////////////////////////////////////
// FIFO Testbench: Top-level verification module
// - Generates constrained random stimulus
// - Verifies reset behavior
// - Coordinates verification components
// - Runs 10,000 random test cycles
///////////////////////////////////////////////////////////////////////////////
module Wrapper_TB(spi_if.wrapper_tb wrapper_if);
import spi_seq_item_pkg::*;
import shared_pkg::*;
import spi_coverage_pkg::*;
// import spi_scoreboard_pkg::*;

    // Verification Components
    spi_seq_item MyTransaction = new();  // Transaction container
    spi_coverage   MyCoverage = new();  // Coverage collector
    // FIFO_scoreboard MyScoreboard = new;
    
    initial begin
        chk_rst();
        repeat(125_000)begin
            assert(MyTransaction.randomize());
                wrapper_if.rst_n = MyTransaction.rst_n;
                wrapper_if.MOSI = MyTransaction.MOSI;
                // wrapper_if.SS_n = MyTransaction.SS_n;
                if ((is_write||!is_read_data) && counter == 12) begin
                    wrapper_if.SS_n = 1;
                    counter = 0;
                    is_write = 0;
                    is_read_data = 0;
                end
                else if (is_read_data && counter == 22) begin
                    wrapper_if.SS_n = 1;
                    counter = 0;
                    is_write = 0;
                    is_read_data = 0;
                end
                else begin
                    wrapper_if.SS_n = 0;
                    counter = counter +1;
                end

                if (counter == 2 && MyTransaction.MOSI == 0) begin
                    is_write = 1;
                end
                if (!is_write && counter == 4 && MyTransaction.MOSI == 1) begin
                    is_read_data = 1;
                end
                
            @(negedge wrapper_if.clk);
        end
        test_finished = 1;
        @(negedge wrapper_if.clk);
        $stop;
     end

    task chk_rst();
        wrapper_if.rst_n = 0; wrapper_if.MOSI = 0; wrapper_if.SS_n = 0;
        repeat(5) @(negedge wrapper_if.clk);
        wrapper_if.rst_n = 1;
    endtask

endmodule
///////////////////////////////////////////////////////////////////////////////
// SPI Monitor: Observes DUT signals and coordinates verification components
// - Samples DUT inputs/outputs on clock edges
// - Drives coverage collection
// - Coordinates scoreboard checking
// - Provides test summary statistics
///////////////////////////////////////////////////////////////////////////////
module Monitor(spi_if.wrapper_monitor wrapper_if);
import spi_seq_item_pkg::*;
import shared_pkg::*;
import spi_coverage_pkg::*;
// import spi_scoreboard_pkg::*;

    // Verification Components
    spi_seq_item MyTransaction = new();  // Transaction container
    spi_coverage   MyCoverage = new();  // Coverage collector
    // spi_scoreboard  MyScoreboard = new();  // Scoreboard checker

    initial begin
        forever begin
            // Sample on negative clock edge for stable signals
            @(posedge wrapper_if.clk);
            
            // Capture all DUT signals
            MyTransaction.rst_n       = wrapper_if.rst_n;
            MyTransaction.MOSI       = wrapper_if.MOSI;
            MyTransaction.SS_n       = wrapper_if.SS_n;

            @(negedge wrapper_if.clk);
            MyTransaction.MISO    = wrapper_if.MISO;
        
            fork
                // Collect functional coverage
                begin
                    MyCoverage.sample(MyTransaction);
                end

                // Perform scoreboard checking
                // begin
                //     MyScoreboard.check_data(MyTransaction);
                // end
            join

            // Test termination condition
            if (test_finished) begin
                $display("\n**************************************************");
                $display("************** TEST SUMMARY ***********************");
                $display("**************************************************");
                $display("** Correct Transactions: %0d", correct_count);
                $display("** Error Transactions:   %0d", error_count);
                $display("**************************************************");
                $stop;
            end
        end
    end
endmodule
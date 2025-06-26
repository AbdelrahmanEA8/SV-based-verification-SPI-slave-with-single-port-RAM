///////////////////////////////////////////////////////////////////////////////
// FIFO Scoreboard: Golden reference model and result checker
// - Compares DUT outputs against expected reference values
// - Tracks correct/error counts for verification metrics
// - Provides detailed error reporting on mismatches
///////////////////////////////////////////////////////////////////////////////

package Scoreboard_Pkg;
import spi_seq_item_pkg::*;
import shared_pkg::*;

class FIFO_scoreboard;
    // Golden Model Outputs
   logic MOSI_exp;

    // FIFO memory (Stack)
    logic [FIFO_WIDTH-1:0] MyFifo [logic[DATA_WIDTH-1:0]];
    
    spi_seq_item trans = new();  // Transaction object for comparisons

    // Compares DUT outputs against golden model
    task check_data(FIFO_transaction MyTransaction);
    reference_model(MyTransaction);
        if (MyTransaction.MOSI == MOSI_exp) 
        begin
            correct_count++;
        end
        else begin
            // Error reporting for debugging
            $display("%t ERROR: DUT vs Reference Mismatch", $time);
            $display("MOSI:     DUT=%h  REF=%h", MyTransaction.MOSI, MOSI_exp);
            $display("==================================================");
            error_count++;
        end
    endtask

    // golden model reference values
    task reference_model(FIFO_transaction MyTransaction);
        if (!MyTransaction.rst_n) begin
            MyFifo.delete();
            MOSI_exp = 0;
        end
        else begin
        // Write operation
            if (MyTransaction.SS_n && !full_ref) begin
                MyFifo.push_back(MyTransaction.data_in);
                wr_ack_ref = 1;
                overflow_ref = 0;
            end
            else begin
                wr_ack_ref = 0;
                if(full_ref && MyTransaction.wr_en)
                    overflow_ref = 1;
                else
                    overflow_ref = 0;
            end
        // Read operation
            if (MyTransaction.rd_en && !empty_ref) begin
                data_out_ref = MyFifo.pop_front();
                underflow_ref = 0;
            end
            else begin
                if(empty_ref && MyTransaction.rd_en)
                    underflow_ref = 1;
                else
                    underflow_ref = 0;
            end
        end 
    
        full_ref = (MyFifo.size() == FIFO_DEPTH)? 1 : 0;  
        empty_ref = (MyFifo.size() == 0)? 1 : 0; 
        almostfull_ref = (MyFifo.size() == FIFO_DEPTH-1)? 1 : 0;
        almostempty_ref = (MyFifo.size() == 1)? 1 : 0; 

    endtask
endclass
endpackage
package spi_coverage_pkg;
 import shared_pkg::*;
 import spi_seq_item_pkg::*;

 class spi_coverage;
    spi_seq_item my_seq_item = new();
    
   covergroup spi_transaction_cg ;

        reset_cp:   coverpoint my_seq_item.rst_n {
            bins reset_active = {ACTIVE_L};
            bins reset_inactive = {INACTIVE_L};
        }

        select_slave_cp:    coverpoint my_seq_item.SS_n {
            bins select_slave_active = {ACTIVE_L};
            bins reset_inactive = {INACTIVE_L};
        }

        master_out_slave_in_cp: coverpoint my_seq_item.MOSI {
            bins MOSI_one = {ACTIVE_H};
            bins MOSI_zero = {INACTIVE_H};
            bins write_max_address = (ACTIVE_H => ACTIVE_H);
        }

        master_in_slave_out_cp: coverpoint my_seq_item.MISO {
            bins MOSI_one = {ACTIVE_H};
            bins MOSI_zero = {INACTIVE_H};
            bins write_max_address = (ACTIVE_H => ACTIVE_H);
        }

   endgroup

   function new();
       spi_transaction_cg = new;
   endfunction
 
   function void sample(spi_seq_item my_txn);
       my_seq_item = my_txn;
       spi_transaction_cg.sample();
   endfunction
 endclass
    
endpackage
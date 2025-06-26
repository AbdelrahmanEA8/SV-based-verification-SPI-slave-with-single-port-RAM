package spi_seq_item_pkg;
 import shared_pkg::*;
 
  class spi_seq_item;
   // Wrapper inputs
      bit              clk;
      rand logic       MOSI; 
      rand logic       rst_n;
      logic       SS_n;
      // logic       SS_n;
   // Wrapper outputs
      logic            MISO;

// --------------------- Constraints -------------------------- // 
      constraint rst_n_constraints {
        rst_n dist {
            ACTIVE_L   := W_rst_n_ON,
            INACTIVE_L := 100 - W_rst_n_ON
        };
      }

      // constraint SS_n_constraints {
      //   SS_n dist {
      //       // ACTIVE_L   := W_rst_n_ON,
      //       // INACTIVE_L := 100 - W_rst_n_ON
      //       ACTIVE_L   := 13,
      //       INACTIVE_L := 1
      //   };
      // }

      constraint MOSI_constraints {
        MOSI dist {
            1 := 30,
            0 := 70
        };
      }

      // constraint MOSI_constraints {
      //   MOSI dist {
      //       ACTIVE_H   := 100-ACTIVE_W,
      //       INACTIVE_H := ACTIVE_W
      //   };
      // }

  endclass

endpackage
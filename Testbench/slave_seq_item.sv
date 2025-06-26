package ram_seq_item_pkg;
import shared_pkg::*;
    class ram_seq_item;
    // Ram stimulus
        rand logic                       MOSI,
        logic                            SS_n,
        rand logic                       rst_n,
        rand logic                       tx_valid,
        rand logic   [DATA_WIDTH-1:0]    tx_data,

    // Ram responses
        logic                       MISO,
        logic                       rx_valid,
        logic  [DATA_WIDTH+1:0]     rx_data

        constraint rst_n_c1 {
            rst_n dist {
                ACTIVE_L   := W_rst_n_ON,
                INACTIVE_L := 100 - W_rst_n_ON
            };
        }

        constraint MOSI_c2 {
            MOSI dist {
                ACTIVE_H   := ACTIVE_W,
                INACTIVE_H := 100 - ACTIVE_W
            };
        }

        constraint tx_valid_c3 {
            tx_valid dist {
                ACTIVE_H   := ACTIVE_W,
                INACTIVE_H := 100 - ACTIVE_W
            };
        }

        // constraint tx_data_c4 {
        //     tx_data dist {

        //     };
        // }
    endclass
endpackage
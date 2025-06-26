package ram_seq_item_pkg;
import shared_pkg::*;
    class ram_seq_item;
    // Ram stimulus
        rand logic   [MEM_WIDTH+1:0]     din,
        rand logic                       rx_valid,
        rand logic                       rst_n,
    // Ram responses
        logic    [MEM_WIDTH-1:0]    dout,
        logic                       tx_valid

        constraint rst_n_c1 {
            rst_n dist {
                ACTIVE_L   := W_rst_n_ON,
                INACTIVE_L := 100 - W_rst_n_ON
            };
        }

        constraint rx_valid_c2 {
            rx_valid dist {
                ACTIVE_H := ACTIVE_W ,
                ACTIVE_L := 100-ACTIVE_W
            };
        }

        constraint din_c3 {
            din[9] dist {
                ACTIVE_H := ACTIVE_W ,
                ACTIVE_L := 100-ACTIVE_W
            };

            din[8] dist {
                ACTIVE_H := ACTIVE_W - 20 ,
                ACTIVE_L := ACTIVE_W - 20
            };

            // din[7:0] dist {
            //     ACTIVE_H := ACTIVE_W ,
            //     ACTIVE_L := 100-ACTIVE_W
            // };
        }
    endclass
endpackage
module SPI_SLAVE (
    input           MOSI,
    input           SS_n,
    input           clk,
    input           rst_n,
    input           tx_valid,
    input   [7:0]   tx_data,

    output reg        MISO,
    output reg        rx_valid,
    output reg [9:0]  rx_data
);
    parameter DATA_WIDTH = 8;
    parameter IDLE      = 3'b000;
    parameter CHK_CMD   = 3'b001;
    parameter WRITE     = 3'b010;
    parameter READ_ADD  = 3'b011;
    parameter READ_DATA = 3'b100;
    
    reg [$clog2(DATA_WIDTH)-1:0]  ns;
    reg [$clog2(DATA_WIDTH)-1:0]  cs;
    reg [DATA_WIDTH+1:0]         shift_reg;
    reg                          PREV_Read_ADD;
    integer                      counter_1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cs <= IDLE;
        end 
        else begin
            cs <= ns;
        end
    end

    always @(*) begin
        ns = cs;
        case (cs)
            IDLE: begin
                if (!SS_n) begin
                    ns = CHK_CMD;
                end
            end
            
            CHK_CMD: begin
                if (SS_n) begin
                    ns = IDLE;
                end else if (!MOSI) begin
                    ns = WRITE;
                end else begin
                    ns = PREV_Read_ADD ? READ_DATA : READ_ADD;
                end
            end
            
            WRITE, READ_ADD, READ_DATA: begin
                if (SS_n) begin
                    ns = IDLE;
                end
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_valid      <= 1'b0;
            rx_data       <= 10'b0;
            MISO          <= 1'b0;
            shift_reg     <= 10'b0;
            PREV_Read_ADD <= 1'b0;
            counter_1     <= 0;
        end else begin
            case (cs)
                IDLE, CHK_CMD: begin
                    if (SS_n) begin 
                        rx_valid      <= 1'b0;
                        rx_data       <= 10'b0;
                        MISO          <= 1'b0;
                        shift_reg     <= 10'b0;
                        counter_1     <= 0;
                        PREV_Read_ADD <= 1'b0;
                    end else begin
                        rx_valid      <= 1'b0;
                        rx_data       <= 10'b0;
                        MISO          <= 1'b0;
                        shift_reg     <= 10'b0;
                        counter_1     <= counter_1 + 1;
                    end
                end
                
                WRITE: begin
                    if (SS_n) begin
                        rx_valid      <= 1'b0;
                        rx_data       <= 10'b0;
                        MISO          <= 1'b0;
                        shift_reg     <= 10'b0;
                        counter_1     <= 0;
                        PREV_Read_ADD <= 1'b0;
                    end else begin
                        counter_1     <= counter_1 + 1;
                        PREV_Read_ADD <= 1'b0;
                        MISO          <= 1'b0;

                        if (counter_1 <= 12) begin
                            shift_reg <= {shift_reg[8:0], MOSI};
                            
                            if (counter_1 == 11) begin
                                rx_valid <= 1'b1;
                                rx_data  <= {shift_reg[8:0], MOSI};
                            end
                            
                            // if (counter_1 == 12) begin
                            //     rx_valid  <= 1'b0;
                            //     rx_data   <= 10'b0;
                            //     shift_reg <= 10'b0;
                            //     counter_1 <= 5'b0;
                            // end
                        end 
                        // else begin 
                            // rx_valid  <= 1'b0;
                            // rx_data   <= 10'b0;
                            // shift_reg <= 10'b0;
                            // counter_1 <= 0;
                        // end
                    end
                end
                
                READ_ADD: begin
                    if (SS_n) begin
                        rx_valid      <= 1'b0;
                        rx_data       <= 10'b0;
                        MISO          <= 1'b0;
                        shift_reg     <= 10'b0;
                        counter_1     <= 0;
                    end else begin
                        counter_1 <= counter_1 + 1;
                        MISO      <= 1'b0;

                        if (counter_1 <= 12) begin
                             shift_reg <= {shift_reg[8:0], MOSI};
                             
                             if (counter_1 == 11) begin
                                 rx_valid      <= 1'b1;
                                 rx_data       <= {shift_reg[8:0], MOSI};
                                 PREV_Read_ADD <= 1'b1;
                             end
                        end 
                        // else begin
                            // rx_valid  <= 1'b0;
                            // rx_data   <= 10'b0;
                            // shift_reg <= 10'b0;
                            // counter_1 <= 5'b0;
                        // end
                    end
                end

                READ_DATA: begin
                    if (SS_n) begin
                        rx_valid      <= 1'b0;
                        rx_data       <= 10'b0;
                        MISO          <= 1'b0;
                        shift_reg     <= 10'b0;
                        counter_1     <= 0;
                    end else begin
                        counter_1 <= counter_1 + 1;
                        
                        if (counter_1 < 12) begin
                            MISO      <= 1'b0;
                            rx_valid  <= 1'b0;
                            shift_reg <= {shift_reg[8:0], MOSI};

                            if (counter_1 == 11) begin
                                rx_valid      <= 1'b1;
                                rx_data       <= {shift_reg[8:0], MOSI};
                                PREV_Read_ADD <= 1'b0;
                            end
                        
                        end else begin
                            if (counter_1 == 13) begin
                                shift_reg <= {2'b00, tx_data};
                                MISO      <= tx_data[0];
                            end
                            
                            if (counter_1 > 13 && counter_1 < 22) begin
                                MISO      <= shift_reg[0];
                                shift_reg <= {1'b0, shift_reg[9:1]};
                            end

                            if (counter_1 == 21) begin
                                rx_valid  <= 1'b0;
                                rx_data   <= 10'b0;
                                MISO      <= 1'b0;
                                shift_reg <= 10'b0;
                                counter_1 <= 0;
                            end
                        end
                    end
                end
                
            endcase
        end
    end

endmodule

module RAM #(
    parameter MEM_DEPTH = 256,
              MEM_WIDTH = 8
)(

    input   [MEM_WIDTH+1:0]     din,
    input                       rx_valid,
    input                       clk,
    input                       rst_n,

    output reg [MEM_WIDTH-1:0]  dout,
    output reg                  tx_valid
);

    reg [MEM_WIDTH-1:0] MEM [0:MEM_DEPTH-1];
    reg [MEM_WIDTH-1:0] ADDR;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dout <= 8'b0;
            tx_valid <= 1'b0;
            ADDR <= 8'b0;
        end else begin
            if (rx_valid) begin
                case (din[9:8])
                    2'b00: begin 
                        ADDR <= din[MEM_WIDTH-1:0];
                        tx_valid <= 1'b0;
                    end
                    2'b01: begin 
                        MEM[ADDR] <= din[MEM_WIDTH-1:0];
                        tx_valid <= 1'b0;
                    end
                    2'b10: begin 
                        ADDR <= din[MEM_WIDTH-1:0];
                        tx_valid <= 1'b0;
                    end
                    2'b11: begin 
                        dout <= MEM[ADDR];
                        tx_valid <= 1'b1;
                    end
                endcase
            end else begin
                tx_valid <= 1'b0;
            end
        end
    end
endmodule

interface spi_if(input clk);
import shared_pkg::*;
// SLave inputs
  logic                        rst_n;
  logic                        MOSI;
  logic                        MISO;
  logic                        SS_n;
  logic                        tx_valid;
  logic   [DATA_WIDTH-1:0]     tx_data;     // 8 bits Input Data for SPI Slave
// Slave outputs
  logic                        rx_valid;
  logic   [DATA_WIDTH+1:0]     rx_data;     // 10 bits Input Data for SPI Slave

// Slave modports
  modport slave (
   input clk, rst_n, MOSI, SS_n, tx_valid, tx_data,
   output rx_valid, rx_data, MISO
  );

  modport slave_tb (
   input clk, rx_valid, rx_data, MISO,
   output rst_n, MOSI, SS_n, tx_valid, tx_data
  );

  modport slave_monitor (
   input clk, rst_n, MOSI, SS_n, rx_valid, rx_data, tx_valid, tx_data, MISO
  );

// Master modports
  modport wrapper (
   input clk, rst_n, MISO, SS_n,
   output MOSI
  );

  modport wrapper_tb (
    input clk, MOSI,
    output  rst_n, MISO, SS_n
  );

  modport wrapper_monitor (
   input clk, rst_n, MISO, MOSI, SS_n
  );

// RAM modports
  modport ram (
   input clk, rst_n, rx_valid, rx_data,
   output tx_valid, tx_data
  );

  modport ram_tb (
   input clk, tx_valid, tx_data,
   output rst_n, rx_valid, rx_data
  );

  modport ram_monitor (
   input clk, rst_n, rx_valid, rx_data, tx_valid, tx_data
  );
  
endinterface
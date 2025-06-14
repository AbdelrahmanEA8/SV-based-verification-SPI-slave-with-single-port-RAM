# SV-based-verification-SPI-slave-with-single-port-RAM
## 📝 Overview & DUT
### Plan Overview
This section provides a high-level summary of the verification project. The primary goal is to ensure the functional correctness and protocol compliance of the SPI Slave DUT, which uses an internal asynchronous RAM. This interactive plan outlines the strategy, environment, and specific tests required to achieve comprehensive verification.
### Key Features to Verify
1.  SPI slave protocol compliance (Mode 0).
2.  Correct handling of read/write commands.
3.  Data integrity for all RAM operations.
4.  Correct behavior of control signals.
5.  Proper handling of asynchronous reset.
### DUT Interface Signals
| Signal     | Direction | Width | Description                      |
|------------|-----------|-------|----------------------------------|
| MOSI       | Input     | 1     | Master Out Slave In              |
| tx_valid   | Input     | 1     | Valid signal for input data      |
| tx_data    | Input     | 8     | 8-bit SPI input data             |
| rst_n      | Input     | 1     | Active-low asynchronous reset    |
| MISO       | Output    | 1     | Master In Slave Out              |
| rx_valid   | Output    | 1     | Output valid signal              |
| rx_data    | Output    | 10    | 10-bit SPI output data           |
## 🏗️ Environment
### Verification Environment (VE)
This section details the UVM-based verification environment built to test the DUT. The diagram below illustrates the key components and their connections. This architecture enables a constrained-random, coverage-driven approach, ensuring robust and thorough testing. Click on a component's description to highlight it in the diagram.



## 🧪 Test Plan
## 🎯 Verification Goals

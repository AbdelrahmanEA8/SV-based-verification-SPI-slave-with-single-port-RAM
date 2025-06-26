package shared_pkg;
    parameter DATA_WIDTH = 8;
    parameter MEM_DEPTH = 256;
    parameter MEM_WIDTH = 8;
    
    parameter ACTIVE_L     = 0;
    parameter INACTIVE_L   = 1;
	parameter ACTIVE_H	   = 1;
    parameter INACTIVE_H   = 1;

	parameter W_rst_n_ON  = 2;	
	parameter ACTIVE_W		= 70;
	parameter MAX_DATA      = 8'hFF;	
	parameter MIN_DATA      = 8'h00;	

	parameter READ_ACTIVE_PENABLE_LOOP 	  = 12;	
	parameter READ_INACTIVE_PENABLE_LOOP  = 2;	
	parameter WRITE_ACTIVE_PENABLE_LOOP   = 12;	
	parameter WRITE_INACTIVE_PENABLE_LOOP = 2;	

    int test_finished = 0;
    int error_count = 0;
    int correct_count = 0;
    int counter = 0;
    int is_write = 0;
    int is_read_data = 0;

endpackage
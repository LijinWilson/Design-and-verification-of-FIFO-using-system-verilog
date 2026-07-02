// To Run Code
// iverilog -g2012 -o test_sim.out fifo.sv testbench.sv
// vvp sim.out


`timescale 1ns/1ns
module fifo_test();
    parameter FIFO_DEPTH = 8;
    parameter DATA_WIDTH = 32;
    reg clk = 0;
    reg rst_n;
    reg cs;
    reg wr_en; 
    reg rd_en; 
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire empty;
    wire full; 

// Instantiation of DUT
fifo_SISO 
    #(.FIFO_DEPTH(FIFO_DEPTH), // FIFO locations.
     .DATA_WIDTH(DATA_WIDTH)) // each location can store 32 bit of data.
    fifo1(
        .clk(clk),
        .rst_n(rst_n), // active low reset signal
        .cs(cs), // chip select
        .wr_en(wr_en), // read enable
        .rd_en(rd_en), // write enable
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty), //FIFO empty flag
        .full(full) // FIFO full flag
    );

// Clock generation
always begin #5 clk = ~clk; end

// write operation into FIFO
task write_data(input [DATA_WIDTH-1:0] d_in);
    @(posedge clk);
    cs = 1; wr_en = 1;
    data_in = d_in;
    $display($time, "Read operation >> data input = %0d", data_in);
    @(posedge clk);
    cs = 1; wr_en = 0;
endtask

// Read Operation into FIFO
task read_data();
    @(posedge clk);
    cs = 1; rd_en = 1;
    @(posedge clk);
    #1;
  $display($time, "  Write Operation >> Data Out = %0d", data_out);
    cs = 1; rd_en = 0;
endtask

// Creating stimulus
initial begin
    #1; // resetting the system
    rst_n = 0; rd_en = 0; wr_en = 0;
  $display($time,"\n Scenario - 1");
    @(posedge clk);
    rst_n = 1; // disabling the reset
    // Writing the data
    write_data(1); 
    write_data(10); 
    write_data(100); 

    // Reading the Data
    read_data();
    read_data();
    read_data();

  $display($time, "\n Scenario - 2");
    for (integer i = 0; i<FIFO_DEPTH ; i=i+1 ) begin
      	write_data(2**i);
        read_data();
    end

  $display($time, " \n Scenario - 3");
    for (integer i = 0; i<FIFO_DEPTH; i=i+1) begin
        write_data(2**i);
    end

    for (integer i = 0; i<FIFO_DEPTH; i=i+1) begin
        read_data();
    end
  #40; $finish();
  

end
    initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end

endmodule

module fifo_SISO 
    #(parameter FIFO_DEPTH = 8, // FIFO locations.
    parameter DATA_WIDTH = 32) // each location can store 32 bit of data.
    (
        input clk,
        input rst_n, // active low reset signal
        input cs, // chip select
        input wr_en, // read enable
        input rd_en, // write enable
        input [DATA_WIDTH-1:0] data_in,
        output [DATA_WIDTH-1:0] data_out,
        output empty, //FIFO empty flag
        output full // FIFO full flag
    );

// used to find the count how many bit to represent the 8 locations
    localparam FIFO_DEPTH_LOG = $clog2(FIFO_DEPTH); // FIFO_DEPTH = 3(number of bit to represent the 8 location(000 to 111));

// Register to store the incoming data's
    reg [DATA_WIDTH-1:0] fifo [0:FIFO_DEPTH-1]; // contain 8 location having each of size 32 bits.

// WRITE and READ pointer both are of 4 bit
    reg [FIFO_DEPTH_LOG:0] write_pointer;
    reg [FIFO_DEPTH_LOG:0] read_pointer;

// WRITE operation and increment
    always @(posedge clk or negedge rst_n) begin
        if (!rst) begin // Asynchronous reset are used here.
            write_pointer <= 0; 
        end
        else if(cs && wr_en && !full) begin
            fifo[write_pointer[FIFO_DEPTH_LOG-1:0]] <= data_in; // only lowest 3 bit are used in filling the data fifo[0].
            write_pointer <= write_pointer + 1'b1;
        end 
    end

// READ Operation and increment
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            read_pointer <= 0;
        end
        else if(cs && rd_en && !empty)begin
            data_out <= fifo[read_pointer[FIFO_DEPTH_LOG-1:0]];
            read_pointer <= read_pointer + 1'b1;
        end
    end

// Declaration of empty and full logic
    assign empty = (read_pointer == write_pointer);
    assign full = (read_pointer == {~write_pointer[FIFO_DEPTH_LOG], write_pointer[FIFO_DEPTH_LOG-1:0]});

endmodule

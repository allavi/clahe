/*
    ------------------------------------------------------------------------------
    -- The MIT License (MIT)
    --
    -- Copyright (c) <2020> Allavi Ali
    --
    -- Permission is hereby granted, free of charge, to any person obtaining a copy
    -- of this software and associated documentation files (the "Software"), to deal
    -- in the Software without restriction, including without limitation the rights
    -- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    -- copies of the Software, and to permit persons to whom the Software is
    -- furnished to do so, subject to the following conditions:
    --
    -- The above copyright notice and this permission notice shall be included in
    -- all copies or substantial portions of the Software.
    --
    -- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    -- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    -- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    -- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    -- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    -- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    -- THE SOFTWARE.
    -------------------------------------------------------------------------------
    Project     : CLAHE / (Altera Cyclone V)
    Author      : Allavi Ali
    Description : Converts 16b RGB frames to 8b YCbCr frames. 
                  
*/

module rgb2ycbcr (
    input         clk    , // Clock 50Hz
    input         rst_n  , // Asynchronous reset active low
    input  [15:0] i_data ,
    input         i_valid,
    output        o_ready,
    output [23:0] o_data ,
    output        o_valid,
    input         i_ready
);


wire [4:0] r;
wire [5:0] g;
wire [4:0] b;

wire [13:0] y;
wire [13:0] cb;
wire [13:0] cr;


mult i_mult_y (
    .clk    (clk    ),
    .clk_en (i_valid),
    .rst_n  (rst_n  ),
    .i_dataa(i_dataa),
    .i_datab(i_datab),
    .o_data (o_data ),
    .o_valid(o_valid)
);

mult i_mult_cb (
    .clk    (clk    ),
    .clk_en (i_valid),
    .rst_n  (rst_n  ),
    .i_dataa(i_dataa),
    .i_datab(i_datab),
    .o_data (o_data ),
    .o_valid(o_valid)
);

mult i_mult_cr (
    .clk    (clk    ),
    .clk_en (i_valid),
    .rst_n  (rst_n  ),
    .i_dataa(i_dataa),
    .i_datab(i_datab),
    .o_data (o_data ),
    .o_valid(o_valid)
);

endmodule
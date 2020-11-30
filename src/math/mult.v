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
    Description : Multiplier (IP core)
                  
*/

module mult #(PIPE = 4) (
    input              clk    , // Clock
    input              clk_en , // Clock Enable
    input              rst_n  , // Asynchronous reset active low
    //
    input  [2:0][ 5:0] i_dataa,
    //
    input  [2:0][ 7:0] i_datab,
    //
    output [2:0][13:0] o_data ,
    output             o_valid
);

reg [PIPE-1:0] valid;

always @(posedge clk or negedge rst_n)
    if(~rst_n)
        valid <= 0;
    else if(clk_en)
        valid <= {valid, in_valid};

assign o_valid = valid[PIPE-1];


generate for (genvar i = 0; i < 3; i++) begin

    lpm_mult i_lpm_mult (
        .aclr  (~rst_n    ),
        .clken (clk_en    ),
        .clock (clk       ),
        .dataa (i_dataa[i]),
        .datab (i_datab[i]),
        .result(o_data[i] ),
        .sclr  (1'b0      ),
        .sum   (1'b0      )
    );

    defparam
        lpm_mult_component.lpm_hint = "MAXIMIZE_SPEED=5",
        lpm_mult_component.lpm_pipeline = PIPE,
        lpm_mult_component.lpm_representation = "UNSIGNED",
        lpm_mult_component.lpm_type = "LPM_MULT",
        lpm_mult_component.lpm_widtha = 6,
        lpm_mult_component.lpm_widthb = 8,
        lpm_mult_component.lpm_widthp = 14;

end endgenerate


endmodule
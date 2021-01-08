module mdr_unit(
    input  logic       Clk, Reset,
    input  logic       LD_MDR,
    input  logic       MIO_EN,
    input  logic [15:0]BUS_DATA,         //Define in datapath
							  MDR_In,
    output logic [15:0]MDR
);

logic [15:0]CUR_DATA_FEED;

register BUS_OUT_OUT(.Clk, .Reset, .WE(LD_MDR), .data_IN(CUR_DATA_FEED), .data_OUT(MDR));
  //input LD_MDR, CUR_DATA_FEED;
  //output MDR;

always_comb
  begin
    CUR_DATA_FEED = (MIO_EN) ? MDR_In : BUS_DATA;
  end
endmodule

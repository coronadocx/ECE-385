//-------------------------------------------------------------------------
//      lab6_toplevel.sv                                                 --
//                                                                       --
//      Created 10-19-2017 by Po-Han Huang                               --
//                        Spring 2018 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------
 
module lab6_toplevel( input logic [15:0] S,
                      input logic Clk, Reset, Run, Continue,
                      output logic [11:0] LED,
                      output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
                      output logic CE, UB, LB, OE, WE,
                      output logic [19:0] ADDR,
                      inout wire [15:0] Data);
							 
//sync button_sync[3:0] (Clk, {~Reset, ~LoadA, ~LoadB, ~Execute}, {Reset_SH, LoadA_SH, LoadB_SH, Execute_SH});
//sync Din_sync[3:0] (Clk, Din, Din_S);
//sync F_sync[2:0] (Clk, F, F_S);
//sync R_sync[1:0] (Clk, R, R_S);

logic Reset_S, Run_S, Continue_S;

//Synchronization of Input
sync button_sync[2:0] (Clk, {Reset, Run, Continue}, {Reset_S, Run_S, Continue_S});

slc3 my_slc(.*, .Reset(Reset_S), .Run(Run_S), .Continue(Continue_S));
// Even though test memory is instantiated here, it will be synthesized into 
// a blank module, and will not interfere with the actual SRAM.
// Test memory is to play the role of physical SRAM in simulation.
test_memory my_test_memory(.Reset(~Reset), .I_O(Data), .A(ADDR), .*);

endmodule
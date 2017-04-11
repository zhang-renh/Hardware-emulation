// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Baud
// 
// Author: Step
// 
// Description: Beat for uart transfer and receive baud rate
// 
// Web: www.stepfapga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Baud #
(
parameter				BPS_PARA = 1250 // bps_clk period for 9600 baud rate when clk_in was 12MHz
)
(
input					clk_in,		// 12MHz system clock
input					rst_n_in,	// system reset, active low
input					bps_en,		// start beat request
output	reg				bps_clk		// data receive or transfer beat for 9600 bps
);	

reg				[12:0]	cnt;
// count for baud rate
always @ (posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) 
		cnt <= 1'b0;
	else if((cnt >= BPS_PARA-1)||(!bps_en)) 
		cnt <= 1'b0;	
	else 
		cnt <= cnt + 1'b1;
end
	
// generate bps_clk signal
always @ (posedge clk_in or negedge rst_n_in)
	begin
		if(!rst_n_in) 
			bps_clk <= 1'b0;
		else if(cnt == (BPS_PARA>>1)) 
			bps_clk <= 1'b1;	
		else 
			bps_clk <= 1'b0;
	end

endmodule
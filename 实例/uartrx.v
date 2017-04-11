// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Uart_Rx
// 
// Author: Step
// 
// Description: The receive module of uart interface
// 
// Web: www.stepfapga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Uart_Rx
(
input					clk_in,			// 12MHz system clock
input					rst_n_in,		// system reset, active low

output	reg				bps_en,			// beat clock enable
input					bps_clk,		// beat clock input

input					rs232_rx,		// uart receive pin
output	reg				rx_data_valid,	// rx_data_out valid when rx_data_valid active
output	reg		[7:0]	rx_data_out		// data of uart receive
);	

reg	rs232_rx0,rs232_rx1,rs232_rx2;	
//Detect negedge of rs232_rx
always @ (posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		rs232_rx0 <= 1'b0;
		rs232_rx1 <= 1'b0;
		rs232_rx2 <= 1'b0;
	end else begin
		rs232_rx0 <= rs232_rx;
		rs232_rx1 <= rs232_rx0;
		rs232_rx2 <= rs232_rx1;
	end
end

wire	neg_rs232_rx = rs232_rx2 & rs232_rx1 & (~rs232_rx0) & (~rs232_rx);	
		
reg				[3:0]	num;			
//start 8bit_data receive operation
always @ (posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in)
		bps_en <= 1'b0;
	else if(neg_rs232_rx && (!bps_en))		
		bps_en <= 1'b1;		
	else if(num==4'd9)		             
		bps_en <= 1'b0;			
end

reg				[7:0]	rx_data;
//receive data with bps_clk when bps_en is actived
always @ (posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		num <= 4'd0;
		rx_data <= 8'd0;
	end else if(bps_en) begin	
		if(bps_clk) begin			
			num <= num+1'b1;
			if(num<=4'd8) rx_data[num-1]<=rs232_rx;
		end else if(num == 4'd9) begin		
			num <= 4'd0;				
		end
	end else begin
		num <= 4'd0;
	end
end

always @ (posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		rx_data_out <= 8'd0;
		rx_data_valid <= 1'b0;
	end else if(num == 4'd9) begin	
		rx_data_out <= rx_data;
		rx_data_valid <= 1'b1;
	end else begin
		rx_data_out <= rx_data_out;
		rx_data_valid <= 1'b0;
	end
end

endmodule

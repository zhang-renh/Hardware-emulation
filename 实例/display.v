
// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Display_Ctl
// 
// Author: Step
// 
// Description: Real time display with segment led_out
// 
// Web: www.stepfapga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Display_Ctl 
(
input					clk_in,				//clk_in = 12mhz
input					rst_n_in,			//rst_n_in, active low

input					rs232_rx,			// uart receive pin
//output					rs232_tx,			// uart transfer pin

output					rclk_out,			//74HC595 RCK
output					sclk_out,			//74HC595 SCK
output					sdio_out			//74HC595 SER
);	

wire					rx_data_valid;
wire			[7:0]	rx_data_out;
//Uart_Bus module
Uart_Bus Uart_Bus_uut
(	
.clk_in					(clk_in			),	// 12MHz system clock
.rst_n_in				(rst_n_in		),	// system reset, active low

.rs232_rx				(rs232_rx		),	// uart receive pin
.rx_data_valid			(rx_data_valid	),	// rx_data_out valid when rx_data_valid active
.rx_data_out			(rx_data_out	)	// data of uart receive

//.tx_data_valid			(key_state_pos	),	// tx_data_in valid when tx_data_valid active
//.tx_data_in				(key_ascii		),	// data need to transfer
//.rs232_tx				(rs232_tx		)	// uart transfer pin
);

reg				[3:0]	seg_data_r;
//Detect negedge of key_clk
always @ (rx_data_out) begin
	case(rx_data_out)
		"0": seg_data_r = 4'd0;
		"1": seg_data_r = 4'd1;
		"2": seg_data_r = 4'd2;
		"3": seg_data_r = 4'd3;
		"4": seg_data_r = 4'd4;
		"5": seg_data_r = 4'd5;
		"6": seg_data_r = 4'd6;
		"7": seg_data_r = 4'd7;
		"8": seg_data_r = 4'd8;
		"9": seg_data_r = 4'd9;
		default: seg_data_r = seg_data_r;
	endcase
end

reg				[23:0]	seg_data;
//Detect negedge of key_clk
always @ (posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		seg_data <= 1'b0;
	end else if(rx_data_valid) begin
		seg_data <= {seg_data[19:0],seg_data_r};
	end
end

//segment_scan display module
Segment_scan Segment_scan_uut
(
.clk_in					(clk_in				),		//12mhz
.rst_n_in				(rst_n_in			),		//active with low 
.seg_data_1				(seg_data[23:20]	),		//data need to display
.seg_data_2				(seg_data[19:16]	),		//data need to display
.seg_data_3				(seg_data[15:12]	),		//data need to display
.seg_data_4				(seg_data[11:8]		),		//data need to display
.seg_data_5				(seg_data[7:4]		),		//data need to display
.seg_data_6				(seg_data[3:0]		),		//data need to display
.seg_data_en			(6'b111_111			),		//display enable for every data
.seg_dot_en				(6'b000_000			),		//display enable for every dot
.rclk_out				(rclk_out			),		//74HC595 RCK
.sclk_out				(sclk_out			),		//74HC595 SCK
.sdio_out				(sdio_out			)		//74HC595 SER
);

endmodule

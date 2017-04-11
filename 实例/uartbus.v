// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Uart_Bus
// 
// Author: Step
// 
// Description: The module for uart communication
// 
// Web: www.stepfapga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Uart_Bus #
(
parameter				BPS_PARA = 1250 	// 1250 for 9600 baud rate when 12MHz clk_in
)
(
input					clk_in,				// 12MHz system clock
input					rst_n_in,			// system reset, active low

input					rs232_rx,			// uart receive pin
output					rx_data_valid,		// rx_data_out valid when rx_data_valid active
output			[7:0]	rx_data_out			// data of uart receive

//input					tx_data_valid,		// tx_data_in valid when tx_data_valid active
//input			[7:0]	tx_data_in,			// data need to transfer
//output					rs232_tx			// uart transfer pin
);	
	
/////////////////////////////////uart_rx module////////////////////////////////////

wire					bps_en_rx,bps_clk_rx;

Baud #
(
.BPS_PARA				(BPS_PARA		)
)
Baud_rx
(	
.clk_in					(clk_in			),	// 12MHz system clock
.rst_n_in				(rst_n_in		),	// system reset, active low
.bps_en					(bps_en_rx		),	// start beat request
.bps_clk				(bps_clk_rx		)	// data receive beat for 9600 bps
);

Uart_Rx Uart_Rx_uut
(
.clk_in					(clk_in			),	// 12MHz system clock
.rst_n_in				(rst_n_in		),	// system reset, active low

.bps_en					(bps_en_rx		),	// beat clock enable
.bps_clk				(bps_clk_rx		),	// beat clock input

.rs232_rx				(rs232_rx		),	// uart receive pin
.rx_data_valid			(rx_data_valid	),	// rx_data_out valid when rx_data_valid active
.rx_data_out			(rx_data_out	)	// data of uart receive
);
	
	
/////////////////////////////////uart_tx module////////////////////////////////////
/*
wire					bps_en_tx,bps_clk_tx;

Baud #
(
.BPS_PARA				(BPS_PARA		)
)
Baud_tx
(
.clk_in					(clk_in			),	// 12MHz system clock
.rst_n_in				(rst_n_in		),	// system reset, active low
.bps_en					(bps_en_tx		),	// start beat request
.bps_clk				(bps_clk_tx		)	// data receive beat for 9600 bps
);

Uart_Tx Uart_Tx_uut
(
.clk_in					(clk_in			),	// 12MHz system clock
.rst_n_in				(rst_n_in		),	// system reset, active low

.bps_en					(bps_en_tx		),	// beat clock enable
.bps_clk				(bps_clk_tx		),	// beat clock input

.tx_data_valid			(tx_data_valid	),	// tx_data_in valid when tx_data_valid active
.tx_data_in				(tx_data_in		),	// data need to transfer
.rs232_tx				(rs232_tx		)	// uart transfer pin
);
*/
endmodule

// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module:Segment_scan 
// 
// Author: Step
// 
// Description: Display with Segment tube
// 
// Web: www.stepfpga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2015/11/11   |Initial ver
// --------------------------------------------------------------------
module Segment_scan
(
input				clk_in,			//12mhz
input				rst_n_in,		//active with low 
input		[3:0]	seg_data_1,		//data need to display
input		[3:0]	seg_data_2,		//data need to display
input		[3:0]	seg_data_3,		//data need to display
input		[3:0]	seg_data_4,		//data need to display
input		[3:0]	seg_data_5,		//data need to display
input		[3:0]	seg_data_6,		//data need to display
input		[5:0]	seg_data_en,	//display enable for every data
input		[5:0]	seg_dot_en,		//display enable for every dot
output	reg			rclk_out,		//74HC595 RCK
output	reg			sclk_out,		//74HC595 SCK
output	reg			sdio_out		//74HC595 SER
);

parameter CLK_DIV_PERIOD = 600; //related with clk_div's frequency

localparam	IDLE	=	3'd0;
localparam	MAIN	=	3'd1;
localparam	WRITE	=	3'd2;

localparam	LOW		=	1'b0;
localparam	HIGH	=	1'b1;

//initial for memory register
reg[7:0] seg [9:0]; 
initial begin
    seg[0]= 8'h3f;   //  0
    seg[1]= 8'h06;   //  1
    seg[2]= 8'h5b;   //  2
    seg[3]= 8'h4f;   //  3
    seg[4]= 8'h66;   //  4
    seg[5]= 8'h6d;   //  5
    seg[6]= 8'h7d;   //  6
    seg[7]= 8'h07;   //  7
    seg[8]= 8'h7f;   //  8
    seg[9]= 8'h6f;   //  9
end 
	
//for cnt, count to CLK_DIV_PERIOD
reg[9:0] cnt=0;
always@(posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		cnt <= 1'b0;
	end else begin
		if(cnt>=(CLK_DIV_PERIOD-1)) cnt <= 1'b0;
		else cnt <= cnt + 1'b1;
	end
end

//for clk_div, 20KHz
reg clk_div; 
always@(posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		clk_div <= 1'b0;
	end else begin
		if(cnt==(CLK_DIV_PERIOD-1)) clk_div <= 1'b1;
		else clk_div <= 1'b0;
	end
end

//Finite State Machine, 
reg		[15:0]		data_reg;
reg		[2:0]		cnt_main;
reg		[5:0]		cnt_write;
reg		[2:0] 		state = IDLE;
always@(posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		state <= IDLE;
		cnt_main <= 3'd0;
		cnt_write <= 6'd0;
		sdio_out <= 1'b0;
		sclk_out <= LOW;
		rclk_out <= LOW;
	end else begin
		case(state)
			IDLE:begin
					state <= MAIN;
					cnt_main <= 3'd0;
					cnt_write <= 6'd0;
					sdio_out <= 1'b0;
					sclk_out <= LOW;
					rclk_out <= LOW;
				end
			MAIN:begin
					if(cnt_main >= 3'd5) cnt_main <= 1'b0;
					else cnt_main <= cnt_main + 1'b1;
					case(cnt_main)
						//Array scaning
						3'd0:	begin 
									state <= WRITE;
									data_reg <= {seg[seg_data_1]|(seg_dot_en[0]?8'h80:8'h00),seg_data_en[0]?8'hfe:8'hff}; 
								end
						3'd1:	begin 
									state <= WRITE;
									data_reg <= {seg[seg_data_2]|(seg_dot_en[1]?8'h80:8'h00),seg_data_en[1]?8'hfd:8'hff}; 
								end
						3'd2:	begin 
									state <= WRITE;
									data_reg <= {seg[seg_data_3]|(seg_dot_en[2]?8'h80:8'h00),seg_data_en[2]?8'hfb:8'hff}; 
								end
						3'd3:	begin 
									state <= WRITE;
									data_reg <= {seg[seg_data_4]|(seg_dot_en[3]?8'h80:8'h00),seg_data_en[3]?8'hf7:8'hff}; 
								end
						3'd4:	begin 
									state <= WRITE;
									data_reg <= {seg[seg_data_5]|(seg_dot_en[4]?8'h80:8'h00),seg_data_en[4]?8'hef:8'hff};
								end
						3'd5:	begin 
									state <= WRITE;
									data_reg <= {seg[seg_data_6]|(seg_dot_en[5]?8'h80:8'h00),seg_data_en[5]?8'hdf:8'hff}; 
								end
						default: state <= IDLE;
					endcase
				end
			WRITE:begin
					if(clk_div) begin
						if(cnt_write >= 6'd33) cnt_write <= 1'b0;
						else cnt_write <= cnt_write + 1'b1;
						case(cnt_write)
							//74HC595 timing
							6'd0:  begin sclk_out <= LOW; sdio_out <= data_reg[15]; end
							6'd1:  begin sclk_out <= HIGH; end
							6'd2:  begin sclk_out <= LOW; sdio_out <= data_reg[14]; end
							6'd3:  begin sclk_out <= HIGH; end
							6'd4:  begin sclk_out <= LOW; sdio_out <= data_reg[13]; end
							6'd5:  begin sclk_out <= HIGH; end
							6'd6:  begin sclk_out <= LOW; sdio_out <= data_reg[12]; end
							6'd7:  begin sclk_out <= HIGH; end
							6'd8:  begin sclk_out <= LOW; sdio_out <= data_reg[11]; end
							6'd9:  begin sclk_out <= HIGH; end
							6'd10: begin sclk_out <= LOW; sdio_out <= data_reg[10]; end
							6'd11: begin sclk_out <= HIGH; end
							6'd12: begin sclk_out <= LOW; sdio_out <= data_reg[9]; end
							6'd13: begin sclk_out <= HIGH; end
							6'd14: begin sclk_out <= LOW; sdio_out <= data_reg[8]; end
							6'd15: begin sclk_out <= HIGH; end
							6'd16: begin sclk_out <= LOW; sdio_out <= data_reg[7]; end
							6'd17: begin sclk_out <= HIGH; end
							6'd18: begin sclk_out <= LOW; sdio_out <= data_reg[6]; end
							6'd19: begin sclk_out <= HIGH; end
							6'd20: begin sclk_out <= LOW; sdio_out <= data_reg[5]; end
							6'd21: begin sclk_out <= HIGH; end
							6'd22: begin sclk_out <= LOW; sdio_out <= data_reg[4]; end
							6'd23: begin sclk_out <= HIGH; end
							6'd24: begin sclk_out <= LOW; sdio_out <= data_reg[3]; end
							6'd25: begin sclk_out <= HIGH; end
							6'd26: begin sclk_out <= LOW; sdio_out <= data_reg[2]; end
							6'd27: begin sclk_out <= HIGH; end
							6'd28: begin sclk_out <= LOW; sdio_out <= data_reg[1]; end
							6'd29: begin sclk_out <= HIGH; end
							6'd30: begin sclk_out <= LOW; sdio_out <= data_reg[0]; end
							6'd31: begin sclk_out <= HIGH; end
							6'd32: begin rclk_out <= HIGH; end
							6'd33: begin rclk_out <= LOW; state <= MAIN; end
							default: state <= IDLE;
						endcase
					end else begin
						sclk_out <= sclk_out;
						sdio_out <= sdio_out;
						rclk_out <= rclk_out;
						cnt_write <= cnt_write;
						state <= state;
					end
				end
			default: state <= IDLE;
		endcase
	end
end

endmodule

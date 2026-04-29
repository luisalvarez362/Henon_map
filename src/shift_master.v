`timescale 1ns / 1ps

module shift_master #(parameter bits=1)(
	input clk,
	input rst,
	input D, 
	output eom, // data received
	output rst_slave,
	output [bits-1:0] Q
    );

reg [bits-1:0] Qn,Qn_reg, count;
reg rst_slaven;
reg [1:0]state;	
reg eomn;


assign Q=Qn;
assign rst_slave=rst_slaven;   
assign eom = eomn;

always@(posedge clk)
begin
	if (rst==1) begin
		rst_slaven=1;
		Qn=0;
		Qn_reg=0;
		state=0;
		count=0;  
		eomn=0;
	end
	else begin
		case (state)
			0:begin	
				rst_slaven=0;
				state=1;
				eomn=0;
			end
			1:begin
				count=0;
				Qn_reg[count]=D;
				state=2;
				eomn=0;
			end			
			2:begin
				if (count==bits-1) begin 
					Qn_reg[count]=D;
					Qn=Qn_reg;
					Qn_reg=0;
					state=1;
//					state=3; //test
//					rst_slaven=1; //test 
					eomn=1;
				end
				
			else begin 
				   
				Qn_reg[count]=D;
				count=count+1;
				   
				end
			end
	      3:begin
	           state=0;
	      end	
	endcase		
	end
	
end
    
endmodule
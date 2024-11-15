module ins_mem ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address
);
	logic [7:0] instruction_tb [39:0];
	
	always_comb begin
        instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule

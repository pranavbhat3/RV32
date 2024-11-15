
module IF #(parameter INS = 5) (
	output logic [31:0] instruction, new_addr,
	input logic [7:0] instruction_tb [INS*8:0],
	input bit PCsrc,
	input logic [31:0] branch_addr,
	input logic clk
);
	logic [31:0] old_addr;
	
	pc program_count(new_addr, old_addr, branch_addr, PCsrc, clk);
	ins_mem_test #(INS) code_mem(instruction,instruction_tb, old_addr);

	assign old_addr = new_addr;
    
endmodule

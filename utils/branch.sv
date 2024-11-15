module Branch(
	output logic confirm,
	output logic [31:0] PcOut,
	input logic [2:0] func3,
	input logic [6:0] opcode,
	input logic [31:0] AluOut, PcIn, immediate,
	input logic zero
	);
	always_comb begin
		if (opcode == 7'b110_0011) begin // B type
			case(func3)
				3'b000 : confirm = zero; // beq
				3'b001 : confirm = !zero; // bne
				3'b100 : confirm = $signed(AluOut) < 0; // blt
				3'b101 : confirm = $signed(AluOut) >= 0; // bge
				3'b110 : confirm = (AluOut) < 0; // bltu
				3'b111 : confirm = (AluOut) >= 0; // bgeu
			endcase
		end
		if (opcode == 7'b110_1111) confirm = 1; // J type
	end
	assign PcOut = PcIn + immediate;
endmodule

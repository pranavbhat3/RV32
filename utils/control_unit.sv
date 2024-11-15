module CU (
    output logic RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, OpSel,
    output logic [3:0] ALUop,
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic [6:0] opcode
);
logic [10:0] outs;

assign {RegWrite, MemRead, MemWrite,
       branch, ALUsrc, MemToReg, OpSel,
       ALUop} = outs;

always_comb begin
	// Check for which opcode
	case (opcode)
		7'b110_0111 : outs = 8'b0; // I jump
		7'b000_0011 : begin  // I load
		case(func3) 
			3'b000 : outs = 11'b110_0110_0000; // lb 
			3'b001 : outs = 11'b110_0110_0000; // lh 
			3'b010 : outs = 11'b110_0110_0000; // lw 
			3'b100 : outs = 11'b110_0110_0000; // lbu
			3'b101 : outs = 11'b110_0110_0000; // lhu
		endcase
		end
		7'b001_0011 : begin  // I arithmetic
		case(func3)
			3'b000 : outs = 11'b100_0100_0000; // addi 
			3'b010 : outs = 11'b100_0100_0001; // slti 
			3'b011 : outs = 11'b100_0100_0001; // sltiu
			3'b100 : outs = 11'b100_0100_0100; // xori 
			3'b110 : outs = 11'b100_0100_0011; // ori  
			3'b111 : outs = 11'b100_0100_0010; // andi 
			3'b001 : begin // shift immediate
// #TODO
			case(func7)  
				7'b000_0000 : outs = 11'b100_0010_0101; // s_li
				7'b010_0000 : outs = 11'b100_0010_0111; // srai
			endcase
			end
		endcase
		end

		7'b011_0111 : outs = 11'b100_0100_0000; // lui
		7'b001_0111 : outs = 11'b100_0101_0000; // auipc
		7'b110_1111 : outs = 11'b100_1100_0000; // jal
		7'b110_0011 : begin // branch
		case(func3) 
			3'b000 : outs = 11'b000_1000_0001; // beq 
			3'b001 : outs = 11'b000_1000_0001; // bne 
			3'b100 : outs = 11'b000_1000_0001; // blt 
			3'b101 : outs = 11'b000_1000_0001; // bge 
			3'b110 : outs = 11'b000_1000_0001; // bltu
			3'b111 : outs = 11'b000_1000_0001; // bgeu
		endcase
		end

		7'b010_0011 : begin // store
		case(func3)
			3'b000 : outs = 11'b011_0100_0000; // sb
			3'b001 : outs = 11'b011_0100_0000; // sh
			3'b010 : outs = 11'b011_0100_0000; // sw
		endcase
		end

		7'b011_0011 : begin // R type
		case(func3)
			3'b000  : begin // add or sub
			case(func7)
				7'b000_0000 : outs = 11'b100_0000_0000; // add
				7'b010_0000 : outs = 11'b100_0000_0001; // sub
			endcase
			end

			3'b001 : outs = 11'b1_0001; // sll 
			3'b010 : outs = 11'b1_0001; // slt 
			3'b011 : outs = 11'b1_0001; // sltu
			3'b100 : outs = 11'b1_0001; // xor
			3'b101 : begin // shift right
			case(func7)
				7'b000_0000 : outs = 11'b100_0100_0110; // srl
				7'b010_0000 : outs = 11'b100_0100_0111; // sra
			endcase
			end

			3'b110  : outs = 11'b100_0100_0011; // or
			3'b111  : outs = 11'b100_0100_0010; // and
		endcase
		end
		default: outs = 8'b0000_0000;
	endcase
end
    
endmodule

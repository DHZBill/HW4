//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "register.v"
`include "mux.v"
`include "decoders.v"
module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

	wire[31:0] decoderOut;
	wire[31:0][31:0] registerOut;

	decoder1to32 decoder(decoderOut, RegWrite, WriteRegister);

	register32zero register0(registerOut[0], WriteData, decoderOut[0],Clk);
	generate
		genvar i;
		for (i = 1; i<32; i = i + 1) begin: read
			register32 register(registerOut[i], WriteData, decoderOut[i], Clk);
		end
		
	endgenerate
	mux32to1by32 mux0(ReadData1, ReadRegister1, registerOut[0],
												registerOut[1],
												registerOut[2],
												registerOut[3],
												registerOut[4],
												registerOut[5],
												registerOut[6],
												registerOut[7],
												registerOut[8],
												registerOut[9],
												registerOut[10],
												registerOut[11],
												registerOut[12],
												registerOut[13],
												registerOut[14],
												registerOut[15],
												registerOut[16],
												registerOut[17],
												registerOut[18],
												registerOut[19],
												registerOut[20],
												registerOut[21],
												registerOut[22],
												registerOut[23],
												registerOut[24],
												registerOut[25],
												registerOut[26],
												registerOut[27],
												registerOut[28],
												registerOut[29],
												registerOut[30],
												registerOut[31]);
	mux32to1by32 mux1(ReadData2, ReadRegister2, registerOut[0],
												registerOut[1],
												registerOut[2],
												registerOut[3],
												registerOut[4],
												registerOut[5],
												registerOut[6],
												registerOut[7],
												registerOut[8],
												registerOut[9],
												registerOut[10],
												registerOut[11],
												registerOut[12],
												registerOut[13],
												registerOut[14],
												registerOut[15],
												registerOut[16],
												registerOut[17],
												registerOut[18],
												registerOut[19],
												registerOut[20],
												registerOut[21],
												registerOut[22],
												registerOut[23],
												registerOut[24],
												registerOut[25],
												registerOut[26],
												registerOut[27],
												registerOut[28],
												registerOut[29],
												registerOut[30],
												registerOut[31]);

endmodule
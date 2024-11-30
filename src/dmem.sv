module dmem #(
	parameter DEPTH = 2048,
	parameter MEM_FILE = "dmem.hex") (
	input                      clk,
	input  [$clog2(DEPTH)-1:0] addr,
	input  [31:0]              wdata,
	input                      wren,
	output [31:0]              rdata
);

	logic [3:0][7:0] mem[DEPTH/4];
	logic [$clog2(DEPTH)-3:0] maddr;
	assign maddr = addr[$clog2(DEPTH)-1:2];

	initial begin
		$readmemh(MEM_FILE, mem);
	end

	always @(posedge clk) begin
		if(wren) begin
			mem[maddr][0] <= wdata[7:0];
			mem[maddr][1] <= wdata[15:8];
			mem[maddr][2] <= wdata[23:16];
			mem[maddr][3] <= wdata[31:24];
    end
	end

	always_comb begin
		rdata = mem[maddr];
	end

endmodule

module adder #(
    parameter N = 4
) (
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    output logic [N-1:0] s,
    output bit ovf
);

  logic [N:0] c;
  assign c[0] = 0;
  genvar i;
  for (i = 0; i < N; i = i + 1) begin
    rca u1 (
        a[i],
        b[i],
        c[i],
        s[i],
        c[i+1]
    );
  end
  assign ovf = c[N];

endmodule

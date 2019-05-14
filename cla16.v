module main;
reg [15:0] a,b ,c ,d;
reg cin;
wire [15:0] sum0;
wire [15:0] sum1;
wire [15:0] sum2;
wire cout;
 
  carry_look_ahead_16bit addition1(.a(a), .b(b),.sum(sum0));
  carry_look_ahead_16bit addition2(.a(c), .b(sum0),.sum(sum1));
  carry_look_ahead_16bit addition3(.a(d), .b(sum1),.sum(sum2));
  

  
 
initial begin
  a=0; b=0; c = 0; d = 0;
  #10 a=16'd56; b=16'd224; c = 16'd224; d = 16'd896; 
  #10 a=16'd14; b=16'd1; c = 16'd224; d = 16'd896;
  #10 a=16'd5; b=16'd0; c = 16'd224; d = 16'd896;
  #10 a=16'd999; b=16'd0; c = 16'd224; d = 16'd896;
  end
 
initial 
  $monitor( "A=%d, B=%d, C=%d, D=%d, Sum=%d", a,b, c, d ,sum2);
endmodule



`timescale 1ns / 1ps
module carry_look_ahead_16bit(a,b, sum);
input [15:0] a,b;
reg cin = 0;
output [15:0] sum;
wire c1,c2,c3;
 
carry_look_ahead_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1));
carry_look_ahead_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2));
carry_look_ahead_4bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3));
carry_look_ahead_4bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout));
 
endmodule

module carry_look_ahead_4bit(a,b, cin, sum,cout);
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;
 
wire [3:0] p,g,c;
 
assign p=a^b;//propagate
assign g=a&b; //generate
 
assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c;
 
endmodule
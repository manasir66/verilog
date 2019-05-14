/* 
 * Do not change Module name 
*/
module main;
 reg [15:0] X, Y;
wire [15:0] sum;


adder_cla16 instance1(.a(X), .b(Y), .sum(sum));

initial 
$monitor ("X = %d, Y = %d , sum = %d", X, Y, sum);



initial begin
  X=0; Y=0;
 #10 X=16'd1; Y=16'd1;
 #10 X=16'd1; Y=16'd2;
 #10 X=16'd1; Y=16'd3; 
 #10 X=16'd2; Y=16'd4;
 #10 X=16'd3; Y=16'd5;
 #10 X=16'd4; Y=16'd6;
 #10 X=16'd5; Y=16'd7; 
 #10 X=16'd6; Y=16'd8;
 #10 X=16'd7; Y=16'd9;
 #10 X=16'd8; Y=16'd10;
 #10 X=16'd9; Y=16'd11; 
 #10 X=16'd10; Y=16'd12;
 #10 X=16'd11; Y=16'd13;
 #10 X=16'd12; Y=16'd14;
 #10 X=16'd13; Y=16'd15; 
 #10 X=16'd14; Y=16'd16;
end
 
endmodule


module adder_cla16(a, b, sum)

input signed [15:0] a, b;
reg cin = 0;
output signed [15:0] sum;
output cout;
wire c1;

adder_cla8 addition1 (.a(a[7:0]),.b(b[7:0]), .cin(cin), .sum.(sum[7:0]), .cout(c1));
adder_cla8 addition1 (.a(a[15:8]),.b(b[15:8]), .cin(c1), .sum.(sum[7:0]), .cout(cout));


end


module adder_cla8 (a,b, cin,sum, cout);

input[7:0] a,b;
output[7:0] sum;

wire g7,g6,g5,g4,g3,g2,g1,g0;
wire p7,p6,p5,p4,p3,p2,p1,p0;
wire c7,c6,c5,c4,c3,c2,c1,c0;


assign 
g7 = a[7] & b[7],
g6 = a[6] & b[6],
g5 = a[5] & b[5],
g4 = a[4] & b[4],
g3 = a[3] & b[3],
g2 = a[2] & b[2],
g1 = a[1] & b[1],
g0 = a[0] & b[0];


assign 
p7 = a[7] ^ b[7],
p6 = a[6] ^ b[6],
p5 = a[5] ^ b[5],
p4 = a[4] ^ b[4],
p3 = a[3] ^ b[3],
p2 = a[2] ^ b[2],
p1 = a[1] ^ b[1],
p0 = a[0] ^ b[0];

assign
c0 = g0 | (p0 & cin),
c1 = g1 | (p1 & g0) | (p1 & p0 & cin),
c2 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & cin) ,
c3 = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & cin);


assign
c4 = g4 | (p4 & c3),
c5 = g5 | (p5 & g4) | (p5 & p4 & c3),
c6 = g6 | (p6 & g5) | (p6 & p5 & g4) | (p6 & p5 & p4 & c3),
c7 = g7 | (p7 & g6) | (p7 & p6 & g5) | (p7 & p6 & p5 & g4) | (p7 & p6 & p5 & p4 & c3);

assign 
sum[0] = p0 ^ cin,
sum[1] = p1 ^ c0 ,
sum[2] = p2 ^ c1 ,
sum[3] = p3 ^ c2 ,
sum[4] = p4 ^ c3 ,
sum[5] = p5 ^ c4 ,
sum[6] = p6 ^ c5 ,
sum[7] = p7 ^ c6 ;

assign cout = c7;

endmodule 



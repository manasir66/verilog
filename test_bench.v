module test_bench;
  reg signed [7:0] m,x;

  wire signed [15:0] a;
  wire signed [15:0] b;
  wire signed [15:0] c;
  wire signed [15:0] d;

 
  Booth8b generate_partialsum(.M(m), .X(x),.a(a) , .b(b) , .c(c) , .d(d));

wire signed [15:0] sum0;
wire signed [15:0] sum1;
wire signed [15:0] sum2;
output cout ;

 
  adder_cla16 addition1(.a(a), .b(b),.sum(sum0));
  adder_cla16 addition2(.a(c), .b(sum0),.sum(sum1));
  adder_cla16 addition3(.a(d), .b(sum1),.sum(sum2));
 
initial begin
  m=0; x=0;
  #10 m=16'd10; x=16'd10; 
  #10 m=16'd15; x=16'd20; 
  #10 m=16'd20; x=16'd30; 
  #10 m=16'd30; x=16'd40; 
  #10 m=16'd40; x=16'd50; 
  #10 m=16'd50; x=16'd60; 
  #10 m=16'd60; x=16'd70; 
  #10 m=16'd70; x=16'd80; 
  #10 m=16'd80; x=16'd90; 
  #10 m=16'd90; x=16'd100; 
  #10 m=16'd110; x=16'd120; 
  #10 m=16'd120; x=16'd130; 
  #10 m=16'd140; x=16'd150; 
  #10 m=16'd160; x=16'd170; 
  #10 m=16'd180; x=16'd190; 
  #10 m=16'd200; x=16'd210; 
  #10 m=16'd255; x=16'd255; 
  
end

initial  
  $monitor("M=%d, X=%d, Sum=%d", m,x ,sum2);
endmodule

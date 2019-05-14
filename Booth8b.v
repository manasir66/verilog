module Booth8b (M, X, a, b, c, d); 

input signed [7:0] M, X; 
output signed [15:0] a, b, c, d; 
  
reg signed [15:0] a, b, c, d; 

  reg [2:0] temp0;
  reg [2:0] temp1;
  reg [2:0] temp2;
  reg [2:0] temp3;
  
  
integer i,j;
reg E1; 
reg [7:0] minusM;
reg [7:0] M2;
reg [7:0] minusM2;

always @ (X, M)	
begin	
a = 16'd0;     
  b = 16'd0;
  c = 16'd0;
  d = 16'd0;
  	
minusM = -M;
M2 = M << 1;
minusM2 = -M2;

 i= 0;
 temp0 = {X[1], X[0] , 1'd0};
  case (temp0)
    3'b001 : a[15:8] = M; 
 // +M
    3'b010 : a[15:8] = M;
 // +M
 3'b011 : begin 
   a[15:8]= M;
   i = 1;
 end
 // +2M
 3'b100 : 
   begin
   a[15:8] = minusM;
   i = 1;
   end 
 // -2M
 3'b101 : a[15:8]= minusM;	
 //-M
 3'b110 : a[15:8] = minusM;	 
 //-M
 default: a = 16'd0;
 endcase
  
  a = a >>> 8 ;
  a = a << i ;
  
  i = 0;
  temp0 = {X[3], X[2] , X[1]};
  case (temp0)
    3'b001 : b[15:8] = M; 
 // +M
 3'b010 : b[15:8] = M;
 // +M
 3'b011 : 
   begin
   b[15:8] = M;
     i = 1;
   end
 // +2M
 3'b100 : 
   begin
     b[15:8] = minusM;
     i = 1;
   end 
 // -2M
 3'b101 : b[15:8] = minusM;	
 //-M
 3'b110 : b[15:8] = minusM;	 
 //-M
 default: b = 16'd0;
 endcase
  
  b = b >>> 6;
  b = b << i ;


  i = 0;
  temp0 = {X[5], X[4] ,X[3]};
  case (temp0)
 3'b001 : c[15:8] = M; 
 // +M
 3'b010 :  c[15:8]= M;
 // +M
 3'b011 : 
   begin 
     c[15:8] = M;
     i = 1;
   end 
 // +2M
 3'b100 :  
   begin
     c[15:8] = minusM;
     i = 1;
   end
 // -2M
 3'b101 :  c[15:8] = minusM;	
 //-M
 3'b110 :  c[15:8]= minusM;	 
 //-M
 default:  c[15:8] = 16'd0;
 endcase
  
  c = c >>> 4;
  c = c << i;
  
  
  i = 0;
  temp0 = {X[7], X[6] , X[5]};
  case (temp0)
 3'b001 :  d[15:8] = M; 
 // +M
 3'b010 : d[15:8] = M;
 // +M
 3'b011 : 
   begin
   d[15:8] = M;
   i =  1;
   end 
 // +2M
 3'b100 : 
   begin
     d[15:8] = minusM;
     i = 1;
   end
 // -2M
 3'b101 : d[15:8] = minusM;	
 //-M
 3'b110 : d[15:8] = minusM;	 
 //-M
 default: d = 16'd0;
 endcase

  d = d >>> 2;	
  d = d << i;
end 
endmodule 
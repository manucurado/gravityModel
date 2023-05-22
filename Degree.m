function [Din,Dout] = Degree (A,directed) 
n = size(A,1); 
Dout = eye(n); 
Din = eye(n); 
for i = 1:n
   Dout(i,i) = 0; 
   Din(i,i) = 0; 
   for j = 1:n 
      Dout(i,i) = Dout(i,i) + A(i,j);
      Din(i,i) = Din(i,i) + A(j,i);
   end
end   
if(directed == false)
    Din = Din + Dout;
end
      
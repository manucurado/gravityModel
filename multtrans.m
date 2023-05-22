function out = multtrans(x,y)
% Codistribute the input matrices
A = codistributed(x,'convert');
B = codistributed(y,'convert');
% Multiply local parts
C = A * B;
% Gather the result on lab 1
out = gather(C,1);
end
Wef = zeros(931);
for i=1:931
    for j=1:931
        if((effgRWED(i,j)) > 0)
            Wef(i,j) = (Dout(i,i)*Din(j,j)) / (effgRWED(i,j))^2;
        end
    end
end


Weffg = zeros(45);
for i=1:295
      Weffg(effgDPED(i,1),effgDPED(i,2)) = effgDPED(i,3);  
end

CeffgRWED = zeros(931,1);
for i=1:931
    for j=1:931
        CeffgRWED(i,1) = CeffgRWED(i,1) + Wef(i,j);
    end
end
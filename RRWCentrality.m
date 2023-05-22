function [C] = RRWCentrality(W,directed)
%STEP 0: initialize

N = size(W,2); %Number of nodes
E = N*N; %Number of edges
[Din,Dout] = Degree(W,directed); %Degree of each node (D(i,i))
V = zeros(E,N); %2-steps Probability Matrix. For each edge (row), exists M different 2-steps transition paths (i->k->j)
T = zeros(N,N); %Transition matrix of each edge (Probability of i->k->j->l->j, where k is Trows and l is Tcolumns).
H = zeros(N,N); %Passage Probability Matrix
C = zeros(2,N); %Centrality measures vector (1-Closeness, 2-Betweenness)

%STEP 1: Fill V
tic
for e=1:E

    i = ceil(e/N); %Indexes i,j corresponding to edge e
    j = mod(e,N);
    if j==0
        j=N;
    end
    if (directed == false)
        Dij = Din(i,i)*Din(j,j);
    else
        Dij = Dout(i,i)*Din(j,j);
    end
    for k=1:N % k transition node
        if(i~=k && j~=i && j~=k)
            V(e,k) = (W(i,k)*W(k,j)) / Dij; %Probability to go: i->k->j
        else
            V(e,k) = 0;
        end
    end
end

toc

for e=1:E  
    %STEP 2: Fill T
    i = ceil(e/N); %Indexes i,j corresponding to edge e
    j = mod(e,N);
    if j==0
        j=N;
    end
     e2 = (j-1)*N + i; %Edge eji
     
       

    T = V(e2,:)'*V(e,:); %Edges eij (e) and eji (e2)
    %T = T.*(1-eye(N));% FALTA Hacer la diagonal 0
    T = T - diag(diag(T));% FALTA Hacer la diagonal 0
    %STEP 3: Fill H
    [M,row] = max(T); %BT
    [M,col] = max(M');
    row = row(col);
    H(i,j) = M; %CL
    %STEP 3.1. Betweenness
    if(M>0)
        C(2,row) = C(2,row) + 1;
        C(2,col) = C(2,col) + 1;
    end
    
end
toc
%tic %STEP 4: Calculate centrality values
% for i=1:N
%     passageTimes = sum(H(:,i));
%     if(passageTimes == 0)
%         C(1,i) = 0;
%     else
%         C(1,i) = N/passageTimes;
%     end
% end
%toc
end
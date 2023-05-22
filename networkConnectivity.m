function [Q,NC] = networkConnectivity(W,remove,node)


%% Inicializamos
Q=0;
N = size(W,1);
G = W;
SP = 0;
NC = 0; % Nº Caminos no conectados
%% Si deseamos borrar un nodo, remove tiene que valer 1
if remove == 1
    G(node,:) = 0;
    G(:,node) = 0;
end
%% Formula
for i=1:N
    i
    for j=1:N
        SP = graphshortestpath(G, i, j);%,'Directed', false);
        if SP > 10000 %% Controlar el INF
            SP = 0;
            NC = NC + 1;
        end
        Q = Q + SP;
    end
end
%% Valor de retorno
Q = Q/(N*N - NC);
end
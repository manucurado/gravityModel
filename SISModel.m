function [S,I,time] = SISModel(sim_time,S0,I0,lambda)
 
%% This function implements the stochastic SIS model with demography.
%  Five independent events can evolve the system
%  implemented using the Gillespie's First reaction algorithm.
%  lambda(1) is birth rate: 1/(50*52)
%  lambda(2) is transmission parameter: 5/wk
%  lambda(3) is the rate of recovery: 1/week
%  Usage[S,I,time] = SISModel(10,99,1,[1/2600 5 1])
%  Function written and designed by tim kinyanjui
%  timothykinyanjui@yahoo.com
%  on 11th August 2009

%% Initialize the vectors for code optimization
S=zeros(sim_time,1);
I=zeros(sim_time,1);
time=zeros(sim_time,1);
rate=zeros(5,1);
dt=zeros(5,1);
%  End of initialization

%% Store the initial conditions
S(1)=S0;
I(1)=I0;
time(1)=0;

%% Initilaize counter to keep track of vector positions
i=2;

%% Now implement the G-Algorithm
while(time(i-1)<=sim_time)
    % Total population
    N=S(i-1)+I(i-1);
    
    % Check if I is zero. If zero, pad the vectors to avoid crashing
    if(I(i-1)==0)
        S(i)=S(i-1);
        I(i)=I(i-1);
    else
        %% Determine the Rates at which events will occur
        
        % Rate of infection
        rate(1)=lambda(2)*S(i-1)*I(i-1)/N;
        
        % Birth rate
        rate(2)=lambda(1)*N;
        
        % Death rate, Susceptible
        rate(3)=lambda(1)*S(i-1);
        
        % Death rate, Infected
        rate(4)=lambda(1)*I(i-1);
        
        % Rate of recovery
        rate(5)=lambda(3)*I(i-1);
        
        %% Determine the times to the next event for each event (dt)
        %  The rand function generates a uniform random number between
        %  0 and 1. This is where chance gets to play a part
        j=1;
        while(j<=5)
            dt(j)=-log(rand(1))/rate(j);
            j=j+1;
        end
        
        %% Find the minimum of the dt to determine the time to the next
        % event and the next event is determined by the position (on the 
        % vector) of the minimum value returned by the variable k
        [min_t,k]=min(dt);
        
        %% Update the system states
        if(k==1)
            % Infection occurs
            S(i)=S(i-1)-1;
            I(i)=I(i-1)+1;
        elseif(k==2)
            % Birth occurs
            S(i)=S(i-1)+1;
            I(i)=I(i-1);
        elseif(k==3)
            % Death of susceptible
            S(i)=S(i-1)-1;
            I(i)=I(i-1);
        elseif(k==4)
            % Death of infected
            I(i)=I(i-1)-1;
            S(i)=S(i-1);
        else
            % Recovery occurs
            I(i)=I(i-1)-1;
            S(i)=S(i-1)+1;
        end
    end
    
    %% Increase to the next time step
    time(i)=time(i-1)+dt(k);
    i=i+1;
end

return
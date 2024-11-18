function [Alpha,Beta,Gamma] = GetBand(Signal,waveletFunction)
    [C,L] = wavedec(Signal, 5,waveletFunction);

    % D1 = wrcoef('d',C,L,waveletFunction,1); %NOISY 
    D2 = wrcoef('d',C,L,waveletFunction,2); %Gamma 
    D3 = wrcoef('d',C,L,waveletFunction,3); %Beta 
    D4 = wrcoef('d',C,L,waveletFunction,4); %Alpha
    D5 = wrcoef('d',C,L,waveletFunction,5); %Theta 
    A5 = wrcoef('a',C,L,waveletFunction,5); %Delta

    Gamma = D2; 
    Beta = D3;  
    Alpha = D4; 
    Theta = D5; 
    Delta = A5; 
end 


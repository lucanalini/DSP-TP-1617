%%% TP 2- %%%

% REMINDER 1

F=1; 
t=0:0.2:20;
funsin=sin(2*pi*F*t);
%plot(funsin)

% sampling sin function at 20hz
fs=20;
sampx=sin(2*pi*(F/fs)*t);
%subplot(1,2,1), plot(funsin)
%subplot(1,2,2), plot(sampx)

%%% EXERCISE 1 %%%%
stEx1=step(4,20);
output=casualucaeze(stEx1);
% it is not casual because started one sample previous to the original
% function

%1.2. we modify the function as y=(x(i)+x(i-1))/2

outputCas=casualucaeze2(stEx1);
subplot(3,1,1), stem(stEx1)
title('original step')
subplot(3,1,2), stem(output)
title('Function y no-casual')
subplot(3,1,3), stem(outputCas)
title('Casual proposed Y function')

%%%%% EXERCISE 2
% we enter the previous step(4,20) function to our cumulative function
outPrim=prim(stEx1);
figure, subplot (2,1,1), stem(stEx1)
subplot(2,1,2), stem(outPrim)

%No, because if the amount of samples tends to infinite, also the output
%tends to infinite.

%2.1. IMULSE RESPONSER OF  OUR PRIM FUNCTION 
impulseLE= zeros(20);
impulseLE(5)=1;

outputImp=prim(impulseLE);
figure, subplot (2,1,1), stem(impulseLE)
subplot(2,1,2), stem(outputImp)

% now our function is stable (limited between 0 and 1)

% 2.3
outputX2Y=x2y(impulseLE);
figure, subplot (2,1,1), stem(impulseLE)
subplot(2,1,2), stem(outputX2Y)
% we can see it is not stable (divergent output for incresing amount of samples)

%2.4 
outputTURTS=IlikeTurtles(impulseLE);
figure, subplot (2,1,1), stem(impulseLE)
subplot(2,1,2), stem(outputTURTS)

% now is stable, it is limited between 0 and 1

%%%


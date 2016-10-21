function lu = couniform()
lu  = rand(1000,1);
lu = xcorr(lu,'biased');
%white noise because the g. noise is not dependent on the f and the energy
%level is the same also for uniform noise
end
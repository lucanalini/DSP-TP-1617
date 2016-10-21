function cogausluca = cogausluca()
cogausluca = randn(1000,1);
cogausluca = xcorr(cogausluca, 'biased'); %this command is for the correlation
end
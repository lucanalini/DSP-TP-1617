function g = sinfn2(f,Ts)
u = 0.2; %f = 0, time period = 0.1
t = (0 : Ts : u-Ts);
g = sin(2*pi*f*t);
end

function k = step(n,N)
k = 1 : 20;
for i = 1 : 10
    k(i) = 0;
    k(i+9) = 1;
end
k(20) = 1;
k(10) = 1;
end
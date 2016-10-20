function k = rampluca(n,N,a)
k = zeros(N,1);
h = 1;
for j = n : N
    k(j) = h*a;
    h = h + 1;
end

end
function o = geo1(n, N, a)
o = zeros(N,1);
l = 1;
for i = n : N
    o(i) = a^l;
    l = l + 1;
end
end
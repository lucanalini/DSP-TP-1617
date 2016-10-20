function z = box1(n,N,a)
z = zeros(N,1);
for i = n-a:n+a
    z(i)=1;
end
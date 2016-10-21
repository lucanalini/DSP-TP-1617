function [lu1,lu2,lu3,lu4] = binarlu()


e = round(rand(1,50));
f = round(rand(1,50));
g = round(rand(1,50));
b = zeros(300,1);
for k = 1 : 50
    b(k) = e(k);
end

for k = 51 : 300
    e(k) = 0;
end

for k = 1 : 50
    b(k+100) = f(k);
end

for k = 51 : 300
    f(k) = 0;
end

for k = 1 : 50
    a(k + 200) = g(k);
end

for k = 51 : 300
    g(k) = 0;
end


lu1 = b;
lu2 = corrcoef(lu1,e);
lu3 = corrcoef(lu1,f);
lu4 = corrcoef(lu1,g);

end

    

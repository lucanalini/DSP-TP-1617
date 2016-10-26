function [y]=x2y(x)
y=zeros(1,length(x));
for i=2:length(x)
    y(i)=x(i) + 2*y(i-1);
end
y(1)= x(1);
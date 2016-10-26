function [y]=IlikeTurtles(x)
y=zeros(1,length(x));
for i=2:length(x)
    y(i)=x(i) + y(i-1)/3;
end
y(1)= x(1);
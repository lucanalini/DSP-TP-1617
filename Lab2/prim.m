function [y]=prim(x)
for i=1:length(x)
  y(i)=sum(x(1:i));
end
   function [y]= casualucaeze2(x)
    y=zeros(length(x));
    for i=2:length(x)
     y(i)= (x(i)+x(i-1))/2;
    end
    y(1)=x(1);
s = dirac1(10,20);
figure, stem(s)
title('Dirac function')
xlabel('Samples')
ylabel('Amplitude')


r = step(10,20);
figure, stem(r)
title('Step function')
xlabel('Samples')
ylabel('Amplitude')

v = rampluca(10,20,2);
figure, stem(v)
title('Ramp function')
xlabel('Samples')
ylabel('Amplitude')


q = geo1(10, 20, 2);
figure, stem(q)
title('Geometric function')
xlabel('Samples')
ylabel('Amplitude')

m = box1(10,20,1);
figure, stem(m)
title('Box function')
xlabel('Samples')
ylabel('Amplitude')

p = sinfn1(10,1/100);
figure, stem(p)
title('sin1 function')
xlabel('Samples')
ylabel('Amplitude')

n = sinfn2(10,1/1000);
figure, stem(n)
title('sin2 function')
xlabel('Samples')
ylabel('Amplitude')

t = sinfn2(10,1/30);
figure, stem(t);
title('sin3 function')
xlabel('Samples')
ylabel('Amplitude')

%%%%%second exercise

%histogram of gaussian distribution
pu = gaussialuca(1000);
figure, histfit(pu)
title('Histogram distribution for n = 1000')

pu1 = gaussialuca1(10000);
figure, histfit(pu1)
title('histogram distribution for n = 100000')

%uniform law
pu2 = unifluca(1000);
figure, histfit(pu2)
title('uniform distribution for n = 1000')

%autocorrelation
pu3 = cogausluca();
figure, plot(pu3)
title('autocorrelation gaussian noise')

pu4 = couniform();
figure, plot(pu4)
title('autocorrelation uniform noise')

[q1,q2,q3,q4] = binarlu;
figure, plot(q1);

figure, plot(q2);

figure, plot(q3);

figure, plot(q4);

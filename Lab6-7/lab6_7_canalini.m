%LAB 6 AND 7 DSP

% 1.

%Butter worth- BAND PASS

Sampfreq=1000;
InfCutFreq= 30;
SupCutFreq=100;
Wn=[InfCutFreq/(Sampfreq/2), SupCutFreq/(Sampfreq/2)];
[b, a] = butter(3, Wn);
[h,w]=freqz(b,a);

figure, subplot (2,2,1), plot(w./pi,abs(h))
title('Butterworth Bandpass Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Lowpass
Wn=[InfCutFreq/(Sampfreq/2)];
[b, a] = butter(3, Wn);
[h,w]=freqz(b,a);

subplot (2,2,2), plot(w./pi,abs(h))
title('Butterworth Lowpass Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Highpass
Wn=[SupCutFreq/(Sampfreq/2)];
[b, a] = butter(3, Wn,'high');
[h,w]=freqz(b,a);

subplot (2,2,3), plot(w./pi,abs(h))
title('Butterworth HIghpass Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Stop-band
Wn=[InfCutFreq/(Sampfreq/2), SupCutFreq/(Sampfreq/2)];
[b, a] = butter(3, Wn,'stop');
[h,w]=freqz(b,a);

subplot (2,2,4), plot(w./pi,abs(h))
title('Butterworth Bandstop Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

close ALL

%%%%%%% CHEBYCHEV %%%%%%%%
Sampfreq=1000;
InfCutFreq= 30;
SupCutFreq=100;
Wn=[InfCutFreq/(Sampfreq/2), SupCutFreq/(Sampfreq/2)];
[b, a] = cheby1(3,0.5, Wn);
[h,w]=freqz(b,a);

figure, subplot (2,2,1), plot(w./pi,abs(h))
title('Chebychev-I Bandpass Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Lowpass
Wn=[InfCutFreq/(Sampfreq/2)];
[b, a] = cheby1(3, 0.5, Wn);
[h,w]=freqz(b,a);

subplot (2,2,2), plot(w./pi,abs(h))
title('Chebychev-I Lowpass Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Highpass
Wn=[SupCutFreq/(Sampfreq/2)];
[b, a] = cheby1(3, 0.5, Wn,'high');
[h,w]=freqz(b,a);

subplot (2,2,3), plot(w./pi,abs(h))
title('Chebychev-I HIghpass Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Stop-band
Wn=[InfCutFreq/(Sampfreq/2), SupCutFreq/(Sampfreq/2)];
[b, a] = cheby1(3, 0.5, Wn,'stop');
[h,w]=freqz(b,a);

subplot (2,2,4), plot(w./pi,abs(h))
title('Chebychev-I Bandstop Filter')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% 1.2

close ALL

% Lowpass

Wn=[InfCutFreq/(Sampfreq/2)];
[b, a] = cheby1(3, 1, Wn);
[h,w]=freqz(b,a);

subplot (2,2,1), plot(w./pi,abs(h))
title('Chebychev-I Lowpass Filter 3 Order')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% order 5
Wn=[InfCutFreq/(Sampfreq/2)];
[b, a] = cheby1(5, 1, Wn);
[h,w]=freqz(b,a);

subplot (2,2,2), plot(w./pi,abs(h))
title('Chebychev-I Lowpass Filter 5 Order')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% order 10
Wn=[InfCutFreq/(Sampfreq/2)];
[b, a] = cheby1(10, 1, Wn);
[h,w]=freqz(b,a);

subplot (2,2,3), plot(w./pi,abs(h))
title('Chebychev-I Lowpass Filter 10 Order')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')


% order 20
Wn=[InfCutFreq/(Sampfreq/2)];
[b, a] = cheby1(20, 1, Wn);
[h,w]=freqz(b,a);

subplot (2,2,4), plot(w./pi,abs(h))
title('Chebychev-I Lowpass Filter 20 Order')
xlabel('Normalized Frequency, pi rad/sample')
ylabel('Amplitude')

% Conclusion about CHEBYCHEV 
% Increasing the order of the filter, generates a much more 'straight'
% transition to the cutoff frequency (the slope is much pronounced).
% However, the 'ripple' is much more strong, thus deeper changes in
% the response are observed, which it is not desired. 
%Until a 10-order filter, the response is acceptable. However, increasing
%even more the order, perturbates stronger the response (the filter is not
%well designed). So, a compromise between 'ripple effect' and 'transition band' has to be balanced accpomplished.

% 2 Recursive filtering

%2.1 and 2.2
vec = zeros(1,40);
vec(1,20)=1;
alfa=0.5;
ConstA=exp(-alfa);

CasualY=zeros(1,40);
CasualY(1)=vec(1);
CasualY(2)=vec(2)+ ConstA*(alfa-1)*vec(1)+ 2*ConstA*(CasualY(1));

for (k=3:length(vec))
   CasualY(k)= vec(k) + ConstA*(alfa-1)*vec(k-1) + 2*ConstA*CasualY(k-1) - (ConstA^2)*CasualY(k-2);
    
end

AntiCasualY=zeros(1,40);
AntiCasualY(40)=0;
AntiCasualY(39)=vec(2)+ ConstA*(alfa-1)*vec(1)+ 2*ConstA*(CasualY(1));

for (k=(length(vec)-2):-1:1)
   AntiCasualY(k)= ConstA*(alfa+1)*vec(k+1)-(ConstA^2)*vec(k+2)+2*ConstA*AntiCasualY(k+1)-(ConstA^2)*AntiCasualY(k+2);
end

outputFilter= CasualY + AntiCasualY;
figure,plot(outputFilter)
title ('Signal Output after Derivative Filtering')

%The shifted dirac impulse has been smoothed. That means that the signal
%is now defined not only in just one value, but also in previous and
%posterior ones. The signal has now the same peak value, but with a upward
%and downward transition bands (positive (negative) slope before (after)
%the peak).

% 2.3 and 2.4 exercise 
vec= zeros(1,40);
vec(10:30)=1;

alfa=0.5;
ConstA=exp(-alfa);

CasualY=zeros(1,40);
CasualY(1)=vec(1);
CasualY(2)=vec(2)+ ConstA*(alfa-1)*vec(1)+ 2*ConstA*(CasualY(1));

for (k=3:length(vec))
   CasualY(k)= vec(k) + ConstA*(alfa-1)*vec(k-1) + 2*ConstA*CasualY(k-1) - (ConstA^2)*CasualY(k-2);
    
end

AntiCasualY=zeros(1,40);
AntiCasualY(40)=0;
AntiCasualY(39)=vec(2)+ ConstA*(alfa-1)*vec(1)+ 2*ConstA*(CasualY(1));

for (k=(length(vec)-2):-1:1)
   AntiCasualY(k)= ConstA*(alfa+1)*vec(k+1)-(ConstA^2)*vec(k+2)+2*ConstA*AntiCasualY(k+1)-(ConstA^2)*AntiCasualY(k+2);
end

outputFilter= CasualY + AntiCasualY;
figure,plot(outputFilter)
title ('Signal Output after Derivative Filtering')

% The rectangular window it is smoothed. It can be seen that the upward and
% downward slopes, that are completelly straight in the rect, now are
% less strong, with a transition band.


% 3 Canny-Deriche filtering

%Question 3
barb_im = imread('C:\Users\Ezequiel\Documents\DSP Lab\DSP-TP-1617\Lab6-7\images\barbara.gif');
case1 = zeros(size(barb_im)); 
case2 = zeros(size(barb_im)); 


for i = 1:size(barb_im, 2)
    image1 = barb_im(:,i);
    image1=image1';
    causal_resp= zeros(length(image1),1) ;
    causal_resp(1)=image1(1);
    causal_resp(2)=image1(2)+ ConstA*(alfa-1)*image1(1)+ 2*ConstA*(image1(1));
    for k = 3 : length(image1)
     causal_resp(k) = image1(k)+ConstA*(alfa-1)*image1(k-1) + 2*ConstA*causal_resp(k-1) - (ConstA^2)*causal_resp(k-2);
    end
    antiCausal_resp = zeros(length (image1),1) ;
    antiCausal_resp(length(image1))=0;
    antiCausal_resp(length(image1)-1)=image1(2)+ ConstA*(alfa-1)*image1(1)+ 2*ConstA*(antiCausal_resp(1));
    barbara_length = length(image1)-2 : -1 : 1 ;
    for k =  barbara_length
     antiCausal_resp(k) = ConstA*(alfa+1)*image1(k+1)-(ConstA^2)*image1(k+2)+2*ConstA*antiCausal_resp(k+1)-(ConstA^2)*antiCausal_resp(k+2);
    end
    response = causal_resp + antiCausal_resp;
    case1(:,i) = response;            
end
%figure, imshow (case1, [])

for k = 1:size(barb_im, 2)
    image2 = barb_im(k,:);
    causal_resp = zeros(length(image2),1) ;
    causal_resp(1)=image2(1);
    causal_resp(2)=image2(2)+ ConstA*(alfa-1)*image2(1)+ 2*ConstA*(image2(1));
    for l = 3 : length(image2)
     causal_resp(l) = image2(l)+ConstA*(alfa-1)*image2(l-1) + 2*ConstA*causal_resp(l-1) - (ConstA^2)*causal_resp(l-2);
    end
    antiCausal_resp = zeros(length(image2), 1);
    antiCausal_resp(length(image2))=0;
    antiCausal_resp(length(image2)-1)=image(2)+ ConstA*(alfa-1)*vec(1)+ 2*ConstA*(antiCausal_resp(1));
    b_length = length(image2)-2 : -1 : 1;
    for l=  b_length 
     antiCausal_resp(l) = ConstA*(alfa+1)*image2(l+1)-(ConstA^2)*image2(l+2)+2*ConstA*antiCausal_resp(l+1)-(ConstA^2)*antiCausal_resp(l+2);
    end
    response2 = causal_resp + antiCausal_resp;
    case2(k,:) = response2;   
end

figure, subplot (1,2,1), imshow (case1, [])
subplot (1,2,2), imshow (case2, [])


% 1.1
img = zeros(301,301);
img(100:200, 140:160) = 255;
figure(1);
imshow(img);

% 1.2
imgFreq = fftshift(fft2(img));
figure;
subplot(121); 
imagesc(abs(imgFreq)); 
colormap('gray'); 
title('Magnitude') 
subplot(122); 
imagesc(angle(imgFreq)/pi*180); 
colormap('gray'); 
title('Phase')

% 1.3

% Translated image
imgTrans = zeros(301,301);
imgTrans(150:250, 160:180) = 255;
imgFreqT = fftshift(fft2(imgTrans));
figure;
subplot(121); 
imagesc(abs(imgFreqT)); 
colormap('gray'); 
title('Magnitude of Translation') 
subplot(122); 
imagesc(angle(imgFreqT)/pi*180); 
colormap('gray'); 
title('Phase of Translation')

% we can observe that the effect of spatial-translation has no effect on
% the magnitude but the imaginary part is changed

% Rotated image
imgRot = imrotate(img, 45);
imgFreqR = fftshift(fft2(imgRot));
figure;
subplot(121); 
imagesc(abs(imgFreqR)); 
colormap('gray'); 
title('Magnitude of Rotation') 
subplot(122); 
imagesc(angle(imgFreqR)/pi*180); 
colormap('gray'); 
title('Phase of Rotation')

% in this case the effect of spatial-rotation has effect on the magnitude;
% in particular the magnitude spectrum is rotated of 45°, the same degrees
% of the spatial rotation.


% Synthetic image 2
img2 = zeros(301,301);
img2(20:120, 140:160) = 255;
img2(180:280, 140:160) = 255;
imgFreq2 = fftshift(fft2(img2));
figure;
subplot(121); 
imagesc(abs(imgFreq2)); 
colormap('gray'); 
title('Magnitude two bars') 
subplot(122); 
imagesc(angle(imgFreq2)/pi*180); 
colormap('gray'); 
title('Phase two bars')

% Synthetic image 3
img3 = zeros(301,301);
img3(100:200, 145:155) = 255;
imgFreq3 = fftshift(fft2(img3));
figure;
subplot(121); 
imagesc(abs(imgFreq3)); 
colormap('gray');
title('Magnitude thiner bar') 
subplot(122); 
imagesc(angle(imgFreq3)/pi*180); 
colormap('gray'); 
title('Phase thiner bar')

%confront the 3 spectrum together
figure;
subplot(1,3,1); 
imagesc(abs(imgFreq)); 
colormap('gray'); 
title('Magnitude original') 
subplot(1,3,2); 
imagesc(abs(imgFreq2)); 
colormap('gray'); 
title('Magnitude two bars') %two bars
subplot(1,3,3); 
imagesc(abs(imgFreq3)); 
colormap('gray'); 
title('Magnitude thiner bar') %thiner bar

% when we insert another bar in our image, we can see a sharper
% magnitude-spectrum along the y dimension. It is related to the fact that
% we are adding "two rects" in spatial domain symmetrically disposed, it
% brings "two sincs" simmetrically disposed in frequency domain : the lower
% values in f-domain are reduces, so we have less blurring than the
% original img

% when we decrease the dimension of the bar, we are
% increasing the changes of intensity values -> more frequency along x axis
% and so the spectrum is larger 

%1.4
Im=0;
N=64;
T=1;
Ts=T/N;
Fs=1/Ts;
df=Fs/N;
Im(N/8:N/4,N/4+1:N/2)=1;
Im(1:N/4,N/2+1:N)=Im;
Im(N/4+1:N/2,:)  = Im;
Im(N/2+1:3*N/4,:)  = Im(1:N/4,:);
Im(3*N/4+1:N,:)  = Im(1:N/4,:);

%fourier transform
im14 = fftshift(fft2(Im));
figure;
subplot(1,3,1);
imagesc(Im);
colormap('gray');
title('im');
subplot(1,3,2); 
imagesc(abs(im14)); 
colormap('gray');
title('Magnitude') 
subplot(1,3,3); 
imagesc(angle(im14)/pi*180); 
colormap('gray'); 
title('Phase')

%we search for normalized center frequency
[m, n] = size(Im);
mn = m*n;
f = sum(sum(Im))/mn; %F(0,0) = mean computed by the image
[l, i] = size(im14);
foo1 = im14(l/2+1,i/2+1)/mn; %F(0,0) taken directly in the fourier transform

verifynor = isequal(f,foo1);
%verify that foo1 is equal to f

%1.5
im14first = im14(:,i/2+1);
axi = 1 : i;
im14second = im14(l/2+1,:);
axl = 1 : l;
figure;
subplot(1,2,1);
plot(axi,abs(im14first));
colormap('gray');
title('Magnitude (:,0)');
subplot(1,2,2); 
plot(axl,abs(im14second)); 
colormap('gray');
title('Magnitude (0,:)') 

%the profiles of the two images refer rispectively to the central 
%column and to the central row of the orginal image: along the
% y-component of spectrum of the original image there is higher frequency
% than along the x-component -> in the profile of the first image there are more 
% peaks at higher frequency. On the contrary, the profile of the second
% spectrum has a sharped decresing tendence

%1.6
lena=imread('/Users/Luca/Desktop/France Lectures/DSP/DSP-TP-1617/Lab5/images/lena-grey.bmp');
lenafreq = fftshift(fft2(lena));
figure;
subplot(121); 
imagesc(abs(lenafreq)); 
colormap('gray'); 
title('Magnitude lena') 
subplot(122); 
imagesc(angle(lenafreq)/pi*180); 
colormap('gray'); 
title('Phase lena')
lenarec = ifft2(ifftshift(lenafreq));
lenarec = uint8(lenarec);
figure, imshow(lenarec)
title ('reconstructed lena');
b = isequal(lena,lenarec);
% b = 1 so the reconstructed image is equal to the original

%1.7 Sobel filter in frequency domain

hsobel = fspecial('sobel');
%we decide the zero padding dimensions
zero_dim = 2*(size(lena));
%we are padding the two images
lenafft = fft2(double(lena), zero_dim(1), zero_dim(2));
sobelfft = fft2(double(hsobel), zero_dim(1), zero_dim(2));
%convolution in time -> product in frequency
imagefiltered_freq = sobelfft.*lenafft;
imagefilterred_anti = ifft2(imagefiltered_freq);
%we select the part of the transformation where filteredlena is
imagefilterred_anti = imagefilterred_anti(2:size(lena,1)+1, 2:size(lena,2)+1);

%we apply the same filter but in spatial-domain (to verify)
imagefiltered_spatial = imfilter(double(lena),hsobel, 0, 'conv');

figure
subplot(121), imshow(abs(imagefiltered_spatial), [])
title ('sobel in time');
subplot(122), imshow(abs(imagefilterred_anti), []);
title ('sobel in freq')






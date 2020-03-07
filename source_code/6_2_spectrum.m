I=imread('../image/rectangle.tif');
figure(1); subplot(2,2,1); imshow(I);
title('Input image');

F=fft2(I); %DFT %M와 N을 따로 안준 이유 : 영상의 가로 세로 : 512X512 의 반복
size(F)

absF=abs(F); subplot(2,2,2); imagesc(absF); %real 와 img -> 각각 제곱해서 더하는 것 
axis image %영상 아니라서 axis image 해줘야함
title('Original Spectrum');

centerF=fftshift(F); %center FFT %I*(-1)^(x+y) bla bla 해줘야 shifting 하는데 다른 것 있음
absCenterF=abs(centerF); subplot(2,2,3); imagesc(absCenterF);
title('Centered Spectrum'); #shifted spectrum

%log intensity transform
logF=log(absCenterF+1); subplot(2,2,4); imagesc(logF);
title('Log of Centered Spectrum'); axis image;
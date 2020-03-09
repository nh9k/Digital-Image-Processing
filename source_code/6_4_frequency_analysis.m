Ic=imread('triangle.png');
I=rgb2gray(Ic);
figure(1); imshow(I);

F=fft2(I); % 복소수 영상으로 나옴
Fs=fftshift(F);
magF=abs(Fs);
figure(2); imagesc(log(1+magF)); colormap gray;
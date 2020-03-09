I=imread('testPlate.tif');
figure(1); subplot(2,2,1); imshow(I); title('Input');

F=fft2(I);
Fcenter=fftshift(F); 

magF=abs(Fcenter); 
figure(1); subplot(2,2,2); imagesc(log(1+magF)); axis image; 
title('Spectrum'); 

[M ,N]=size(I);

u=0:(M-1); v=0:(N-1);
u=u-M/2; v=v-N/2; 

[V, U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2); 
figure; imagesc(D); colormap gray; axis image; colorbar;
P=100; %VAR 
H=1-double(D<=P); %여기만 다름
figure(1); subplot(2,2,3); imagesc(H); axis image;
title('ILPF Mask: H');

h=real(ifft2(double(ifftshift(H))));
figure; imagesc(fftshift(h)); axis image; 

G=H.*Fcenter; 
magG=abs(G);
figure(1); subplot(2,2,4); imagesc(log(1+magG)); axis image;
title('Filtering: H*F');

g=real(ifft2(double(ifftshift(G))));
figure; imshow(uint8(g)); title('Inverse FFT2');

I=imread('testPlate.tif');
figure(1); subplot(2,2,1); imshow(I); title('Input');

%FFT of input image
F=fft2(I);
Fcenter=fftshift(F); %원점을 중간으로 옮기는 변환 함수

%Magnitude,spectrum
magF=abs(Fcenter); % real와 imaginaly의 크기
figure(1); subplot(2,2,2); imagesc(log(1+magF)); axis image; 
title('Spectrum'); %주파수 크기

%make an ideal lowpass filter mask
[M ,N]=size(I);

%영상 0,0부터 시작해서 벡터를 만듦
u=0:(M-1); v=0:(N-1);
u=u-M/2; v=v-N/2; %중심을 맞춰주는 부분

%각각의 교차하면서 Grid 만들어주는 함수 mesh-
[V, U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2); %모든 픽셀마다 중심으로 부터 거리를 계산하는 D
figure; imagesc(D); colormap gray; axis image; colorbar;
P=10; %cut-off frequency %수정하면서 테스트
H=double(D<=P); %만족하면 1 아니면 0 나오는 logical data를 double data로 변환
figure(1); subplot(2,2,3); imagesc(H); axis image;
title('ILPF Mask: H');

%check filter shape in spatial domain
h=real(ifft2(double(ifftshift(H))));
figure; imagesc(fftshift(h)); axis image; %colormap gray;%원점으로 말고 반대로 할때

%filtering in frequency domain
G=H.*Fcenter; %F는 shift 전이라서, Fcenter 사용
magG=abs(G);%이건 visualize 목적
figure(1); subplot(2,2,4); imagesc(log(1+magG)); axis image;
title('Filtering: H*F');

%inverse FFT2
g=real(ifft2(double(ifftshift(G))));
figure; imshow(uint8(g)); title('Inverse FFT2');

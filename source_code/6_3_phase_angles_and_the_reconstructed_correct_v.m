I = imread('../image/myimg.jpg');
I = rgb2gray(I); % 흑백화
I = imresize(I, [512, 512]); % rectangle 차원맞추기 (사이즈조절) 
subplot(2,3,1); imshow(I); title('original image');

F = fft2(I); %패스트 퓨리에 트랜스폼
Fmag = abs(F); % 이미지와 같은 magnitude, 0 phase 
Fphase = exp(1i*angle(F)); % magnitude 1, 이미지와 같은 phase 

% reconstruction
Remag = log(abs(ifft2(Fmag*exp(i*0)))+1); %magnitude inverse 퓨리에
Rephase = ifft2(Fphase); %phase invers 퓨리에

subplot(2,3,2); imshow(Fphase); title('Phase');
subplot(2,3,3),imshow(Rephase,[]), colormap gray 
title('Reconstructed Phase');
subplot(2,3,4),imshow(Remag,[]), colormap gray 
title('Reconstructed Spec');

% Rectangle
I2=imread('rectangle.tif');
F2=fft2(I2); %패스트 퓨리에 트랜스폼
F2mag= abs(F2); 
F2phase = exp(1i*angle(F2));

a1=F2mag.*Fphase; a2=ifft2(a1); %rect mag + my phase, after inverse 퓨리에
subplot(2,3,5); imshow(a2,[]); title('My phase+Rect spec')
b1=Fmag.*F2phase; b2=ifft2(b1); %my mag + rect phase, after inverse 퓨리에
subplot(2,3,6); imshow(b2,[]); title('Rect phase+My spec ')


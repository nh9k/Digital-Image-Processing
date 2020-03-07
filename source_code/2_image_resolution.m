%image load
Ic=imread('../image/head.png'); 

%rgb->gray
I=rgb2gray(Ic); 
imshow(I);

%image resize
Ir=imresize(I,[200,500]); %0.5 %[500,500]
figure(2); imshow(Ir); title('Resized Image');

%영상 전체의 최댓값
max(Ir(:)) 

%intensity level control
bits=2; %원래 영상 8bit -> 이진화
interval=256/2^bits;

%rounding
I1=round(I/interval);
max(I1(:))
min(I1(:))
figure(3); imshow(I1)

%2^(8-bits) = interval
I2=I1*2^(8-bits); 

% uint -> 1~256 ->0~255
I2=uint8(I1*interval); 
figure(3); imshow(I2); 
title(['intensity level :' num2str(2^bits)]);

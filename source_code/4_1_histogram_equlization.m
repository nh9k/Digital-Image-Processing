% original image
I=imread('../image/light.tif');
figure(1); subplot(2,2,1); imshow(I); title('input');

% gray and histogram
Ig=rgb2gray(I);
h1=imhist(Ig,256);
figure(1); subplot(2,2,2); bar(h1);%plot(h1); %bar¾²¸é Â¦´ë±â ³ª¿È 

% apply histogram equalization
J=histeq(Ig);
figure(1); subplot(2,2,3); imshow(J);

% histogram
h2=imhist(J,256);
figure(1); subplot(2,2,4); bar(h2);

%%
%histogram matching
i1=imread('../image/pout.tif');
i2=imread('../image/tire.tif');
figure(1); imshow(I1); title('reference');
figure(2); imshow(I2); tittle('input');
imatched=imhistmatch(I2,I1,256);
figure(3); imshow(imatched'); title('matched');
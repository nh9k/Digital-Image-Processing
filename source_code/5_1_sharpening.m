Ic=imread('../image/moon.bmp');
I=rgb2gray(Ic);
figure(1); imshow(I); title('Original');

%Laplacian kernel:method 1
K=[0 1 0;
   1 -4 1;
   0 1 0];
f2=imfilter(I,K,'replicate','same');
figure(2); imshow(f2); title('2nd derivatives');

%sharpend
g=uint8(I-f2);
figure(3); imshow(g); title('sharpend');

%Laplacian kernel:method 2
K1=[1 1 1;
   1 -8 1;
   1 1 1];
f2_1=imfilter(I,K1,'replicate','same');
figure(4); imshow(f2_1); title('2nd derivatives 2');

%sharpend
for i=1:100
c=-i*0.1 % ¿ø·¡ -1.5
g1=uint8(double(I)+c*double(f2_1)); %double·Î ¿Ã·Á³ö¾ß Á¤¼öÇü °öÇÏ±â Àß µÊ
figure(5); imshow(g1); title('sharpend 2');
pause(0.1);
end

%sharpening using unsharp mask
%step1:smoothing                                    generate unsharp mask image
w=fspecial('gaussian',[5,5],1); figure(6); imagesc(w); colormap gray;
f_=imfilter(I,w,'replicate','same');

%step2:unsharp masking
gmask=double(I-f_);

%step3:input+unsharp mask 
k=4.6;
g=uint8(double(I)+k*gmask);
figure(7); imshow(g); title('sharpend by unsharp mask');








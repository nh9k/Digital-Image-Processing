%%real test code

I=imread('VV.jpg'); %load an gray image
figure(1);  imshow(I); title('Input image');

tic
Inn=imresize(I,0.85,'nearest');
Ibil=imresize(I,0.85,'bilinear');
Ibic=imresize(I,0.85,'bicubic');

figure(2); 
subplot(2,4,1); imshow(I); title('origin');
subplot(2,4,2); imshow(Inn); title('NN 0.85 times');
subplot(2,4,3); imshow(Ibil); title('bilinear 0.85 times');
subplot(2,4,4); imshow(Ibic); title('bicubic 0.85 times');

Inn2=imresize(I,1.24,'nearest');
Ibil2=imresize(I,1.24,'bilinear');
Ibic2=imresize(I,1.24,'bicubic');

%subplot(2,4,1); imshow(I); title('origin');
subplot(2,4,6); imshow(Inn2); title('NN 1.24 times');
subplot(2,4,7); imshow(Ibil2); title('bilinear 1.24 times');
subplot(2,4,8); imshow(Ibic2); title('bicubic 1.24 times');
xlabel('matlab built-in function 21611591 ±è³­Èñ');
toc

%%

%subplot with 2pictures
I=imread('VV.jpg'); %load an gray image
figure(1);  imshow(I); title('Input image');

Inn=imresize(I,0.85,'nearest');
Ibil=imresize(I,0.85,'bilinear');
Ibic=imresize(I,0.85,'bicubic');

figure(2); 
subplot(1,2,1); imshow(I); title('origin');
subplot(1,2,2); imshow(Inn); title('NN 0.85 times');

figure(3); 
subplot(1,2,1); imshow(Ibil); title('bilinear 0.85 times');
subplot(1,2,2); imshow(Ibic); title('bicubic 0.85 times');

Inn2=imresize(I,1.24,'nearest');
Ibil2=imresize(I,1.24,'bilinear');
Ibic2=imresize(I,1.24,'bicubic');

figure(4);
subplot(1,2,1); imshow(I); title('origin');
subplot(1,2,2); imshow(Inn2); title('NN 1.24 times');

figure(5);
subplot(1,2,1); imshow(Ibil2); title('bilinear 1.24 times');
subplot(1,2,2); imshow(Ibic2); title('bicubic 1.24 times');

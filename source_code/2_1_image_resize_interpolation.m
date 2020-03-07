I=imread('../image/rice.png'); %load an gray image
size(I)
figure(1);  imshow(I); title('Input');

Inn=imresize(I,0.4,'nearest');
Ibil=imresize(I,0.4,'bilinear');
Ibic=imresize(I,0.4,'bicubic');
figure(2);

subplot(1,4,1); imshow(I); title('origin');
subplot(1,4,2); imshow(Inn); title('NN');
subplot(1,4,3); imshow(Ibil); title('bilinear');
subplot(1,4,4); imshow(Ibic); title('bicubic');
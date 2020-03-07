%% Lab2-1
BW = logical([1 1 1 0 0 0 0 0;
    1 1 1 0 1 1 0 0;
    1 1 1 0 1 1 0 0;
    1 1 1 0 0 0 1 0;
    1 1 1 0 0 0 1 0;
    1 1 1 0 0 0 1 0;
    1 1 1 0 0 1 1 0;
    1 1 1 0 0 0 0 0]);

figure(1); subplot(1,3,1); imagesc(BW), colorbar;
title('Input image');


L = bwlabel(BW,8);
subplot(1,3,2); imagesc(L); colormap jet; colorbar;
title('Built-in Blob labeling')
[r, c]=find(L==2);
rc=[r c]

L1 = myBlLabel8(BW);
subplot(1,3,3); imagesc(L1); colormap jet; colorbar;
title('My Blob labeling');
[r1, c1]=find(L1==2);
rc1=[r1 c1]

%% Lab2-2
% load a gray image
grayImage = imread('rice.png');
figure(2), subplot(2,2,1); imshow(grayImage);
title('Input gray image');

% thresholding
brightBlobs = grayImage > 128; % Find bright things.
subplot(2,2,2); imshow(brightBlobs);
title('Binary image');

% labeling
L2 = bwlabel(brightBlobs,8) % blob labeling with 8 adjacency
subplot(2,2,3); imagesc(L2); colormap jet
title('Built-in Blob labeling'); colorbar;

% my labeling
L3 = myBlLabel8(brightBlobs); % my blob labeling with 8 adjacency
subplot(2,2,4); imagesc(L3); colormap jet
title('My Blob labeling'); colorbar;  
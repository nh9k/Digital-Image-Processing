%%
% Load an IMAGE
I=imread('vv.jpg');
figure(1); imshow(I); title('Original Image'); xlabel('21611591 ±è³­Èñ');

%%
% Neareat Neighbor Interpolation / scale : 0.85
tic
myResizeNN('vv.jpg',0.85,2);
toc

% Neareat Neighbor Interpolation / scale : 1.24
tic
myResizeNN('vv.jpg',1.24,3);
toc

%%
% Bilinear Interpolation / scale : 0.85
tic
myResizeBil('vv.jpg',0.85,4);
toc

% Bilinear Interpolation / scale : 1.24
tic
myResizeBil('vv.jpg',1.24,5);
toc
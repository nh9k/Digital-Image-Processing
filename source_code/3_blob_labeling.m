BW=logical([1 1 1 0 0 1 1;
    0 0 1 0 0 0 1;
    0 1 1 1 0 0 0;
    0 0 0 0 1 0 0])

 %우리가 따로 언급안하면 MATLAB에서는 double로 간주
 %loagical 하면 한 byte로 간주
figure(1); imagesc(BW); %auto scale, 공학데이터는 이걸로 주로 사용
figure(2); imshow(BW); % 코딱지만큼 나옴

L=bwlabel(BW,8); %blob label with 8 adiacency %내가 보고있는 Color label 숫자로 나옴
L=bwlabel(BW,4);
figure(3); imagesc(L); colorbar; % color label나옴
colormap jet % 더 무지개처럼 나옴
colormap bone % 뼈다귀 색깔

%find specific region
[r c]=find(L==3); %row col
rc=[r c];
figure(3); hold on;
plot(c,r, 'c+','markersize',15); %c+:마커 십자가, 마커 15 사이즈

I=imread('../image/rice.png');
figure(1); subplot(1,3,1); imshow(I);

%binarization by thresholding
Ib=I>150; 
figure(1); subplot(1,3,2); imshow(Ib);

%blob labeling
L=bwlabel(Ib,8);
figure(1); subplot(1,3,3); imagesc(L);
colormap jet;

%%

I=imread('../image/rice.png');
figure(1); subplot(1,2,1); imshow(I);

%binarization by thresholding
Ib=I>150; 
figure(1); subplot(1,2,2); imshow(Ib);


%blob labeling
L=bwlabel(Ib,8);
figure(2); imagesc(L);
colormap jet; colorbar

I=imread('../image/breast.tif');
figure(1); imshow(I); title('Original');

%intensity transform
tic
It=255-I;
figure(2); imshow(It); title('Negative');
toc

%intensity transform: C-style
tic
[H W]=size(I); %H=높이, W=너비 %default : double
Ig=zeros(H,W);
for i=1:H
    for j=1:W
        r=I(i,j);
        s=255-r;
        Ig(i,j)=s;
    end
end
figure(3); imshow(uint8(Ig)); title('Negative: C-style'); %uint8로 바꾸어 줌. 아니면 imagesc하면 자동 스케일 해줌
toc

%% log transform
I=imread('../image/Fourier.tif');
figure(4); imshow(I); title('Original');

Ilog=log(double(I+1)); %log transform %log는 uint 안됨 %+1shifting
max(Ilog(:));
figure(5); imagesc(Ilog); title('log transform');
colormap gray; colorbar;

Ilog2=uint8(Ilog/max(Ilog(:))*255); %data 최대값 1 * 255 하면 255 , Ilog/max(Ilog(:))가 scaling부분
figure(6); imshow(Ilog2); title('log transform2'); colorbar;

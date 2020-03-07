%dark image histogram
I=imread('../image/dark.tif');
figure(1); imshow(I);

h=histogram(I(:),0:255); % 영상 I를 행렬화 후 밝기 0~255까지 그려줌

%%
%h = 

%  Histogram - 속성 있음:

%             Data: [1042441×1 uint8]
%           Values: [1×255 double]
%          NumBins: 255
%        BinEdges: [1×256 double]
%         BinWidth: 1
%       BinLimits: [0 255]
%    Normalization: 'count'
%        FaceColor: 'auto'
%        EdgeColor: [0 0 0]
%
%%
[h b]=hist(I(:),0:255) % h가 bin 값, b는 실제 index
%figure(2); plot(0:255,h.Values);
figure(2); plot(b,h); % x축이 가로축, y가 실제 count한 값

%%
%light image histogram
I=imread('../image/light.tif');
figure(3); imshow(I);
[h b]=hist(I(:),0:255); 
figure(4); bar(b,h); %plot 대신에 bar를 쓰면 짝대기로 나옴

clc;
%%
I=imread('../image/light.tif');
Ih=myhisteq(I);
figure(3); imshow(Ih);

%%
I=imread('../image/light.tif');
[ M, N ] = size(I);

for i=1:10 % Input image의 최대밝기 조사
    for j=1:10
        I(i,j)
        I(i,j)+1
    end
end
Ic=imread('../image/bts.jpg');
figure(1); imshow(Ic);
I=rgb2gray(Ic); %gray=(r+g+b)/3
figure(2); imshow(I);

w=ones(13,13)/(13*13);
G=imfilter(I,w,0); %image padding -> 0
figure(3); imshow(G); title('Filtered');

G2=imfilter(I,w,'symmetric'); %image padding -> replicate padding
figure(4); imshow(G2); title('Filtered2');

%% add noise

n=30*randn(size(I));
figure; imagesc(n);
colormap gray; colorbar;

hist(n(:)); % 1차원 vector
hist(n(:),200); % bin 값이 작아서 많이 넣어줌
std(n(:)) % 노이즈 레벨 표준편차(std)
mean(n(:)) % 노이즈 평균

in=uint8(double(I)+n); %노이즈 때문에 음의 값 받아서 uint8 해줌 0이하는 0으로 맞춰줌
 %uint8(I)이랑 안 맞아서 바꿔줌
figure(3); imshow(in); title('Noisy image');

%% averaging filter
w=ones(5,5)/(5*5); % 숫자 적을 수록 더 선명해짐
G=imfilter(I,w,'replicate','same'); %image padding하고 유효한 값(padding 부분) 없애고 싶으면 'same'
figure(4); imshow(G); title('Averaged Image');

w=[-1 0 1,
    -1 0 1,
    -1 0 1]; 
G=imfilter(I,w,'replicate','same'); 
figure(4); imshow(G); title('Filtered');

w=rand(3,3);  %양수만 rand
G=imfilter(I,w,'replicate','same'); 
figure(4); imshow(G); title('Filtered');

w=randn(3,3);  %음수도 rand
G=imfilter(I,w,'replicate','same'); 
figure(4); imshow(G); title('Filtered');
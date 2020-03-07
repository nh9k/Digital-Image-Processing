I=imread('../image/rice.png');

% noise removal
figure(20); imshow(I); title('Original');

%add noise
Noise=50*randn(size(I)); %표준편차 1임 그래서 *50
figure(21); imagesc(Noise); colormap gray; colorbar;

Inoise=uint8(double(I)+Noise); % -영상이 나올수도 있음 --> uint,, double로 정수를 맞춰줘야함
figure(22); imshow(Inoise);

%%noise sequence
N=100; % number of frames(images) %n개 노이즈영상을 더해줄꼬임 %N 클수록 거의 노이즈 없게 나옴 %별찰영할때
L=50; % noise level
gray= double(repmat(I,[1 1 N])); %repeat matrix %가로 세로 세로로 N번 반복 %영상 double로 해야 계산 쉬움
%size(gray)
noise=L*randn(size(gray)); %noise sequence
grayNoise=uint8(gray+noise);

%noise removal by sample mean
grayNoiseRemoval=uint8(mean(grayNoise,3)); %3번째 channel로만 뿌림??
figure(23); imshow(grayNoiseRemoval);
title('Noise removed');



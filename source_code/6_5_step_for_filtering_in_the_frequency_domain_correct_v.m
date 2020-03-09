% 1. 이미지 사이즈 측정후 2M, 2N 값 찾기
I = imread('../image/myimg.jpg'); % 이미지 불러오기
I = rgb2gray(I); % 흑백화
I = im2double(I); % 더블, 스케일링
[m,n] = size(I); % 내 사진의 사이즈 측정
I2 = zeros(2*m,2*n); % 내 사진 2배의 공간 할당

% 2. Form padded image 0채우기 
[p,q] = size(I2);
% for문 돌려서 내사진 넣고 나머지 0으로 채우기
for i = 1:p
    for j = 1:q
        if i <= m && j<= n
            I2(i,j) = I(i,j);
        else
            I2(i,j) = 0;
        end
    end
end

figure(1); subplot(3,3,1);imshow(I);title('original image');

subplot(3,3,2);imshow(I2);title('Padded image (fp)');
Im = zeros(p,q);
% 3. Multiplying the padded image with (-1)^(x+y)
% 패딩된 이미지에 (-1)^(x+y) 곱하기 center its transform
for i = 1:p
    for j = 1:q
        Im(i,j) = I2(i,j).*(-1).^(i + j);
    end
end
subplot(3,3,3);
imshow(Im);title('Multiplying by (-1)x+y');

% 4. DFT image 이미지를 퓨리에 한다.
ImFft = fft2(Im); % multiplying 한 이미지를 퓨리에한다.
subplot(3,3,4);imagesc(log(1+abs(ImFft))); % 밝게 보려고 log화 하기
colormap gray; title('Fp');

% 5. H 필터 만들기 // Generate a real, symmetric filter func
H = fspecial('gaussian',[898 688],50); %fspecial func으로 가우시안 필터를 만듬.
% 이미지 크기를 2배 패딩한 이미지 사이즈와 맞춘다.
% 분산값에 따라 output 결과 이미지가 달라진다.

subplot(3,3,5);imagesc(abs(H));title('H: centered LPF'); % 이미지 뿌립니다.

% 6. H 필터와 퓨리에 내 이미지를 곱한다. G = H.*F
G = ImFft.*H;
subplot(3,3,6);
imshow(G);title('HFp');

% 7. Obtain the processed image / 처리된 이미지 얻기.
gin = real(ifft2(G)); % 실수부분을 inverse fourier transform 한다
%subplot(3,3,7);
%imagesc(g); colormap gray;
%title('gp');

% 실수부분의 inverse 퓨리에값에 multiply 했었던 것도 되돌린다.
% for문으로 .*((-1).^(i+j)) 곱해준다
g = zeros(p,q);
for i = 1:p
    for j = 1:q
        g(i,j) = gin(i,j).*((-1).^(i+j));
    end
end
subplot(3,3,7);
imagesc(g);title('gp');

% 8. 처음 2배로 패딩한 값들을 다시 날리고
% 기존 크기의 이미지를 얻는다.
out = zeros(m,n);
for i = 1:m
    for j = 1:n
        out(i,j) = g(i,j);
    end
end
subplot(3,3,8);
imagesc(out);title('output image'); truesize; axis image;

figure(2); subplot(1,3,1); imshow(I); title('input');
subplot(1,3,2); imagesc(abs(H)); axis image; title('H-filter');
subplot(1,3,3); imagesc(out); axis image; title('output');

figure(3); subplot(1,3,1); imshow(I); title('input');
subplot(1,3,2); imshow(G);  title('G(u,v)=HF');
subplot(1,3,3); imagesc(out); axis image; title('output, g(x,y)');

% 1. input (f) MxN
f=imread('../image/myimg.png');
f=rgb2gray(f);
figure(1); imshow(f); title('input (f) MxN');

% 2. Padded image(fp) 2Mx2N
[M,N]=size(f);
Padded_img = zeros(2*M,2*N); % 초기화
for i=1:M
    for j=1:N
            Padded_img(i,j) = f(i,j); % 할당된 곳 제외하고는 zero padding
    end
end
figure(2); imshow(uint8(Padded_img)); title('Padded image(fp) 2Mx2N');

% 3. Multiplying by (-1)^x+y
center=zeros(2*M,2*N); 
for i=1:2*M
    for j=1:2*N        
         center(i,j)=Padded_img(i,j).*((-1).^(i+j)); % 저주파 대역으로 나타냄
    end
end
figure(3); imshow(uint8(center)); title('Multiplying by (-1)^x*(-1)^xy');

% 4. Fp : compute DFT 
F=fft2(center);  Fcenter=fftshift(F); %원점을 중간으로 옮기는 변환 함수
magF=abs(Fcenter); % real와 imaginaly의 크기
figure(4); imagesc(log(1+magF)); title('Spectrum of Fp'); colormap gray;  axis image;

% 5. H : centered LPF
[M,N]=size(F);
u=0:(M-1); v=0:(N-1); % 벡터 생성 
u=u-M/2; v=v-N/2; % 중심 맞춰줌
[V, U]=meshgrid(v, u);
D=sqrt(U.^2+V.^2); % 모든 픽셀마다 중심으로 부터 거리 계산하는 D
P=5; % Cut-off frequency
H = double(D<=P); % 만족하면 1 아니면 0 나오는 logical data를 double data로 변환
figure(5); imagesc(H); title('H : centered LPF');  colormap gray;  axis image;

% 6. H*Fp
G =H.*F;
magG=abs(G);
figure(6); imagesc(log(1+magG)); title('H*Fp'); colormap gray;  axis image;

% 7. Processed image
g=real(ifft2(G)).*((-1).^(i+j));
% g=real(ifft2(double(ifftshift(G))));
figure(7); imshow(uint8(g)); title('gp');

% 8. Obtain the final processed result
[M,N]=size(f);
result= zeros(M,N);
for i=1:M
    for j=1:N
        result(i,j)=g(i,j);
    end
end
figure(8); imshow(uint8(result)); title('Final : croping 1st MxN');

% 9. Compare - space domain filtering(Unsharp Masking)
w=fspecial('gaussian', [5 5],1); 
Ib=imfilter(f,w,'same', 'replicate');
Is=f+(f-Ib); % k =1 : unsharp masking
figure(9); imshow(Is); title('Compare with space domain - unsharp masking');

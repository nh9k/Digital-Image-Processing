%% Lab 4-2 Implement imfilter
% original image
my_img=imread('../image/myimg.jpg');
figure; subplot(1,4,1); imshow(my_img); title('Original Image');

% Lab 4-1
% Add Gaussian noise
n=randn(size(my_img))*20;
noised_Img=uint8(double(my_img)+n);
lst=find(noised_Img<0); noised_Img(lst)=0;
lst=find(noised_Img>255); noised_Img(lst)=255;
subplot(1,4,2); imshow(noised_Img); title('Noisy Image');

% zero padding
[row col,dim] = size(my_img); % dim : rgb
pad_Img = zeros(row,col,dim); 
pad_size=10; %padding size
for k=1:dim
    for i=1+(pad_size/2):row+(pad_size/2)
        for j=1+(pad_size/2):col+(pad_size/2)
            pad_Img(i,j,k) = my_img(i-(pad_size/2),j-(pad_size/2),k);
        end
    end
end

% averaging filter
w=ones(5,5)/25;
% result of Lab4-1
Ir=imfilter(noised_Img,w,'same','replicate');
subplot(1,4,3); imshow(Ir); title('built-in Averaged Image');

% filtering
filtered_Img = zeros(row,col,dim);
for k=1:dim
    for i=1:row
        for j=1:col
            Temp = pad_Img(i+(pad_size/2),j+(pad_size/2),k).*w;
            filtered_Img(i,j,k) = sum(sum(Temp));
        end
    end
end
subplot(1,4,4); imshow(uint8(filtered_Img)); title('my Averaged Image');
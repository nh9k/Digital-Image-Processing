% Nearest Neighbor interpolation
%% REFERENCE
% USING FOR LOOP
% https://www.giassa.net/?page_id=207

% NO FOR LOOP
% https://www.imageeprocessing.com/2017/11/nearest-neighbor-interpolation.html

%%
function output_img = myResizeNN(input_img,scale,fig)

% read an image
img=imread(input_img);

% gray
gray_img=rgb2gray(img);

% image size
[row,col]=size(gray_img);

% resize image
resize_row=round(row*scale);
resize_col=round(col*scale);

% round «ÿ¡ÿ scale
scale_row=resize_row/row;
scale_col=resize_col/col;

% zeros : √ ±‚»≠
output_img=zeros(resize_row, resize_col);

% interpolation
for i= 1: resize_row
    for j= 1: resize_col
        new_row = round(i/scale_row);
        new_col = round(j/scale_col);
        output_img(i,j) = gray_img(new_row, new_col);
    end
end

%figure image
figure(fig); imshow(uint8(output_img));
title(['NN interpolation / scale : ' num2str(scale)]); 
xlabel('±Ë≥≠»Ò');
end
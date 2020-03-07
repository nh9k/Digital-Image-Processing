% Bilinear interpolation
%% REFERENCE
% https://kr.mathworks.com/matlabcentral/answers/297921-the-bilinear-interpolation-embedded-matlab-function-vs-bilinear-interpolation-re-written-or-coded
%%

function output_img = myResizeBil(input_img,scale,fig)

% read an image
input_img=imread(input_img);

% gray
gray_img=rgb2gray(input_img);

% image size
[row,col]=size(gray_img);

% resize image
resize_row=ceil(row*scale);
resize_col=ceil(col*scale);

% round 해준 scale
scale_row=resize_row/row;
scale_col=resize_col/col;

% zeros : 초기화
output_img=zeros(resize_row, resize_col);

%interpolation
for i=1:resize_row
    for j=1:resize_col
        new_row=round(i/scale_row);
        new_col=round(j/scale_col);
        % 여기서부터 NN Interpolation 과 다름
        if(new_row==row)
            new_row=row-1;
        end
        if(new_col==col)
            new_col=col-1;
        end
        
        % 더 가까운 곳을 이용하기 위한 변수
        a = i/scale_row - new_row;
        b = j/scale_col - new_col;
        
        % Pixel 4가지 점 할당
        P00 = gray_img(new_row, new_col);
        P01 = gray_img(new_row, new_col+1);
        P10 = gray_img(new_row+1, new_col);
        P11 = gray_img(new_row+1, new_col+1);
        
        % 가중치를 주어 계산 % 가로축 interpolation
        PW_TOP = P00 + a*(P01-P00);
        PW_BOTTOM = P10 + a*(P11-P10);
        
        % 2차(세로축) interpolation
        var = PW_TOP + b*(PW_BOTTOM-PW_TOP);
        output_img(i,j) = var;
    end
end

%figure image
figure(fig); imshow(uint8(output_img));
title(['Bilinear interpolation / scale : ' num2str(scale)]); 
xlabel('김난희');
end
%%Lab 3-3

I=imread('light.tif'); 
I=rgb2gray(I); % gray image

%test Lab3-2
h1=imhist(I,256);
Ieq=histeq(I,256);
h2=imhist(Ieq,256);

%test Lab3-3
Ieq2=myhisteq(I);
h3=imhist(Ieq2,256);

figure; 
subplot(3,2,1); imshow(I), title('Original');
subplot(3,2,2); bar(h1), title('Histogram of Original');
subplot(3,2,3); imshow(Ieq), title('Histogram equalized');
subplot(3,2,4); bar(h2), title('Histogram of built-in');
subplot(3,2,5); imshow(Ieq2), title('My Histogram');
subplot(3,2,6); bar(h3), title('Histogram of mine');


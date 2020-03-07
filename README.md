# Digital_Image_Processing

These source code that summarizes the codes that I have gathered while attending Professor Sungho Kim's class (Yeungnam University, computer vision class) and my personal studies.

## 0. Outline
all of index have matlab code but some index have no result

[1. Install Matlab](#1-install-matlab)
1.1 Basic Matrix
2. Image resolution
[2.1. Image Resize with Interpolation](#21-image-resize-with-interpolation) 
[3. Blob Labeling](#3-blob-labeling)   
3.1. Noise Reduction
4. Intensity Transform
[4.1 Histogram equalization](#41-histogram-equalization)
[5. Spatial Filtering](#5-spatial-filtering)
[5.1. Spatial Sharpening](#51-spatial-sharpening) 
6. Furier Series
[6.1. Aliasing in Image Resizing](#61-aliasing-in-image-resizing)  
[6.2 2-D DFT Fourier Spectrum](#62-2d-dft-fourier-spectrum)
[6.2 2-D DFT Fourier Phase Angle](#62-2d-dft-fourier-phase-angle)
[7. ](#7-)  
[8. ](#8-)  
[9. ](#9-)  
[10. ](#10-)  

## 6.3 2-D DFT Fourier Phase Angle

## 1. Install Matlab

- Install Matlab
- read Image and show

```
Image=imread('want_to_read.jpg');
imshow(Image);
title('want_to_read','fontsize',16);
```

[Go 0. Outline](#0-outline)  

## 1.1 Basic Matrix  

## 2. Image resolution  

## 2.1 Image Resize with Interpolation

```
%builtin function

Image=imread('rice.png'); %load an gray image

Image_NN=imresize(Image,0.4,'nearest');
Image_BL=imresize(Image,0.4,'bilinear');
Image_BC=imresize(Image,0.4,'bicubic');

subplot(1,4,1); imshow(Image); title('origin');
subplot(1,4,2); imshow(Image_NN); title('NN');
subplot(1,4,3); imshow(Image_BL); title('bilinear');
subplot(1,4,4); imshow(Image_BC); title('bicubic');
```

|Result|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76141816-1f5bb780-60ab-11ea-927d-89a724c3a2bb.jpg" width="" height="">|

my impletation(resize func) is in directory `source_code/myResizeNN or myResizeBil`  

[Go 0. Outline](#0-outline)   

## 3. Blob Labeling

|Result 1|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147170-e4727780-60dc-11ea-8b74-5441e2b9b239.PNG" width="100%" height="50%">|

|Result 2|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147171-e5a3a480-60dc-11ea-84a2-3c3d541e2362.PNG" width="" height="">|

[Go 0. Outline](#0-outline) 

## 3.1. Noise Reduction

## 4. Intensity Transform

## 4.1 Histogram equalization

|Result|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147140-80e84a00-60dc-11ea-8722-a3736c6fb8f3.png" width="" height="">|

[Go 0. Outline](#0-outline)

## 5. Spatial Filtering

|Result 1|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147487-0c170f00-60e0-11ea-8414-34a7c3218a79.png" width="" height="">|

|Result 2|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147604-4b922b00-60e1-11ea-9034-2d05244e156a.png" width="" height="">|

|Result 3|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147605-4c2ac180-60e1-11ea-879d-b1c348b9cf61.png" width="" height="">|

[Go 0. Outline](#0-outline)

## 5.1. Spatial Sharpening

|Logic|Input|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76148015-8b5b1180-60e5-11ea-9b36-3ac62d3c6456.png" width="100%" height="70%">|<img src="https://user-images.githubusercontent.com/56310078/76147776-1f77a980-60e3-11ea-8619-62bc1e65ab71.png" width="" height="">|


- Laplacian kernel

```
K=[0 1 0;
   1 -4 1;
   0 1 0]
```

|before shapen|Result 1|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147777-20a8d680-60e3-11ea-9a1a-d2050b18f9c4.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76147779-21da0380-60e3-11ea-8ed2-a77df026f904.png" width="" height="">|

- Laplacian kernel

```
K=[1 1 1;
   1 -8 1;
   1 1 1]
```

|before shapen|Result 2|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147780-22729a00-60e3-11ea-85e4-a3b2e0dd43d4.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76147782-23a3c700-60e3-11ea-96b5-5da051b8e698.png" width="" height="">|

- Gaussian kernel

```
K=fspecial('gaussian',[5,5],1)
```

|Kernel|Result 3|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147783-24d4f400-60e3-11ea-854e-f255af023fd8.png" width="90%" height="90%">|<img src="https://user-images.githubusercontent.com/56310078/76147785-26062100-60e3-11ea-965f-47d6039df097.png" width="" height="">|

[Go 0. Outline](#0-outline)

## 6. Furier Series

- make sine waves
- combine each sine waves
- sine waves to square waves

## 6.1. Aliasing in Image Resizing

- same subsampling

|Input|Otput|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76149912-07eeef80-60e8-11ea-84c4-bb50a6be64c1.png" width="300" height="300">|<img src="https://user-images.githubusercontent.com/56310078/76149909-045b6880-60e8-11ea-81ca-a46694865542.png" width="300" height="300">|

## 6.2 2-D DFT Fourier Spectrum

|Result|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76150168-bd22a700-60ea-11ea-85c8-443e354731fc.png" width="" height="">|

## 6.3 2-D DFT Fourier Phase Angle

|Result|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76150247-9022c400-60eb-11ea-834d-40c4d4ea2f3e.png" width="" height="">|


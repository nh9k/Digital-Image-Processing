# Digital_Image_Processing

These source code that summarizes the codes that I have gathered while attending Professor Sungho Kim's class (Yeungnam University, Digital Image Processing class) and my personal studies.

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
[6. Furier Series](#6-furier-series)  
[6.1. Aliasing in Image Resizing](#61-aliasing-in-image-resizing)  
[6.2 2-D DFT Fourier Spectrum](#62-2-d-dft-fourier-spectrum)  
[6.3 Phase Angles and The Reconstructed](#63-phase-angles-and-the-reconstructed)    
6.4. Frequency Analysis  
[6.5. Steps for Filtering in the Frequency Domain](#65-steps-for-filtering-in-the-frequency-domain)  
6.6. Image Low Pass Filter & High Pass Filter  
[7. Deep learning](#7-deep-learning)  


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
|<img src="https://user-images.githubusercontent.com/56310078/76147170-e4727780-60dc-11ea-8b74-5441e2b9b239.PNG" width="100%" height="80%">|

|Result 2|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76147171-e5a3a480-60dc-11ea-84a2-3c3d541e2362.PNG" width="90%" height="90%">|

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

[Go 0. Outline](#0-outline)

## 6.1. Aliasing in Image Resizing

- same subsampling

|Input|Output|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76149912-07eeef80-60e8-11ea-84c4-bb50a6be64c1.png" width="300" height="300">|<img src="https://user-images.githubusercontent.com/56310078/76149909-045b6880-60e8-11ea-81ca-a46694865542.png" width="300" height="300">|

[Go 0. Outline](#0-outline)

## 6.2. 2-D DFT Fourier Spectrum

|Result|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76150168-bd22a700-60ea-11ea-85c8-443e354731fc.png" width="" height="">|

[Go 0. Outline](#0-outline)

## 6.3. Phase Angles and The Reconstructed

my implement code: doesn't exist. The report exists.
but upload the correct code

|Result|
|---|
|<img src="https://user-images.githubusercontent.com/56310078/76150247-9022c400-60eb-11ea-834d-40c4d4ea2f3e.png" width="" height="">|

[Go 0. Outline](#0-outline)

## 6.4. Frequency Analysis

## 6.5. Steps for Filtering in the Frequency Domain

1. Given an input image f(x,y) of size MxN, obtain thepadding parameters P and Q : Output1
2. Form a padded image, fp(x,y) of size PxQ by appending the necessary number of zeros to f(x,y): Output2
3. Multiply fp(x,y) by (-1)x+y to center its transform: Output3

|Input|Output1|Output2|Output3|
|---|---|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76189838-fb20e780-621e-11ea-9206-39cb366611bd.PNG" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76189847-01af5f00-621f-11ea-9a93-94602cf433f8.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76189851-03792280-621f-11ea-99a2-f7d7eae61a23.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76189855-0542e600-621f-11ea-959c-bf0d6a1ce223.png" width="" height="">|

4. Compute the DFT, F(u,v) of the image from step 3: Output4
5. Generate a real, symmetric filter function*, H(u,v), of size PxQ with center at coordinates (P/2, Q/2): Output5
6. Form the product G(u,v) = H(u,v)F(u,v) using array multiplication: Output6
7. Obtain the processed image 
<img src="https://user-images.githubusercontent.com/56310078/76190943-87cca500-6221-11ea-88ab-b9bc1b2b701c.JPG" width="300" height=""> : Output7


|Output4|Output5|Output6|Output7|
|---|---|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76189860-06741300-621f-11ea-9036-ca00de476d43.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76189862-08d66d00-621f-11ea-8f7c-4249ed5aceb3.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76189867-0a079a00-621f-11ea-80ce-71903c37d2d4.png" width="" height="">|<img src="https://user-images.githubusercontent.com/56310078/76189872-0c69f400-621f-11ea-8ac8-5617cc644026.png" width="" height="">|

8. Obtain the final processed result, g(x,y), by extracting the MxN region from the top, left quadrant of gp(x,y)
- Cut-off Frequency 200: Output8  
- Cut-off Frequency 100: Output9  
- Cut-off Frequency 5: Output10  

|Output8|Output9|Output10|
|---|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76189876-0ecc4e00-621f-11ea-800b-9bce47c859f5.png" width="300" height="300">|<img src="https://user-images.githubusercontent.com/56310078/76189882-10961180-621f-11ea-9eb8-26da4bd88316.png" width="300" height="300">|<img src="https://user-images.githubusercontent.com/56310078/76189883-11c73e80-621f-11ea-81a9-1d280bef94b5.png" width="300" height="300">|

9. Space domain filtering(Output11) vs Frequency domain filtering(Output12)

|Output11|Output12|
|---|---|
|<img src="https://user-images.githubusercontent.com/56310078/76189888-14c22f00-621f-11ea-8bf5-7746560aa7b9.png" width="300" height="300">|<img src="https://user-images.githubusercontent.com/56310078/76189892-168bf280-621f-11ea-9f73-7d971d70d72c.png" width="300" height="300">|

[Go 0. Outline](#0-outline)

## 6.6. Image Low Pass Filter & High Pass Filter

## 7. Deep learning

- exercise 1: Object Detection
<img src="https://user-images.githubusercontent.com/56310078/76191922-cbc0a980-6223-11ea-906b-5594d7b2dd27.png" width="300" height="300">

- exercise 2: Regression, Estimating real number given vector data
<img src="https://user-images.githubusercontent.com/56310078/76192039-2a862300-6224-11ea-8429-2c5fd567ab5f.png" width="300" height="300">

- exercise 3: Transfer Learning using Alexnet
Introduce my project Demo video --> [[link]](https://blog.naver.com/kimnanhee97/221835564645)

[Go 0. Outline](#0-outline)

## Image Source

searching at matlab, nanhee kim's and sungho kim class

myimg: nanhee kim  
others: matlab and prof.sungho kim

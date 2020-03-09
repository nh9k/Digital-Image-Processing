% https://kr.mathworks.com/help/vision/examples/object-detection-using-deep-learning.html
% Download CIFAR-10 Image Data
cifar10Data = tempdir;
url = 'https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz';
addpath(fullfile(matlabroot,'examples', 'vision', 'main'));
helperCIFAR10Data.download(url,cifar10Data);

% Load the CIFAR-10 training and test data.
[trainingImages,trainingLabels,testImages,testLabels] = helperCIFAR10Data.load(cifar10Data);
% Each image is a 32x32 RGB image and there are 50,000 training samples.
size(trainingImages)

% CIFAR-10 has 10 image categories. List the image categories:
numImageCategories = 10;
categories(trainingLabels)

%Display a few of the training images.
figure
thumbnails = trainingImages(:,:,:,1:100);
montage(thumbnails)

% Create the image input layer for 32x32x3 CIFAR-10 images
[height, width, numChannels, ~] = size(trainingImages);

imageSize = [height width numChannels];
inputLayer = imageInputLayer(imageSize)

% Convolutional layer parameters
filterSize = [5 5]; % [3 3]으로 해도 됨 
numFilters = 32; % training data 별로 없으면 크게하면 안됨 보통 3x3->10개 필터개수

middleLayers = [ % 실제 convolution
    
% The first convolutional layer has a bank of 32 5x5x3 filters. A
% symmetric padding of 2 pixels is added to ensure that image borders
% are included in the processing. This is important to avoid
% information at the borders being washed away too early in the
% network.
convolution2dLayer(filterSize, numFilters, 'Padding', 2)
  % 공간해상도가 입력과 같음. % 입력영상과 해상도 같음. % 단지 채널 32개
% Note that the third dimension of the filter can be omitted because it
% is automatically deduced based on the connectivity of the network. In
% this case because this layer follows the image layer, the third
% dimension must be 3 to match the number of channels in the input
% image.

% Next add the ReLU layer:
reluLayer() % 아래 보면 반복 됨

% Follow it with a max pooling layer that has a 3x3 spatial pooling area
% and a stride of 2 pixels. This down-samples the data dimensions from
% 32x32 to 15x15.
maxPooling2dLayer(3, 'Stride', 2) % 아래 보면 반복 됨

% Repeat the 3 core layers to complete the middle of the network.
convolution2dLayer(filterSize, numFilters, 'Padding', 2) % 아래 보면 반복 됨
reluLayer()
maxPooling2dLayer(3, 'Stride',2)

convolution2dLayer(filterSize, 2 * numFilters, 'Padding', 2) % 원래 저해상도인데 공간해상도 줄면서 채널은 커짐
reluLayer()
maxPooling2dLayer(3, 'Stride',2)

]

finalLayers = [ % 내가 필요한 레이어
    
% Add a fully connected layer with 64 output neurons. The output size of
% this layer will be an array with a length of 64.
fullyConnectedLayer(64) % 1차원 필터로 다 펴서 fully connected함 다 이어줌 weight

% Add an ReLU non-linearity.
reluLayer

% Add the last fully connected layer. At this point, the network must
% produce 10 signals that can be used to measure whether the input image
% belongs to one category or another. This measurement is made using the
% subsequent loss layers.
fullyConnectedLayer(numImageCategories) % 10개의 클래스가 들어감

% Add the softmax loss layer and classification layer. The final layers use
% the output of the fully connected layer to compute the categorical
% probability distribution over the image classes. During the training
% process, all the network weights are tuned to minimize the loss over this
% categorical distribution.
softmaxLayer % expenantial함
classificationLayer % 결국 필요한 것 뽑아냄
]

layers = [ % 레이어 이렇게 되어 있음 % 레이어 쳐보면 어떻게 구성되어 있는 지 보임
    inputLayer
    middleLayers
    finalLayers
    ]

% Set the network training options
opts = trainingOptions('sgdm', ... % 건들일거 몇 개 없음
    'Momentum', 0.9, ...
    'InitialLearnRate', 0.001, ... % w <- w-n*d, d <- 0.9d+dL/dw % 클수록 빨리 수렴. 원하는 값 가까이오면 왔다갔다 거림
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ... %0.001에서 10분의 1로 줄어듦
    'LearnRateDropPeriod', 8, ...
    'L2Regularization', 0.004, ...
    'MaxEpochs', 40, ... % training 데이터를 몇 번 돌릴 건지 30번 정도 돌면 0으로 감. 보통
    'MiniBatchSize', 128, ... % 128 샘플만 랜덤으로 구해서 에러 구함
    'Verbose', true);

% A trained network is loaded from disk to save time when running the
% example. Set this flag to true to train the network.
doTraining = false;

if doTraining    % 이제 학습함
    % Train a network.
    cifar10Net = trainNetwork(trainingImages, trainingLabels, layers, opts); % 이 이미지 set 넣으면 알아서 학습 % 이거 layer 보면 학습의 weight가 튜닝됨이 보임
else
    % Load pre-trained detector for the example.
    load('rcnnStopSigns.mat','cifar10Net')       
end

% Extract the first convolutional layer weights
w = cifar10Net.Layers(2).Weights;

% rescale the weights to the range [0, 1] for better visualization
w = rescale(w);

figure
montage(w)

% Run the network on the test set.
YTest = classify(cifar10Net, testImages); % 학습한 네트워크와 테스트 결과가 들어가 prediction 함

% Calculate the accuracy.
accuracy = sum(YTest == testLabels)/numel(testLabels) % 맞는 것만 보면 normalize 해서 정확성 보여줌

%% stop-sign detection
% Load the ground truth data
data = load('Fire.mat', 'Fire');
stopSignsAndCars = data.stopSignsAndCars;

% Update the path to the image files to match the local file system
visiondata = fullfile(toolboxdir('vision'),'visiondata');
stopSignsAndCars.imageFilename = fullfile(visiondata, stopSignsAndCars.imageFilename);

% Display a summary of the ground truth data
summary(stopSignsAndCars)

% Only keep the image file names and the stop sign ROI labels
stopSigns = stopSignsAndCars(:, {'imageFilename','stopSign'});

% Display one training image and the ground truth bounding boxes
I = imread(stopSigns.imageFilename{1});
I = insertObjectAnnotation(I,'Rectangle',stopSigns.stopSign{1},'stop sign','LineWidth',8);

figure
imshow(I)

% A trained detector is loaded from disk to save time when running the
% example. Set this flag to true to train the detector.
doTraining = false;

if doTraining
    
    % Set training options
    options = trainingOptions('sgdm', ...
        'MiniBatchSize', 128, ...
        'InitialLearnRate', 1e-3, ...
        'LearnRateSchedule', 'piecewise', ...
        'LearnRateDropFactor', 0.1, ...
        'LearnRateDropPeriod', 100, ...
        'MaxEpochs', 100, ...
        'Verbose', true);
    
    % Train an R-CNN object detector. This will take several minutes.    
    rcnn = trainRCNNObjectDetector(stopSigns, cifar10Net, options, ...
    'NegativeOverlapRange', [0 0.3], 'PositiveOverlapRange',[0.5 1])
else
    % Load pre-trained network for the example.
    load('rcnnStopSigns.mat','rcnn')       
end

% Read test image
testImage = imread('stopSignTest.jpg');

% Detect stop signs
[bboxes,score,label] = detect(rcnn,testImage,'MiniBatchSize',128) % 알아서 찾음 ROI


% Display the detection results
[score, idx] = max(score);

bbox = bboxes(idx, :);
annotation = sprintf('%s: (Confidence = %f)', label(idx), score);

outputImage = insertObjectAnnotation(testImage, 'rectangle', bbox, annotation);

figure
imshow(outputImage)

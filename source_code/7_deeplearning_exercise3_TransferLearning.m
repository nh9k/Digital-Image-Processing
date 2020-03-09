%% Load Data
unzip('MerchData.zip');
imds = imageDatastore('MerchData', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames'); % 폴더 이름으로 가져오겠다. --> 우리가 만든 것 DB로 만들어 줌 

% Divide the data into training and validation data sets. Use 70% of the images for training and 30% for validation. splitEachLabel splits the images datastore into two new datastores.
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
numTrainImages = numel(imdsTrain.Labels);
idx = randperm(numTrainImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsTrain,idx(i));
    imshow(I)
end

% Load Pretrained Network
net = alexnet;

% The first layer, the image input layer, requires input images of size 227-by-227-by-3, where 3 is the number of color channels.
inputSize = net.Layers(1).InputSize

% Replace Final Layers
layersTransfer = net.Layers(1:end-3); % 처음에서 3칸만 빼서 우리꺼 넣음
numClasses = numel(categories(imdsTrain.Labels))

layers = [ % 앞에 있는 거 다 쓰면서 우리가 필요한 것만 가져옴
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

%% Train Network
% Data augmentation helps prevent the network from overfitting and memorizing the exact details of the training images.
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ... %10장을 넣어주면 1000장을 가져옴 : training data
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);

augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

netTransfer = trainNetwork(augimdsTrain,layers,options); % 학습 

% Classify validation images
[YPred,scores] = classify(netTransfer,augimdsValidation);
idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end

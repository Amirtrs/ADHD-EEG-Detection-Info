clc;
clear;
close all;

ParentDir = 'C:\Users\amirt\OneDrive\Desktop\ehsan\code\XWT';
dataDir = 'data';
Plotroot = fullfile(ParentDir, dataDir);

allImages = imageDatastore(fullfile(ParentDir, dataDir), ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames', 'ReadFcn', @customreader);

[trainImgs, valTestImgs] = splitEachLabel(allImages, 0.7, 'randomize');
[valImgs, testImgs] = splitEachLabel(valTestImgs, 0.5, 'randomize'); 

numClasses = 2;

net = resnet50;
lgraph = layerGraph(net);
lgraph = replaceLayer(lgraph, 'fc1000', fullyConnectedLayer(numClasses, 'Name', 'new_fc', ...
    'WeightLearnRateFactor', 10, 'BiasLearnRateFactor', 10));
lgraph = replaceLayer(lgraph, 'ClassificationLayer_fc1000', classificationLayer('Name', 'new_classoutput'));

options = trainingOptions('adam', ...
    'MiniBatchSize', 128, ...
    'MaxEpochs', 10, ...
    'InitialLearnRate', 1e-4, ...
    'ValidationData', valImgs, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.7, ... 
    'LearnRateDropPeriod', 3, ... 
    'ValidationFrequency', 100, ...
    'Verbose', false, ...
    'Plots', 'training-progress',...
    'ExecutionEnvironment', 'gpu');

trainedNet = trainNetwork(trainImgs, lgraph, options);

[YPred, probs] = classify(trainedNet, testImgs);
accuracy = mean(YPred == testImgs.Labels);

confMat = confusionmat(testImgs.Labels, YPred);

tp = confMat(1,1);
fn = confMat(1,2);
fp = confMat(2,1);
tn = confMat(2,2);

sensitivity = tp / (tp + fn);
specificity = tn / (tn + fp);
precision = tp / (tp + fp);
f1score = 2*tp / (2*tp + fp + fn);

[X, Y, T, AUC] = perfcurve(testImgs.Labels, probs(:,2), true);
figure;
plot(X, Y);
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curve');
saveas(gcf, 'ROC_Test.png');

close(gcf);

disp(['Accuracy: ', num2str(accuracy * 100), '%']);
disp(['Sensitivity: ', num2str(sensitivity * 100), '%']);
disp(['Specificity: ', num2str(specificity * 100), '%']);
disp(['Precision: ', num2str(precision * 100), '%']);
disp(['F1 Score: ', num2str(f1score * 100), '%']);
disp(['AUC: ', num2str(AUC)]);

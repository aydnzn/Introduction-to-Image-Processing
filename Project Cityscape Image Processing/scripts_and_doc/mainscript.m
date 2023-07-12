% Clearing Workspace: The command clear all clears all variables from the MATLAB workspace.
% Variable Initialization: The script initializes variables such as source_directory and dataset_list. The source_directory variable represents the directory path where the preprocessed images are located. The dataset_list variable stores information about the files in the source_directory.
% Data Loading: The script loads data from the file labels.txt using the importdata function. The data is stored in the labels variable.
% Feature Extraction: The script loops through each image in the dataset_list and performs the following steps:
% Read the current image.
% Preprocess the image by resizing, converting to grayscale, and applying histogram equalization.
% Perform two levels of 2D discrete wavelet transform (DWT) using the Haar wavelet.
% Extract features from the grayscale image using Histogram of Oriented Gradients (HOG) and Local Binary Patterns (LBP).
% Extract color histograms from the RGB channels of the image.
% Concatenate the extracted features to form current_features.
% Append current_features to features_end.
% SVM Model Training and Testing: An SVM model is trained using the fitcecoc function. The first 700 instances of features_end are used for training, and instances 701 to 800 are used for testing. The predicted labels and scores are obtained using the predict function. The accuracy of the model is calculated by comparing the predicted labels with the actual labels from the labels variable.
% Confusion Matrix: A confusion matrix is calculated using the confusionmat function. It compares the original labels with the predicted labels obtained from the SVM model.


clear all;
source_directory = './preprocessed_images/';
dataset_list = dir(source_directory);

data = importdata('labels.txt', ' ');
labels = data.data;
features_end = [];
cs = 48;







for i=3:length(dataset_list)
    image_name = dataset_list(i).name;
    image_path = strcat(source_directory, image_name);
    current_image = imread(image_path);
    fprintf(1, 'Now reading %s\n', image_name);
    
    %%%%%%%%
%     R_c = current_image(:,:,1);
% G_c = current_image(:,:,2);
% B_c = current_image(:,:,3);
% R_c = [mean(mean(R_c(1:floor(end/2),:))) mean(mean(R_c(floor(end/2)+1:end,:)))];
% G_c = [mean(mean(G_c(1:floor(end/2),:))) mean(mean(G_c(floor(end/2)+1:end,:)))];
% B_c = [mean(mean(B_c(1:floor(end/2),:))) mean(mean(B_c(floor(end/2)+1:end,:)))];
% TR = graythresh(R_c);
% TG = graythresh(G_c);
% TB = graythresh(B_c);
% meanColors = [R_c G_c B_c TR TG TB]/255;
% model = load('model.mat');
% C = model.C;
% histFeatures = model.histFeatures;
% testHist = zeros(1,size(C,1));
% img = rgb2gray(img);
% points = detectSURFFeatures(img);
% [features,validPoints] = extractFeatures(img, points.selectStrongest(300),'SURFSize',128);
% for k=1:size(features,1)
%     for r=1:size(C,1)
%         a(r) = sqrt(sum((features(k,:) - C(r,:)) .^ 2));
%     end
%     [M,I] = min(a);
%     testHist(I) = testHist(I)+1;
% end
% 
% feat = testHist/sum(testHist);
% feat = [feat meanColors];
    
    
    current_image=imresize(current_image,[512 512]);
    
    current_image_gray = rgb2gray(current_image);
    current_image_gray = adapthisteq(current_image_gray,'NumTiles',[8 8],'ClipLimit',0.01,'Distribution','uniform');
   [cA,cH,cV,cD] = dwt2(current_image_gray,'haar') ;
   [cA,cH,cV,cD] = dwt2(cA,'haar') ;


   [m n] = size(cA);
cH_dik = reshape(cH,1,m*n);
cV_dik = reshape(cV,1,m*n);
cD_dik = reshape(cD,1,m*n);

    [hog_features_gray, visualization_gray] = extractHOGFeatures(current_image_gray, ...
        'CellSize', [cs cs]);
    
% E=hog_features_gray.^2;
% Energy=(sum(E(:)))/(512*512);







% features = [mean(hog_features_gray(:)),var(hog_features_gray(:)),skewness(hog_features_gray(:)),kurtosis(hog_features_gray(:)),entropy(double(hog_features_gray(:))),Energy];

features_lbp_gray = extractLBPFeatures(current_image_gray,'CellSize', [cs cs]);
% E_lbp=features_lbp_gray.^2;
% Energy_lbp=(sum(E_lbp(:)))/(512*512);
% features_lbp = [mean(features_lbp_gray(:)),var(features_lbp_gray(:)),skewness(features_lbp_gray(:)),kurtosis(features_lbp_gray(:)),entropy(double(features_lbp_gray(:))),Energy_lbp];

    %%%%%%%%
    
    red   = current_image(:,:,1);
    green = current_image(:,:,2);
    blue  = current_image(:,:,3);
    hist_red   = single(imhist(red));
    hist_green = single(imhist(green));
    hist_blue  = single(imhist(blue));
    color_histogram = [hist_red;hist_blue;hist_green];
    
    [hog_features, visualization] = extractHOGFeatures(current_image, ...
        'CellSize', [cs cs]);
    


    %%%

   % color_histogram.'
   % cH_dik,cV_dik,cD_dik
   % hog_features
    %%%%
    current_features = [hog_features_gray, features_lbp_gray];
    features_end = [features_end; current_features];
end

fprintf(1, 'Now training the network\n'); % fitcecoc
multiclass_svm_model = fitcecoc(features_end(1:700,:), labels(1:700,:));
fprintf(1, 'Now testing the network\n');
[predicted_labels,score] = predict(multiclass_svm_model, features_end(701:800,:));
accuracy_safe = length(find(data.data(701:800) == predicted_labels))/100;
fprintf(1, 'The accuracy is %d\n', accuracy_safe);


original_labels = data.data(701:800);
conf = confusionmat(original_labels,predicted_labels);

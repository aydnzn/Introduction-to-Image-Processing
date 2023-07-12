% Clearing Workspace: The command clear clears all variables from the MATLAB workspace.
% Variable Initialization: Several variables are initialized with image IDs for different categories such as "safe," "lively," "boring," "wealthy," "depressing," and "beautiful." These IDs are assigned as strings.
% Data Loading: The script loads various data from MAT files. This includes image names, image IDs, study IDs, score IDs, safe scores, and wealthy scores. These variables are read from the respective MAT files using the matfile function.
% Color Features Loading: The script loads color features from a MAT file named 'color_features_9710_108.mat'. The loaded color features are stored in the variable colour_features_end.
% GIST Features Loading: The script loads GIST features from a MAT file named 'gist_features.mat'. The loaded GIST features are stored in the variable gist_features_end.
% Feature Normalization: The GIST features and color features are individually normalized using min-max normalization. The minimum and maximum values for each feature set are calculated, and then the normalization is performed using the formula (x - min(x)) / (max(x) - min(x)). The normalized features are stored in features_end.
% Binary Score Conversion: The safe scores and wealthy scores are converted into binary values based on a threshold. If a score is greater than 23, it is assigned a binary value of 1; otherwise, it is assigned 0. The conversion is done using two separate loops for safe and wealthy scores.
% Looping through Images: The script loops through each image in the dataset and performs the following steps:
% Read the current image.
% Extract sub-images from the current image.
% Compute GIST features for each sub-image using the LMgist function.
% Concatenate the GIST features to form current_features.
% Append current_features to features_end.
% SVM Model Training and Testing: Two SVM models are trained and tested using the fitcsvm function. One model is trained for safe classification, and the other is trained for wealthy classification. The first 2000 instances of features_end are used for training, and instances 2001 to 2100 are used for testing. The predicted labels and scores are obtained using the predict function. The accuracies of the models are calculated by comparing the predicted labels with the actual binary scores.
% Confusion Matrix: A confusion matrix is calculated using the confusionmat function. It compares the original labels (binary safe scores) with the predicted labels obtained from the SVM model.


clear;
safe_yes = "50a68a51fdc9f05596000002";
lively_yes = "50f62c41a84ea7c5fdd2e454";
boring_yes ="50f62c68a84ea7c5fdd2e456";
wealthy_yes = "50f62cb7a84ea7c5fdd2e458";
depressing_yes = "50f62ccfa84ea7c5fdd2e459";
beautiful_yes = "5217c351ad93a7d3e7b07a64";
source_directory = './preprocessed_small_dataset/';
A =dir( fullfile(source_directory, '*.JPG') );
number_of_img = length(A);

image_names_array_read_matrix = matfile('image_names_in_dataset.mat');
image_names_array = image_names_array_read_matrix.image_names_array;
image_ids_read_matrix = matfile('image_ids_in_qscores_file.mat');
image_ids = image_ids_read_matrix.image_ids;
study_ids_read_matrix = matfile('study_ids_in_qscores_file.mat');
study_ids = study_ids_read_matrix.study_ids ;
score_ids_read_matrix = matfile('scores_in_qscores_file.mat');
score_ids = score_ids_read_matrix.score_ids;
safe_scores_read_matrix = matfile('safe_scores.mat');
safe_scores = safe_scores_read_matrix.safe_scores;
wealthy_scores_read_matrix = matfile('wealthy_scores.mat');
wealthy_scores = wealthy_scores_read_matrix.wealthy_scores;

color_features_read_matrix = matfile('color_features_9710_108.mat');
colour_features_end = color_features_read_matrix.colour_features;

gist_features_read_matrix = matfile('gist_features.mat');
gist_features_end = gist_features_read_matrix.train_features;



    
minGist = min(min(gist_features_end));
maxGist = max(max(gist_features_end));
normGist = (gist_features_end - minGist) / ( maxGist - minGist );

minColor = min(min(colour_features_end));
maxColor = max(max(colour_features_end));
normColor = (colour_features_end - minColor) / ( maxColor - minColor );

% current_features = gist_features;
features_end = [];
features_end = [ normGist]; %, gist_features_end ];

number_of_img = length(safe_scores);
binary_safe_scores = zeros(number_of_img,1);
for i = 1 : number_of_img
    if safe_scores(i) > 23
       binary_safe_scores(i) = 1; 
    else
        binary_safe_scores(i) = 0;
    end     
end
binary_wealthy_scores = zeros(number_of_img,1);
for i = 1 : number_of_img
    if wealthy_scores(i) > 23
       binary_wealthy_scores(i) = 1; 
    else
        binary_wealthy_scores(i) = 0;
    end     
end


%%%%%
% addpath(genpath(pwd));
% image_names_jpg_read_matrix = matfile('image_names_jpg.mat');
% image_names_jpg_array = image_names_jpg_read_matrix.image_names_jpg;
% my_tai
% for i=1:100
%     image_cell(1,i) = {image_names_jpg_array(i,:)};
% end
% my_train_lists = {image_cell}
% 
% 
% for i=1:10
%     image_cell_test(1,i) = {image_names_jpg_array(i+100,:)};
% end
% my_test_lists = {image_cell_test}
% 
% feature = 'color';
% 
% datasets = { 'asdfg'};
% train_lists = my_train_lists;
% test_lists = my_test_lists ;
% 
% c = conf();
% c.feature_config.(feature).dictionary_size=20;
% 
% datasets_feature(datasets, train_lists, test_lists, feature, c);
% train_features = load_feature(datasets{1}, feature, 'train', c);
% test_features = load_feature(datasets{2}, feature, 'test', c);
%%%%%


for i=1:number_of_img
    image_name = A(i).name;
    image_path = strcat(source_directory, image_name);
    current_image = imread(image_path);
    fprintf(1, 'Now reading %s\n', image_name);
    current_img_1_1 = current_image(1:91,1:134,:);
    current_img_2_1 = current_image(92:181,1:134,:);
    current_img_3_1 = current_image(182:271,1:134,:);
    current_img_1_2 = current_image(1:91,135:268,:);
    current_img_2_2 = current_image(92:182,135:268,:);
    current_img_3_2 = current_image(182:271,135:268,:);
    current_img_1_3 = current_image(1:91,269:400,:);
    current_img_2_3 = current_image(92:181,269:400,:);
    current_img_3_3 = current_image(182:271,269:400,:);

    
    % Load image
% img = imread('demo2.jpg');
% 
% % GIST Parameters:
% clear param
% param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
% param.numberBlocks = 4;
% param.fc_prefilt = 4;
% 
% % Computing gist:
% [gist, param] = LMgist(img, '', param);
% 
% Visualization:
% 
% To visualize the gist descriptor use the function showGist.m. Here there is an example of how to use it:
% 
% % Visualization
% figure
% subplot(121)
% imshow(img)
% title('Input image')
% subplot(122)
% showGist(gist, param)
% title('Descriptor')

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%extract GIST
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_1_1, param] = LMgist(current_img_1_1, '', param);
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_2_1, param] = LMgist(current_img_2_1, '', param);
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_3_1, param] = LMgist(current_img_3_1, '', param);
% 
% 
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_1_2, param] = LMgist(current_img_1_2, '', param);
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_2_2 param] = LMgist(current_img_2_2, '', param);
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_3_2, param] = LMgist(current_img_3_2, '', param);
% 
% 
% 
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_1_3, param] = LMgist(current_img_1_3, '', param);
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_2_3, param] = LMgist(current_img_2_3, '', param);
% clear param
% param.orientationsPerScale = [4 4 4 4];
% param.numberBlocks = 2;
% param.fc_prefilt = 2;
% [gist_3_3, param] = LMgist(current_img_3_3, '', param);
% 
%     gist_features = [gist_1_1,gist_1_2,gist_1_3,gist_2_1,gist_2_2,gist_2_3,gist_3_1,gist_3_2,gist_3_3];
%                        

%%%%%%%%%%%%%%%%%%%%%%%%%%


%     red_1_1   = current_img_1_1(:,:,1);
%     green_1_1 = current_img_1_1(:,:,2);
%     blue_1_1  = current_img_1_1(:,:,3);
%     hist_red_1_1   = single(imhist(red_1_1,4));
%     hist_green_1_1 = single(imhist(green_1_1,4));
%     hist_blue_1_1  = single(imhist(blue_1_1,4));
%     red_2_1   = current_img_2_1(:,:,1);
%     green_2_1 = current_img_2_1(:,:,2);
%     blue_2_1  = current_img_2_1(:,:,3);
%     hist_red_2_1   = single(imhist(red_2_1,4));
%     hist_green_2_1 = single(imhist(green_2_1,4));
%     hist_blue_2_1  = single(imhist(blue_2_1,4));
%     red_3_1   = current_img_3_1(:,:,1);
%     green_3_1 = current_img_3_1(:,:,2);
%     blue_3_1  = current_img_3_1(:,:,3);
%     hist_red_3_1   = single(imhist(red_3_1,4));
%     hist_green_3_1 = single(imhist(green_3_1,4));
%     hist_blue_3_1  = single(imhist(blue_3_1,4));
%    
%     
%     red_1_2   = current_img_1_2(:,:,1);
%     green_1_2 = current_img_1_2(:,:,2);
%     blue_1_2  = current_img_1_2(:,:,3);
%     hist_red_1_2   = single(imhist(red_1_2,4));
%     hist_green_1_2 = single(imhist(green_1_2,4));
%     hist_blue_1_2  = single(imhist(blue_1_2,4));
%     red_2_2   = current_img_2_2(:,:,1);
%     green_2_2 = current_img_2_2(:,:,2);
%     blue_2_2  = current_img_2_2(:,:,3);
%     hist_red_2_2   = single(imhist(red_2_2,4));
%     hist_green_2_2 = single(imhist(green_2_2,4));
%     hist_blue_2_2  = single(imhist(blue_2_2,4));
%     red_3_2   = current_img_3_2(:,:,1);
%     green_3_2 = current_img_3_2(:,:,2);
%     blue_3_2  = current_img_3_2(:,:,3);
%     hist_red_3_2   = single(imhist(red_3_2,4));
%     hist_green_3_2 = single(imhist(green_3_2,4));
%     hist_blue_3_2  = single(imhist(blue_3_2,4));
%     
%     
%     red_1_3   = current_img_1_3(:,:,1);
%     green_1_3 = current_img_1_3(:,:,2);
%     blue_1_3  = current_img_1_3(:,:,3);
%     hist_red_1_3   = single(imhist(red_1_3,4));
%     hist_green_1_3 = single(imhist(green_1_3,4));
%     hist_blue_1_3  = single(imhist(blue_1_3,4));
%     red_2_3   = current_img_2_3(:,:,1);
%     green_2_3 = current_img_2_3(:,:,2);
%     blue_2_3  = current_img_2_3(:,:,3);
%     hist_red_2_3   = single(imhist(red_2_3,4));
%     hist_green_2_3 = single(imhist(green_2_3,4));
%     hist_blue_2_3  = single(imhist(blue_2_3,4));
%     red_3_3   = current_img_3_3(:,:,1);
%     green_3_3 = current_img_3_3(:,:,2);
%     blue_3_3  = current_img_3_3(:,:,3);
%     hist_red_3_3   = single(imhist(red_3_3,4));
%     hist_green_3_3 = single(imhist(green_3_3,4));
%     hist_blue_3_3  = single(imhist(blue_3_3,4));
%     
%     
%     color_histogram = [hist_red_1_1;hist_blue_1_1;hist_green_1_1;...
%                        hist_red_1_2;hist_blue_1_2;hist_green_1_2;...
%                        hist_red_1_3;hist_blue_1_3;hist_green_1_3;...
%                        hist_red_2_1;hist_blue_2_1;hist_green_2_1;...
%                        hist_red_2_2;hist_blue_2_2;hist_green_2_2;...
%                        hist_red_2_3;hist_blue_2_3;hist_green_2_3;...
%                        hist_red_3_1;hist_blue_3_1;hist_green_3_1;...
%                        hist_red_3_2;hist_blue_3_2;hist_green_3_2;...
%                        hist_red_3_3;hist_blue_3_3;hist_green_3_3];


% param.orientationsPerScale = [4 4 4 4]; % number of orientations per scale (from HF to LF)
% param.numberBlocks = 2;
% param.fc_prefilt = 8;
% 
% % Computing gist:
% [gist, param] = LMgist(current_image, '', param);



%     current_features = [color_histogram.'];
current_features = gist_features;
    features_end = [features_end; current_features];
    
%     colour_features = features_end ;
%     save('color_features_9710_108.mat','colour_features');

    
end


% number_of_img = length(safe_scores);
% sum(safe_scores(:)<0);
% maximum_of_safe_scores = max(safe_scores);
% minimum_of_safe_scores = min(safe_scores);
% range_safe_scores = maximum_of_safe_scores -minimum_of_safe_scores;
% scaled_safe_scores = zeros(number_of_img,1);
% for i = 1 : number_of_img
%     scaled_safe_scores(i) = 5* ((safe_scores(i)-minimum_of_safe_scores) / range_safe_scores) ;
%     scaled_safe_scores(i) = round(scaled_safe_scores(i));
% end
% 
% hist(safe_scores,100)
%  features_end = loaded_color_features;

% binary svm yapılacak

fprintf(1, 'Now training the network\n'); % fitcecoc
binary_svm_model_safe = fitcsvm(features_end(1:2000,:), binary_safe_scores(1:2000));
fprintf(1, 'Now testing the network\n');
[predicted_labels_safe,score_safe] = predict(binary_svm_model_safe, features_end(2001:2100,:));
accuracy_safe = length(find(binary_safe_scores(2001:2100) == predicted_labels_safe))/100;
fprintf(1, 'The accuracy is %d\n', accuracy_safe);

fprintf(1, 'Now training the network\n'); % fitcecoc
binary_svm_model_wealthy = fitcsvm(features_end(1:2000,:), binary_wealthy_scores(1:2000));
fprintf(1, 'Now testing the network\n');
[predicted_labels_wealthy,score_wealthy] = predict(binary_svm_model_wealthy, features_end(2001:2100,:));
accuracy_wealthy = length(find(binary_wealthy_scores(2001:2100) == predicted_labels_wealthy))/100;
fprintf(1, 'The accuracy is %d\n', accuracy_wealthy);


original_labels = binary_safe_scores(7001:7500);
conf = confusionmat(original_labels,predicted_labels);





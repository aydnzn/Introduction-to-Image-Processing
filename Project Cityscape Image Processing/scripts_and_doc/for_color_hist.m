% This script performs the following tasks:
% 
% Clearing Workspace: The command clear clears all variables from the MATLAB workspace.
% Variable Initialization: The script initializes variables related to image categories and paths. The variables safe_yes, lively_yes, boring_yes, wealthy_yes, depressing_yes, and beautiful_yes store the IDs of different image categories.
% Loading Data: The script loads various data files using the matfile function. These files include:
% image_names_in_dataset.mat: Contains an array of image names.
% image_ids_in_qscores_file.mat: Contains an array of image IDs.
% study_ids_in_qscores_file.mat: Contains an array of study IDs.
% scores_in_qscores_file.mat: Contains an array of score IDs.
% safe_scores.mat: Contains an array of safe scores.
% wealthy_scores.mat: Contains an array of wealthy scores.
% Data Processing:
% The script converts the continuous scores into binary scores for the safe and wealthy categories. If a score is greater than 23, it is considered as 1 (positive), otherwise 0 (negative).
% The binary scores for safe and wealthy are stored in the variables binary_safe_scores and binary_wealthy_scores, respectively.
% Feature Loading: The script loads color features from the color_features_9710_48.mat file. The features are stored in the variable features_end.
% SVM Model Training and Testing:
% The script trains an SVM model for the safe category using the fitcsvm function and the first 1000 instances of features_end and binary_safe_scores.
% The script tests the trained safe SVM model on the remaining instances (1001 to 1100) of features_end and stores the predicted labels and scores in predicted_labels_safe and score_safe, respectively.
% The accuracy of the safe SVM model is calculated by comparing the predicted labels with the actual binary safe scores.
% Similar steps are performed for the wealthy category:
% The script trains an SVM model for the wealthy category using the fitcsvm function and the first 1000 instances of features_end and binary_wealthy_scores.
% The script tests the trained wealthy SVM model on the remaining instances (1001 to 1100) of features_end and stores the predicted labels and scores in predicted_labels_wealthy and score_wealthy, respectively.
% The accuracy of the wealthy SVM model is calculated by comparing the predicted labels with the actual binary wealthy scores.

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

features_end = [];

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

% for i=1:number_of_img
%     image_name = A(i).name;
%     image_path = strcat(source_directory, image_name);
%     current_image = imread(image_path);
%     fprintf(1, 'Now reading %s\n', image_name);
%     current_img_1_1 = current_image(1:67,1:100,:);
%     current_img_2_1 = current_image(68:135,1:100,:);
%     current_img_3_1 = current_image(136:203,1:100,:);
%     current_img_4_1 = current_image(204:271,1:100,:);
%     current_img_1_2 = current_image(1:67,101:200,:);
%     current_img_2_2 = current_image(68:135,101:200,:);
%     current_img_3_2 = current_image(136:203,101:200,:);
%     current_img_4_2 = current_image(204:271,101:200,:);
%     current_img_1_3 = current_image(1:67,201:300,:);
%     current_img_2_3 = current_image(68:135,201:300,:);
%     current_img_3_3 = current_image(136:203,201:300,:);
%     current_img_4_3 = current_image(204:271,201:300,:);
%     current_img_1_4 = current_image(1:67,301:400,:);
%     current_img_2_4 = current_image(68:135,301:400,:);
%     current_img_3_4 = current_image(136:203,301:400,:);
%     current_img_4_4 = current_image(204:271,301:400,:);
%
%
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
%     red_4_1   = current_img_4_1(:,:,1);
%     green_4_1 = current_img_4_1(:,:,2);
%     blue_4_1  = current_img_4_1(:,:,3);
%     hist_red_4_1   = single(imhist(red_4_1,4));
%     hist_green_4_1 = single(imhist(green_4_1,4));
%     hist_blue_4_1  = single(imhist(blue_4_1,4));
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
%     red_4_2   = current_img_4_2(:,:,1);
%     green_4_2 = current_img_4_2(:,:,2);
%     blue_4_2  = current_img_4_2(:,:,3);
%     hist_red_4_2   = single(imhist(red_4_2,4));
%     hist_green_4_2 = single(imhist(green_4_2,4));
%     hist_blue_4_2  = single(imhist(blue_4_2,4));
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
%     red_4_3   = current_img_4_3(:,:,1);
%     green_4_3 = current_img_4_3(:,:,2);
%     blue_4_3  = current_img_4_3(:,:,3);
%     hist_red_4_3   = single(imhist(red_4_3,4));
%     hist_green_4_3 = single(imhist(green_4_3,4));
%     hist_blue_4_3  = single(imhist(blue_4_3,4));
%
%
%
%     red_1_4   = current_img_1_4(:,:,1);
%     green_1_4 = current_img_1_4(:,:,2);
%     blue_1_4  = current_img_1_4(:,:,3);
%     hist_red_1_4   = single(imhist(red_1_4,4));
%     hist_green_1_4 = single(imhist(green_1_4,4));
%     hist_blue_1_4  = single(imhist(blue_1_4,4));
%     red_2_4   = current_img_2_4(:,:,1);
%     green_2_4 = current_img_2_4(:,:,2);
%     blue_2_4  = current_img_2_4(:,:,3);
%     hist_red_2_4   = single(imhist(red_2_4,4));
%     hist_green_2_4 = single(imhist(green_2_4,4));
%     hist_blue_2_4  = single(imhist(blue_2_4,4));
%     red_3_4   = current_img_3_4(:,:,1);
%     green_3_4 = current_img_3_4(:,:,2);
%     blue_3_4  = current_img_3_4(:,:,3);
%     hist_red_3_4   = single(imhist(red_3_4,4));
%     hist_green_3_4 = single(imhist(green_3_4,4));
%     hist_blue_3_4  = single(imhist(blue_3_4,4));
%     red_4_4   = current_img_4_4(:,:,1);
%     green_4_4 = current_img_4_4(:,:,2);
%     blue_4_4  = current_img_4_4(:,:,3);
%     hist_red_4_4   = single(imhist(red_4_4,4));
%     hist_green_4_4 = single(imhist(green_4_4,4));
%     hist_blue_4_4  = single(imhist(blue_4_4,4));
%
%
%
%     color_histogram = [hist_red_1_1;hist_blue_1_1;hist_green_1_1;...
%         hist_red_1_2;hist_blue_1_2;hist_green_1_2;...
%         hist_red_1_3;hist_blue_1_3;hist_green_1_3;...
%         hist_red_1_4;hist_blue_1_4;hist_green_1_4;...
%         hist_red_2_1;hist_blue_2_1;hist_green_2_1;...
%         hist_red_2_2;hist_blue_2_2;hist_green_2_2;...
%         hist_red_2_3;hist_blue_2_3;hist_green_2_3;...
%         hist_red_2_4;hist_blue_2_4;hist_green_2_4;...
%         hist_red_3_1;hist_blue_3_1;hist_green_3_1;...
%         hist_red_3_2;hist_blue_3_2;hist_green_3_2;...
%         hist_red_3_3;hist_blue_3_3;hist_green_3_3;...
%         hist_red_3_4;hist_blue_3_4;hist_green_3_4;...
%         hist_red_4_1;hist_blue_4_1;hist_green_4_1;...
%         hist_red_4_2;hist_blue_4_2;hist_green_4_2;...
%         hist_red_4_3;hist_blue_4_3;hist_green_4_3;...
%         hist_red_4_4;hist_blue_4_4;hist_green_4_4];
%
%
%     current_features = [color_histogram.'];
%
%
%      features_end = [features_end; current_features];
%
% end

% for i=1:number_of_img
%     image_name = A(i).name;
%     image_path = strcat(source_directory, image_name);
%     current_image = imread(image_path);
%     fprintf(1, 'Now reading %s\n', image_name);
%     current_img_1_1 = current_image(1:135,1:200,:);
%     current_img_2_1 = current_image(136:271,1:200,:);
%     
%     current_img_1_2 = current_image(1:135,201:400,:);
%     current_img_2_2 = current_image(136:271,201:400,:);
%     
%     
%     
%     
%     red_1_1   = current_img_1_1(:,:,1);
%     green_1_1 = current_img_1_1(:,:,2);
%     blue_1_1  = current_img_1_1(:,:,3);
%     hist_red_1_1   = single(imhist(red_1_1,4));
%     hist_green_1_1 = single(imhist(green_1_1,4));
%     hist_blue_1_1  = single(imhist(blue_1_1,4));
%     
%     red_2_1   = current_img_2_1(:,:,1);
%     green_2_1 = current_img_2_1(:,:,2);
%     blue_2_1  = current_img_2_1(:,:,3);
%     hist_red_2_1   = single(imhist(red_2_1,4));
%     hist_green_2_1 = single(imhist(green_2_1,4));
%     hist_blue_2_1  = single(imhist(blue_2_1,4));
%     
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
%     
%     
%     
%     
%     color_histogram = [hist_red_1_1;hist_blue_1_1;hist_green_1_1;...
%         hist_red_1_2;hist_blue_1_2;hist_green_1_2;...
%         hist_red_2_1;hist_blue_2_1;hist_green_2_1;...
%         hist_red_2_2;hist_blue_2_2;hist_green_2_2];
%     
%     
%     current_features = [color_histogram.'];
%     
%     
%     features_end = [features_end; current_features];
%     
% end


color_features_read_matrix = matfile('color_features_9710_48.mat');
% features_end = color_features_read_matrix.colour_features;
features_end = color_features_read_matrix.features_end;

fprintf(1, 'Now training the network\n'); % fitcecoc
binary_svm_model_safe = fitcsvm(features_end(1:1000,:), binary_safe_scores(1:1000));
fprintf(1, 'Now testing the network\n');
[predicted_labels_safe,score_safe] = predict(binary_svm_model_safe, features_end(1001:1100,:));
accuracy_safe = length(find(binary_safe_scores(1001:1100) == predicted_labels_safe))/100;
fprintf(1, 'The safe accuracy is %d\n', accuracy_safe);

fprintf(1, 'Now training the network\n'); % fitcecoc
binary_svm_model_wealthy = fitcsvm(features_end(1:1000,:), binary_wealthy_scores(1:1000));
fprintf(1, 'Now testing the network\n');
[predicted_labels_wealthy,score_wealthy] = predict(binary_svm_model_wealthy, features_end(1001:1100,:));
accuracy_wealthy = length(find(binary_wealthy_scores(1001:1100) == predicted_labels_wealthy))/100;
fprintf(1, 'The wealthy accuracy is %d\n', accuracy_wealthy);
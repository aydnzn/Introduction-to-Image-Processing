% This script appears to perform various operations related to image processing and feature extraction. Here is a summary of what the script does:
% The script initializes variables and sets up the file paths for the images and data files.
% It loads preprocessed data from mat files.
% It calculates binary scores based on safe and wealthy thresholds.
% It loads wavelet features from a mat file.
% The script enters a loop to process each image.
% Inside the loop, it reads and processes the current image using wavelet transforms.
% It calculates various statistics (mean, variance) for different wavelet coefficients.
% It collects the calculated statistics in feature vectors (f_vector_1 to f_vector_15).
% The script ends after processing all images.

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

% color_features_read_matrix = matfile('color_features_9710_108.mat');
% colour_features_end = color_features_read_matrix.colour_features;
% 
% gist_features_read_matrix = matfile('gist_features.mat');
% gist_features_end = gist_features_read_matrix.train_features;
% 
% 
% 
%     
% minGist = min(min(gist_features_end));
% maxGist = max(max(gist_features_end));
% normGist = (gist_features_end - minGist) / ( maxGist - minGist );
% minColor = min(min(colour_features_end));
% maxColor = max(max(colour_features_end));
% normColor = (colour_features_end - minColor) / ( maxColor - minColor );

% current_features = gist_features;
features_end = [];
% features_end = [ normGist]; %, gist_features_end ];

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

w_features_read_matrix = matfile('w_features_haar_1200_128.mat');
features_end = w_features_read_matrix.features_end;

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
w_name = 'sym16';

for i=1:1200
    image_name = A(i).name;
    image_path = strcat(source_directory, image_name);
    current_image = imread(image_path);
    
    rgb = rgb2gray(current_image);



    fprintf(1, 'Now reading %s\n', image_name);
    current_img_1_1 = current_image(1:67,1:100,:);
    current_img_2_1 = current_image(68:135,1:100,:);
    current_img_3_1 = current_image(136:203,1:100,:);
    current_img_4_1 = current_image(204:271,1:100,:);
    current_img_1_2 = current_image(1:67,101:200,:);
    current_img_2_2 = current_image(68:135,101:200,:);
    current_img_3_2 = current_image(136:203,101:200,:);
    current_img_4_2 = current_image(204:271,101:200,:);
    current_img_1_3 = current_image(1:67,201:300,:);
    current_img_2_3 = current_image(68:135,201:300,:);
    current_img_3_3 = current_image(136:203,201:300,:);
    current_img_4_3 = current_image(204:271,201:300,:);
    current_img_1_4 = current_image(1:67,301:400,:);
    current_img_2_4 = current_image(68:135,301:400,:);
    current_img_3_4 = current_image(136:203,301:400,:);
    current_img_4_4 = current_image(204:271,301:400,:);
    
    current_img_1_1_gray = rgb2gray(current_img_1_1);
    current_img_2_1_gray = rgb2gray(current_img_2_1);
    current_img_3_1_gray = rgb2gray(current_img_3_1);
    current_img_4_1_gray = rgb2gray(current_img_4_1);
    current_img_1_2_gray = rgb2gray(current_img_1_2);
    current_img_2_2_gray = rgb2gray(current_img_2_2);
    current_img_3_2_gray = rgb2gray(current_img_3_2);
    current_img_4_2_gray = rgb2gray(current_img_4_2);
    current_img_1_3_gray = rgb2gray(current_img_1_3);
    current_img_2_3_gray = rgb2gray(current_img_2_3);
    current_img_3_3_gray = rgb2gray(current_img_3_3);
    current_img_4_3_gray = rgb2gray(current_img_4_3);
    current_img_1_4_gray = rgb2gray(current_img_1_4);
    current_img_2_4_gray = rgb2gray(current_img_2_4);
    current_img_3_4_gray = rgb2gray(current_img_3_4);
    current_img_4_4_gray = rgb2gray(current_img_4_4);
    
    figure(1);
    imshow(current_image);
    
    figure(2);
    imshow(rgb);
    
    figure(3);
    imshow(current_img_1_1_gray);
    
        [LoD,HiD] = wfilters('haar','d');
    [cA,cH,cV,cD] = dwt2(current_img_1_1_gray,LoD,HiD,'mode','symh');
    
    figure(4);
subplot(2,2,1)
imagesc(cA)
colormap gray
title('LL_0')
subplot(2,2,2)
imagesc(cH)
colormap gray
title('LH_0')
subplot(2,2,3)
imagesc(cV)
colormap gray
title('HL_0')
subplot(2,2,4)
imagesc(cD)
colormap gray
title('HH_0')

[cA_1,cH_1,cV_1,cD_1] = dwt2(cA,LoD,HiD,'mode','symh');
figure(5);
subplot(2,2,1)
imagesc(cA_1)
colormap gray
title('LL_1')
subplot(2,2,2)
imagesc(cH_1)
colormap gray
title('LH_1')
subplot(2,2,3)
imagesc(cV_1)
colormap gray
title('HL_1')
subplot(2,2,4)
imagesc(cD_1)
colormap gray
title('HH_1')


    
    [LL_0_1_1,HL_0_1_1,LH_0_1_1,HH_0_1_1] = dwt2(current_img_1_1_gray,'haar') ;
    [LL_1_1_1,HL_1_1_1,LH_1_1_1,HH_1_1_1] = dwt2(LL_0_1_1,'haar') ;
    
    one_1_1 = mean(LL_1_1_1,'all');
    two_1_1 = var(LL_1_1_1,0,'all');
    sum_1_1 =(HL_1_1_1 + LH_1_1_1);
    three_1_1 = mean(sum_1_1,'all');
    four_1_1 = var(sum_1_1,0,'all');
    five_1_1 = mean(LL_0_1_1,'all');
    six_1_1 = var(LL_0_1_1,0,'all');
    sum2_1_1 = HL_0_1_1 + LH_0_1_1;
    seven_1_1 = mean(sum2_1_1,'all');
    eight_1_1 = var(sum2_1_1,0,'all');
    f_vector_1 = [one_1_1,two_1_1,three_1_1,four_1_1,five_1_1,six_1_1,seven_1_1,eight_1_1];
    
        [LL_0_2_1,HL_0_2_1,LH_0_2_1,HH_0_2_1] = dwt2(current_img_2_1_gray,w_name) ;
    [LL_1_2_1,HL_1_2_1,LH_1_2_1,HH_1_2_1] = dwt2(LL_0_2_1,w_name) ;
    one_2_1 = mean(LL_1_2_1,'all');
    two_2_1 = var(LL_1_2_1,0,'all');
    sum_2_1 =(HL_1_2_1 + LH_1_2_1);
    three_2_1 = mean(sum_2_1,'all');
    four_2_1 = var(sum_2_1,0,'all');
    five_2_1 = mean(LL_0_2_1,'all');
    six_2_1 = var(LL_0_2_1,0,'all');
    sum2_2_1 = HL_0_2_1 + LH_0_2_1;
    seven_2_1 = mean(sum2_2_1,'all');
    eight_2_1 = var(sum2_2_1,0,'all');
    f_vector_2 = [one_2_1,two_2_1,three_2_1,four_2_1,five_2_1,six_2_1,seven_2_1,eight_2_1];
    
        [LL_0_3_1,HL_0_3_1,LH_0_3_1,HH_0_3_1] = dwt2(current_img_3_1_gray,w_name) ;
    [LL_1_3_1,HL_1_3_1,LH_1_3_1,HH_1_3_1] = dwt2(LL_0_3_1,w_name) ;
    one_3_1 = mean(LL_1_3_1,'all');
    two_3_1 = var(LL_1_3_1,0,'all');
    sum_3_1 =(HL_1_3_1 + LH_1_3_1);
    three_3_1 = mean(sum_3_1,'all');
    four_3_1 = var(sum_3_1,0,'all');
    five_3_1 = mean(LL_0_3_1,'all');
    six_3_1 = var(LL_0_3_1,0,'all');
    sum2_3_1 = HL_0_3_1 + LH_0_3_1;
    seven_3_1 = mean(sum2_3_1,'all');
    eight_3_1 = var(sum2_3_1,0,'all');
    f_vector_3 = [one_3_1,two_3_1,three_3_1,four_3_1,five_3_1,six_3_1,seven_3_1,eight_3_1];
    
            [LL_0_4_1,HL_0_4_1,LH_0_4_1,HH_0_4_1] = dwt2(current_img_4_1_gray,w_name) ;
    [LL_1_4_1,HL_1_4_1,LH_1_4_1,HH_1_4_1] = dwt2(LL_0_4_1,w_name) ;
    one_4_1 = mean(LL_1_4_1,'all');
    two_4_1 = var(LL_1_4_1,0,'all');
    sum_4_1 =(HL_1_4_1 + LH_1_4_1);
    three_4_1 = mean(sum_4_1,'all');
    four_4_1 = var(sum_4_1,0,'all');
    five_4_1 = mean(LL_0_4_1,'all');
    six_4_1 = var(LL_0_4_1,0,'all');
    sum2_4_1 = HL_0_4_1 + LH_0_4_1;
    seven_4_1 = mean(sum2_4_1,'all');
    eight_4_1 = var(sum2_4_1,0,'all');
    f_vector_4 = [one_4_1,two_4_1,three_4_1,four_4_1,five_4_1,six_4_1,seven_4_1,eight_4_1];
    
           [LL_0_1_2,HL_0_1_2,LH_0_1_2,HH_0_1_2] = dwt2(current_img_1_2_gray,w_name) ;
    [LL_1_1_2,HL_1_1_2,LH_1_1_2,HH_1_1_2] = dwt2(LL_0_1_2,w_name) ;
    one_1_2 = mean(LL_1_1_2,'all');
    two_1_2 = var(LL_1_1_2,0,'all');
    sum_1_2 =(HL_1_1_2 + LH_1_1_2);
    three_1_2 = mean(sum_1_2,'all');
    four_1_2 = var(sum_1_2,0,'all');
    five_1_2 = mean(LL_0_1_2,'all');
    six_1_2= var(LL_0_1_2,0,'all');
    sum2_1_2 = HL_0_1_2 + LH_0_1_2;
    seven_1_2 = mean(sum2_1_2,'all');
    eight_1_2 = var(sum2_1_2,0,'all');
    f_vector_5 = [one_1_2,two_1_2,three_1_2,four_1_2,five_1_2,six_1_2,seven_1_2,eight_1_2];
    
        [LL_0_2_2,HL_0_2_2,LH_0_2_2,HH_0_2_2] = dwt2(current_img_2_2_gray,w_name) ;
    [LL_1_2_2,HL_1_2_2,LH_1_2_2,HH_1_2_2] = dwt2(LL_0_2_2,w_name) ;
    one_2_2 = mean(LL_1_2_2,'all');
    two_2_2 = var(LL_1_2_2,0,'all');
    sum_2_2 =(HL_1_2_2 + LH_1_2_2);
    three_2_2 = mean(sum_2_2,'all');
    four_2_2 = var(sum_2_2,0,'all');
    five_2_2 = mean(LL_0_2_2,'all');
    six_2_2 = var(LL_0_2_2,0,'all');
    sum2_2_2 = HL_0_2_2 + LH_0_2_2;
    seven_2_2 = mean(sum2_2_2,'all');
    eight_2_2 = var(sum2_2_2,0,'all');
    f_vector_6 = [one_2_2,two_2_2,three_2_2,four_2_2,five_2_2,six_2_2,seven_2_2,eight_2_2];
    
        [LL_0_3_2,HL_0_3_2,LH_0_3_2,HH_0_3_2] = dwt2(current_img_3_2_gray,w_name) ;
    [LL_1_3_2,HL_1_3_2,LH_1_3_2,HH_1_3_2] = dwt2(LL_0_3_2,w_name) ;
    one_3_2 = mean(LL_1_3_2,'all');
    two_3_2 = var(LL_1_3_2,0,'all');
    sum_3_2 =(HL_1_3_2 + LH_1_3_2);
    three_3_2 = mean(sum_3_2,'all');
    four_3_2 = var(sum_3_2,0,'all');
    five_3_2 = mean(LL_0_3_2,'all');
    six_3_2 = var(LL_0_3_2,0,'all');
    sum2_3_2 = HL_0_3_2 + LH_0_3_2;
    seven_3_2 = mean(sum2_3_2,'all');
    eight_3_2 = var(sum2_3_2,0,'all');
    f_vector_7 = [one_3_2,two_3_2,three_3_2,four_3_2,five_3_2,six_3_2,seven_3_2,eight_3_2];
    
            [LL_0_4_2,HL_0_4_2,LH_0_4_2,HH_0_4_2] = dwt2(current_img_4_2_gray,w_name) ;
    [LL_1_4_2,HL_1_4_2,LH_1_4_2,HH_1_4_2] = dwt2(LL_0_4_2,w_name) ;
    one_4_2 = mean(LL_1_4_2,'all');
    two_4_2 = var(LL_1_4_2,0,'all');
    sum_4_2 =(HL_1_4_2 + LH_1_4_2);
    three_4_2 = mean(sum_4_2,'all');
    four_4_2 = var(sum_4_2,0,'all');
    five_4_2 = mean(LL_0_4_2,'all');
    six_4_2 = var(LL_0_4_2,0,'all');
    sum2_4_2 = HL_0_4_2 + LH_0_4_2;
    seven_4_2 = mean(sum2_4_2,'all');
    eight_4_2 = var(sum2_4_2,0,'all');
    f_vector_8 = [one_4_2,two_4_2,three_4_2,four_4_2,five_4_2,six_4_2,seven_4_2,eight_4_2];
    
           [LL_0_1_3,HL_0_1_3,LH_0_1_3,HH_0_1_3] = dwt2(current_img_1_3_gray,w_name) ;
    [LL_1_1_3,HL_1_1_3,LH_1_1_3,HH_1_1_3] = dwt2(LL_0_1_3,w_name) ;
    one_1_3 = mean(LL_1_1_3,'all');
    two_1_3 = var(LL_1_1_3,0,'all');
    sum_1_3 =(HL_1_1_3 + LH_1_1_3);
    three_1_3 = mean(sum_1_3,'all');
    four_1_3 = var(sum_1_3,0,'all');
    five_1_3 = mean(LL_0_1_3,'all');
    six_1_3 = var(LL_0_1_3,0,'all');
    sum2_1_3 = HL_0_1_3 + LH_0_1_3;
    seven_1_3 = mean(sum2_1_3,'all');
    eight_1_3 = var(sum2_1_3,0,'all');
    f_vector_9 = [one_1_3,two_1_3,three_1_3,four_1_3,five_1_3,six_1_3,seven_1_3,eight_1_3];
    
        [LL_0_2_3,HL_0_2_3,LH_0_2_3,HH_0_2_3] = dwt2(current_img_2_3_gray,w_name) ;
    [LL_1_2_3,HL_1_2_3,LH_1_2_3,HH_1_2_3] = dwt2(LL_0_2_3,w_name) ;
    one_2_3 = mean(LL_1_2_3,'all');
    two_2_3 = var(LL_1_2_3,0,'all');
    sum_2_3 =(HL_1_2_3 + LH_1_2_3);
    three_2_3 = mean(sum_2_3,'all');
    four_2_3 = var(sum_2_3,0,'all');
    five_2_3 = mean(LL_0_2_3,'all');
    six_2_3 = var(LL_0_2_3,0,'all');
    sum2_2_3 = HL_0_2_3 + LH_0_2_3;
    seven_2_3 = mean(sum2_2_3,'all');
    eight_2_3 = var(sum2_2_3,0,'all');
    f_vector_10 = [one_2_3,two_2_3,three_2_3,four_2_3,five_2_3,six_2_3,seven_2_3,eight_2_3];
    
        [LL_0_3_3,HL_0_3_3,LH_0_3_3,HH_0_3_3] = dwt2(current_img_3_3_gray,w_name) ;
    [LL_1_3_3,HL_1_3_3,LH_1_3_3,HH_1_3_3] = dwt2(LL_0_3_3,w_name) ;
    one_3_3 = mean(LL_1_3_3,'all');
    two_3_3 = var(LL_1_3_3,0,'all');
    sum_3_3 =(HL_1_3_3 + LH_1_3_3);
    three_3_3 = mean(sum_3_3,'all');
    four_3_3 = var(sum_3_3,0,'all');
    five_3_3 = mean(LL_0_3_3,'all');
    six_3_3 = var(LL_0_3_3,0,'all');
    sum2_3_3 = HL_0_3_3 + LH_0_3_3;
    seven_3_3 = mean(sum2_3_3,'all');
    eight_3_3 = var(sum2_3_3,0,'all');
    f_vector_11 = [one_3_3,two_3_3,three_3_3,four_3_3,five_3_3,six_3_3,seven_3_3,eight_3_3];
    
            [LL_0_4_3,HL_0_4_3,LH_0_4_3,HH_0_4_3] = dwt2(current_img_4_3_gray,w_name) ;
    [LL_1_4_3,HL_1_4_3,LH_1_4_3,HH_1_4_3] = dwt2(LL_0_4_3,w_name) ;
    one_4_3 = mean(LL_1_4_3,'all');
    two_4_3 = var(LL_1_4_3,0,'all');
    sum_4_3 =(HL_1_4_3 + LH_1_4_3);
    three_4_3 = mean(sum_4_3,'all');
    four_4_3 = var(sum_4_3,0,'all');
    five_4_3 = mean(LL_0_4_3,'all');
    six_4_3 = var(LL_0_4_3,0,'all');
    sum2_4_3 = HL_0_4_3 + LH_0_4_3;
    seven_4_3 = mean(sum2_4_3,'all');
    eight_4_3 = var(sum2_4_3,0,'all');
    f_vector_12 = [one_4_3,two_4_3,three_4_3,four_4_3,five_4_3,six_4_3,seven_4_3,eight_4_3];
    
    
               [LL_0_1_4,HL_0_1_4,LH_0_1_4,HH_0_1_4] = dwt2(current_img_1_4_gray,w_name) ;
    [LL_1_1_4,HL_1_1_4,LH_1_1_4,HH_1_1_4] = dwt2(LL_0_1_4,w_name) ;
    one_1_4 = mean(LL_1_1_4,'all');
    two_1_4 = var(LL_1_1_4,0,'all');
    sum_1_4 =(HL_1_1_4 + LH_1_1_4);
    three_1_4 = mean(sum_1_4,'all');
    four_1_4 = var(sum_1_4,0,'all');
    five_1_4 = mean(LL_0_1_4,'all');
    six_1_4 = var(LL_0_1_4,0,'all');
    sum2_1_4 = HL_0_1_4 + LH_0_1_4;
    seven_1_4 = mean(sum2_1_4,'all');
    eight_1_4 = var(sum2_1_4,0,'all');
    f_vector_13 = [one_1_4,two_1_4,three_1_4,four_1_4,five_1_4,six_1_4,seven_1_4,eight_1_4];
    
        [LL_0_2_4,HL_0_2_4,LH_0_2_4,HH_0_2_4] = dwt2(current_img_2_4_gray,w_name) ;
    [LL_1_2_4,HL_1_2_4,LH_1_2_4,HH_1_2_4] = dwt2(LL_0_2_4,w_name) ;
    one_2_4 = mean(LL_1_2_4,'all');
    two_2_4 = var(LL_1_2_4,0,'all');
    sum_2_4 =(HL_1_2_4 + LH_1_2_4);
    three_2_4 = mean(sum_2_4,'all');
    four_2_4 = var(sum_2_4,0,'all');
    five_2_4 = mean(LL_0_2_4,'all');
    six_2_4 = var(LL_0_2_4,0,'all');
    sum2_2_4 = HL_0_2_4 + LH_0_2_4;
    seven_2_4 = mean(sum2_2_4,'all');
    eight_2_4 = var(sum2_2_4,0,'all');
    f_vector_14 = [one_2_4,two_2_4,three_2_4,four_2_4,five_2_4,six_2_4,seven_2_4,eight_2_4];
    
        [LL_0_3_4,HL_0_3_4,LH_0_3_4,HH_0_3_4] = dwt2(current_img_3_4_gray,w_name) ;
    [LL_1_3_4,HL_1_3_4,LH_1_3_4,HH_1_3_4] = dwt2(LL_0_3_4,w_name) ;
    one_3_4 = mean(LL_1_3_4,'all');
    two_3_4 = var(LL_1_3_4,0,'all');
    sum_3_4 =(HL_1_3_4 + LH_1_3_4);
    three_3_4 = mean(sum_3_4,'all');
    four_3_4 = var(sum_3_4,0,'all');
    five_3_4 = mean(LL_0_3_4,'all');
    six_3_4= var(LL_0_3_4,0,'all');
    sum2_3_4 = HL_0_3_4 + LH_0_3_4;
    seven_3_4 = mean(sum2_3_4,'all');
    eight_3_4 = var(sum2_3_4,0,'all');
    f_vector_15 = [one_3_4,two_3_4,three_3_4,four_3_4,five_3_4,six_3_4,seven_3_4,eight_3_4];
    
            [LL_0_4_4,HL_0_4_4,LH_0_4_4,HH_0_4_4] = dwt2(current_img_4_4_gray,w_name) ;
    [LL_1_4_4,HL_1_4_4,LH_1_4_4,HH_1_4_4] = dwt2(LL_0_4_4,w_name) ;
    one_4_4 = mean(LL_1_4_4,'all');
    two_4_4 = var(LL_1_4_4,0,'all');
    sum_4_4 =(HL_1_4_4 + LH_1_4_4);
    three_4_4 = mean(sum_4_4,'all');
    four_4_4 = var(sum_4_4,0,'all');
    five_4_4 = mean(LL_0_4_4,'all');
    six_4_4 = var(LL_0_4_4,0,'all');
    sum2_4_4 = HL_0_4_4 + LH_0_4_4;
    seven_4_4 = mean(sum2_4_4,'all');
    eight_4_4 = var(sum2_4_4,0,'all');
    f_vector_16 = [one_4_4,two_4_4,three_4_4,four_4_4,five_4_4,six_4_4,seven_4_4,eight_4_4];
    
    dwt_feature_vector = [f_vector_1,f_vector_2,f_vector_3,f_vector_4,f_vector_5,f_vector_6,f_vector_7,f_vector_8,f_vector_9,f_vector_10,f_vector_11,f_vector_12,f_vector_13,f_vector_14,f_vector_15,f_vector_16];
    
    
    
    


    
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
current_features = dwt_feature_vector;
    features_end = [features_end; current_features];
    
%     colour_features = features_end ;
%     save('color_features_9710_108.mat','colour_features');

    
end

%    save('w_features_sym4_1200_128.mat','features_end');


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
% 
% 
% original_labels = binary_safe_scores(7001:7500);
% conf = confusionmat(original_labels,predicted_labels);
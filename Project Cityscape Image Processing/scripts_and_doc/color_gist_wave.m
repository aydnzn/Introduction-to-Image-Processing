% Clearing Workspace: The command clear clears all variables from the MATLAB workspace.
% Variable Initialization: Several variables are initialized with image IDs for different categories such as "safe," "lively," "boring," "wealthy," "depressing," and "beautiful." These IDs are assigned as strings.
% Data Loading: The script loads various data from MAT files. This includes image names, image IDs, study IDs, score IDs, safe scores, and wealthy scores. These variables are read from the respective MAT files using the matfile function.
% Binary Score Conversion: The safe scores and wealthy scores are converted into binary values based on a threshold. If a score is greater than 23, it is assigned a binary value of 1; otherwise, it is assigned 0. The conversion is done using two separate loops for safe and wealthy scores.
% Feature Extraction: Different sets of features are loaded from MAT files. These include wavelet features, GIST features, and color features. The loaded features are stored in respective variables.
% Feature Normalization: The color features, wavelet features, and GIST features are individually normalized using min-max normalization. The minimum and maximum values for each feature set are calculated, and then the normalization is performed using the formula (x - min(x)) / (max(x) - min(x)). The normalized features are stored in respective variables.
% Feature Concatenation: The normalized wavelet features, the first 1200 rows of normalized GIST features, and the first 1200 rows of normalized color features are concatenated horizontally to form the features_end matrix. This matrix represents the combined set of features used as input for the SVM model.
% Training and Testing the SVM Model for Safe Classification: An SVM model is trained using the first 1000 instances of the features_end matrix and the corresponding binary safe scores. The fitcsvm function is used to train the SVM model. After training, the model is tested on instances 1001 to 1100 of features_end. The predicted labels and scores are obtained using the predict function. The accuracy of the model is calculated by comparing the predicted labels with the actual binary safe scores.
% Training and Testing the SVM Model for Wealthy Classification: Similar to the safe classification, an SVM model is trained using the first 1000 instances of features_end and the corresponding binary wealthy scores. The model is then tested on instances 1001 to 1100, and the accuracy is calculated.
% Printing Results: The script prints the safe accuracy and wealthy accuracy obtained from the SVM models.
% Overall, this script performs binary classification using SVM models to predict whether an image belongs to the "safe" or "wealthy" category based on the extracted features.

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
w_features_end = w_features_read_matrix.features_end;


aydin_gist_features_read_matrix = matfile('aydin_gist_features.mat');
gist_features_end = aydin_gist_features_read_matrix.features_end;

color_features_read_matrix = matfile('color_features_9710_108.mat');
colour_features_end = color_features_read_matrix.colour_features;

minColor = min(min(colour_features_end));
maxColor = max(max(colour_features_end));
normColor = (colour_features_end - minColor) / ( maxColor - minColor );

minWave = min(min(w_features_end));
maxWave = max(max(w_features_end));
normWave = (w_features_end - minWave) / ( maxWave - minWave );

minGist = min(min(gist_features_end));
maxGist = max(max(gist_features_end));
normGist = (gist_features_end - minGist) / ( maxGist - minGist );


features_end = [];
features_end = [ normWave,normGist(1:1200,:),normColor(1:1200,:) ]; %, gist_features_end ];


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
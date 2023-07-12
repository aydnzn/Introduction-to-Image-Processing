% This script appears to be processing scores from a TSV file and scaling them based on certain criteria. Here's what the script does:
% 
% Clears all existing variables in the workspace.
% Initializes variables with string values representing different categories (safe_yes, lively_yes, etc.).
% Sets the source_directory variable to the path of the directory containing the images.
% Uses the dir function to list all files in the source_directory that have the ".JPG" extension. The file names and information are stored in the A struct array.
% Determines the number of images in the dataset based on the length of A.
% Loads the image_names_array from a previously saved mat file called "image_names_in_dataset.mat".
% Loads the image_ids from a previously saved mat file called "image_ids_in_qscores_file.mat".
% Loads the study_ids from a previously saved mat file called "study_ids_in_qscores_file.mat".
% Loads the score_ids from a previously saved mat file called "scores_in_qscores_file.mat".
% Determines the total number of lines (scores) in the TSV file based on the length of score_ids.
% Initializes variables (safe_scores, wealthy_scores) and indices (index_safe, index_wealthy) for storing scores and counting.
% Starts a loop to process each image and its associated score.
% Inside the loop, the current image name (my_image_name) is retrieved from image_names_array.
% Another loop iterates over the scores in the TSV file to find a match for the current image.
% If a match is found, the corresponding score is added to either the safe_scores or wealthy_scores array based on the associated study ID.
% After each iteration of the outer loop, the progress is printed.
% The safe_scores and wealthy_scores arrays are saved to separate mat files.
% The maximum and minimum values of safe_scores and wealthy_scores are computed.
% The range of the scores is calculated.
% Another loop scales the scores from 0 to 10 based on the computed range and stores them in scaled_safe_scores and scaled_wealthy_scores arrays.
% The scaled scores are rounded to the nearest integer.
% The maximum, minimum, and range values of wealthy_scores are computed again.
% Overall, this script reads scores from a TSV file, matches them with image names, computes and scales the scores, and saves the processed scores to separate mat files.

clear;
safe_yes = "50a68a51fdc9f05596000002";
lively_yes = "50f62c41a84ea7c5fdd2e454";
boring_yes ="50f62c68a84ea7c5fdd2e456";
wealthy_yes = "50f62cb7a84ea7c5fdd2e458";
depressing_yes = "50f62ccfa84ea7c5fdd2e459";
beautiful_yes = "5217c351ad93a7d3e7b07a64";

source_directory = './small_dataset/';
A =dir( fullfile(source_directory, '*.JPG') );
number_of_img = length(A);

% image_names_array = repmat(' ',number_of_img , 24);
% for i=1 : number_of_img
%     
%     [dummy, ext] = fileparts(A(i).name);
%     image_names_array(i,:) = ext;
%     
% end
% save('image_names_in_dataset.mat','image_names_array');
 image_names_array_read_matrix = matfile('image_names_in_dataset.mat');
 image_names_array = image_names_array_read_matrix.image_names_array;

% s = tdfread('qscores-2.tsv');
% image_ids = s.location_id;
% save('image_ids_in_qscores_file.mat','image_ids');
image_ids_read_matrix = matfile('image_ids_in_qscores_file.mat');
image_ids = image_ids_read_matrix.image_ids;
% matrisim_benim = ananin_ami.image_ids;
% study_ids = s.study_id;
% save('study_ids_in_qscores_file.mat','study_ids');
study_ids_read_matrix = matfile('study_ids_in_qscores_file.mat');
study_ids = study_ids_read_matrix.study_ids ;

% score_ids = s.trueskill0x2Escore ;
% save('scores_in_qscores_file.mat','score_ids');
score_ids_read_matrix = matfile('scores_in_qscores_file.mat');
score_ids = score_ids_read_matrix.score_ids;



total_lines_in_tsv = length(score_ids);
% index_safe = 1;
% index_wealthy=1;
% safe_scores = zeros(number_of_img,1);
% wealthy_scores = zeros(number_of_img,1);
% for i = 1 : number_of_img
%     
%     my_image_name = image_names_array(i,:);
%     for k =1 : total_lines_in_tsv
%         if my_image_name == image_ids(k,:)
%             
%             if study_ids(k,:)==safe_yes
%                 safe_scores(index_safe) = score_ids(k);
%                 index_safe = index_safe +1;
%             elseif study_ids(k,:) == wealthy_yes
%                 wealthy_scores(index_wealthy) = score_ids(k);
%                 index_wealthy = index_wealthy +1;
%                 
%             end
%         end
%     end
%     i
% end
% save('safe_scores.mat','safe_scores');
% save('wealthy_scores.mat','wealthy_scores');
safe_scores_read_matrix = matfile('safe_scores.mat');
safe_scores = safe_scores_read_matrix.safe_scores;
wealthy_scores_read_matrix = matfile('wealthy_scores.mat');
wealthy_scores = wealthy_scores_read_matrix.wealthy_scores;




maximum_of_safe_scores = max(safe_scores);
minimum_of_safe_scores = min(safe_scores);
range_safe_scores = maximum_of_safe_scores -minimum_of_safe_scores;
scaled_safe_scores = zeros(number_of_img,1);
for i = 1 : number_of_img
    scaled_safe_scores(i) = 10* ((safe_scores(i)-minimum_of_safe_scores) / range_safe_scores) ;
    scaled_safe_scores(i) = round(scaled_safe_scores(i));
end
maximum_of_wealthy_scores = max(wealthy_scores);
minimum_of_wealthy_scores = min(wealthy_scores);
range_wealthy_scores = maximum_of_wealthy_scores -minimum_of_wealthy_scores;
scaled_wealthy_scores = zeros(number_of_img,1);
for i = 1 : number_of_img
    scaled_wealthy_scores(i) = 10* ((wealthy_scores(i)-minimum_of_wealthy_scores) / range_wealthy_scores) ;

    scaled_wealthy_scores(i) = round(scaled_wealthy_scores(i));
end


% This script appears to be processing safe scores from a TSV file and matching them with corresponding image files. Here's what the script does:
% 
% Clears all existing variables in the workspace.
% Initializes variables with string values representing different categories (safe_yes, lively_yes, etc.).
% Uses the tdfread function to read a TSV file called 'qscores-2 copy.tsv' into a struct array s containing fields such as location_id, study_id, and trueskill0x2Escore.
% Extracts the location_id, study_id, and trueskill0x2Escore fields from s and assigns them to separate variables (image_ids, study_ids, score_ids).
% Determines the length of score_ids to get the total number of images.
% Initializes a variable index to keep track of the number of safe scores found.
% Starts a loop to process each score and study ID.
% Inside the loop, if the study ID matches the safe_yes value, the score and corresponding image ID are stored in safe_scores and study_safe_images arrays, respectively.
% After each iteration of the loop, index is incremented.
% Computes the maximum and minimum values of safe_scores.
% Calculates the range of scores.
% Computes the length of safe_scores.
% Starts another loop to scale the safe scores from 0 to 10 based on the computed range and stores them in scaled_safe_scores.
% The loop completes the processing of scores from the TSV file.
% Sets the source_directory variable to the path of the directory containing the images.
% Uses the dir function to list all files in the source_directory that have the ".JPG" extension. The file names and information are stored in the A struct array.
% Determines the number of images in the source_directory based on the length of A.
% Starts a loop to process each safe score and find the corresponding image file.
% Inside the loop, the important part of the image file name (safe_image_important_part) is extracted from study_safe_images.
% Another loop iterates over the image files in the source_directory to find a match for the important part of the image file name.
% If a match is found, the corresponding image file is read using imread.
% The progress is printed for each image file.
% The loop completes the processing of safe scores and matching with image files.
% Overall, this script matches safe scores from a TSV file with corresponding image files and reads the matched image files using imread.

clear;
safe_yes = "50a68a51fdc9f05596000002";
lively_yes = "50f62c41a84ea7c5fdd2e454";
boring_yes ="50f62c68a84ea7c5fdd2e456";
wealthy_yes = "50f62cb7a84ea7c5fdd2e458";
depressing_yes = "50f62ccfa84ea7c5fdd2e459";
beautiful_yes = "5217c351ad93a7d3e7b07a64";
s = tdfread('qscores-2 copy.tsv');
image_ids = s.location_id;
study_ids = s.study_id;
score_ids = s.trueskill0x2Escore ;
length_of_images = length(score_ids);
index = 1;
for i = 1 : length_of_images
    if study_ids(i,:) == safe_yes 
        safe_scores(index) = score_ids(i);
        study_safe_images(index,:) = image_ids(i,:);
        index = index+1;
    end
end
maximum_of_scores = max(safe_scores);
minimum_of_scores = min(safe_scores);
range = maximum_of_scores -minimum_of_scores;
length_of_safe_scores = length(safe_scores);
scaled_safe_scores = zeros(length_of_safe_scores,1);
for i = 1 : length_of_safe_scores
    scaled_safe_scores(i) = 10* ((safe_scores(i)-minimum_of_scores) / range) ;

    
end

source_directory = './images/';
% dataset_list = dir(source_directory);
A =dir( fullfile(source_directory, '*.JPG') );
number_of_img = length(A);

% image name changes
% A =dir( fullfile(source_directory, '*.JPG') );
% number_of_img = length(A);
% images_imp_part = repmat(' ',number_of_img , 24);
% 
% for i = 1 : number_of_img
% 
%     
% fileNames = { A(i).name };
% char_fileNames = char(fileNames);
% splitted = split(char_fileNames,"_");
% char_splitted = char(splitted(3));
% images_imp_part(i,:)=char_splitted;
% 
% newName = fullfile(source_directory, sprintf( '%s.JPG', images_imp_part(i,:) ) );
% cell_of_image_name = fullfile(source_directory, fileNames);
% my_char = char(cell_of_image_name);
%   movefile( my_char, newName );    
% end








for i=1 : length_of_safe_scores
 safe_image_important_part = study_safe_images(i,:) ; 
 for k=1 : number_of_img
    [dummy, ext] = fileparts(A(k).name);
 
     if safe_image_important_part == ext
         
        image_name = A(k).name;
        image_path = strcat(source_directory, image_name);
        current_image = imread(image_path);
        fprintf(1, 'Now reading %s\n', image_name);
     end
     
 end
 
    
end

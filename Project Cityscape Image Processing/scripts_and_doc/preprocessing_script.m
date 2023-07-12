% This script is performing preprocessing on a small dataset of images. Here's what the script does:
% 
% Sets the source_directory variable to the path of the directory containing the original images.
% Sets the target_directory variable to the path of the directory where the preprocessed images will be saved.
% Uses the dir function to list all files in the source_directory that have the ".JPG" extension. The file names and information are stored in the A struct array.
% Determines the number of images in the dataset based on the length of A.
% Defines the crop_window variable, which specifies the rectangular region to be cropped from each image. The format of the crop_window is [xmin ymin width height].
% Starts a loop to process each image in the dataset.
% Inside the loop, the name and path of the current image are retrieved from A.
% The original image is read using imread.
% The imcrop function is used to crop the image based on the crop_window.
% The cropped image is then denoised using the wiener2 filter separately for each color channel (RGB).
% The denoised image is enhanced using histogram equalization (histeq) separately for each color channel.
% The enhanced image is sharpened using imsharpen.
% The target path for the preprocessed image is created by concatenating the target_directory and image_name.
% The preprocessed image (sharpened_image) is saved using imwrite at the target path.
% After each iteration of the loop, the index i is printed to track the progress.
% Overall, this script crops, denoises, enhances, and sharpens each image in the dataset and saves the preprocessed images in a separate directory.

clear all;
source_directory = './small_dataset/';
target_directory = './preprocessed_small_dataset/';
A =dir( fullfile(source_directory, '*.JPG') );
number_of_img = length(A);
crop_window = [1 1 400 270];

for i=1:number_of_img
    image_name = A(i).name;
    image_path = strcat(source_directory, image_name);
    original_image = imread(image_path);
    
    cropped_image = imcrop(original_image, crop_window);
    
    denoised_image(:,:,1) = wiener2(cropped_image(:,:,1));
    denoised_image(:,:,2) = wiener2(cropped_image(:,:,2));
    denoised_image(:,:,3) = wiener2(cropped_image(:,:,3));
    enhanced_image(:,:,1) = histeq(denoised_image(:,:,1));
    enhanced_image(:,:,2) = histeq(denoised_image(:,:,2));
    enhanced_image(:,:,3) = histeq(denoised_image(:,:,3));
    sharpened_image = imsharpen(enhanced_image);
    
    target_path = strcat(target_directory, image_name);
    imwrite(sharpened_image, target_path);
    i
end
% This script demonstrates the usage of the GIST (Generic Image Structure) descriptor in MATLAB. GIST is a low-level visual descriptor that captures the global scene properties of an image. The script includes two examples, each computing the GIST descriptor for a different input image.
% 
% Example 1:
% 
% Load an image (demo1.jpg) using the imread function.
% Define the parameters for computing the GIST descriptor. The parameters include:
% param.imageSize: The desired size of the image. If not specified, the current image size is used.
% param.orientationsPerScale: The number of orientations for each scale in the Gabor filter bank.
% param.numberBlocks: The number of spatial divisions for collecting statistics.
% param.fc_prefilt: The prefilter scale for the input image.
% Compute the GIST descriptor for the input image using the LMgist function. The function takes the image, an empty string (to omit saving intermediate results), and the parameter structure. It returns the GIST descriptor (gist1) and the updated parameter structure.
% Visualize the results by displaying the input image and the GIST descriptor using the imshow and showGist functions.
% Example 2:
% 
% Load another image (demo2.jpg) using the imread function.
% Define the parameters for computing the GIST descriptor (same as in Example 1).
% Compute the GIST descriptor for the input image using the LMgist function, as in Example 1.
% Visualize the results by displaying the input image and the GIST descriptor.
% Note: The showGist function is used to visualize the GIST descriptor. It displays a bar plot that represents the energy distribution across different GIST features.



% EXAMPLE 1
% Load image
img1 = imread('demo1.jpg');

% Parameters:
clear param
param.imageSize = [256 256]; % it works also with non-square images
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Computing gist requires 1) prefilter image, 2) filter image and collect
% output energies
[gist1, param] = LMgist(img1, '', param);

% Visualization
figure
subplot(121)
imshow(img1)
title('Input image')
subplot(122)
showGist(gist1, param)
title('Descriptor')


% EXAMPLE 2
% Load image (this image is not square)
img2 = imread('demo2.jpg');

% Parameters:
clear param 
%param.imageSize. If we do not specify the image size, the function LMgist
%   will use the current image size. If we specify a size, the function will
%   resize and crop the input to match the specified size. This is better when
%   trying to compute image similarities.
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Computing gist requires 1) prefilter image, 2) filter image and collect
% output energies
[gist2, param] = LMgist(img2, '', param);

% Visualization
figure
subplot(121)
imshow(img2)
title('Input image')
subplot(122)
showGist(gist2, param)
title('Descriptor')




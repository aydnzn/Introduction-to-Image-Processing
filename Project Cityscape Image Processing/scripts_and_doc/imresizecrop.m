% The function takes three input arguments: img, which is the input image, M, which specifies the desired output size, and METHOD, which is the interpolation method used for resizing. If the METHOD argument is not provided, it defaults to 'bilinear'.
% If M is a scalar value, it is interpreted as a square size, and the function creates a 2-element vector [M(1) M(1)].
% The function calculates the scaling factor needed to resize the image based on the desired output size. It chooses the maximum scaling factor to ensure that the entire image fits within the output size.
% It calculates the new size of the image by multiplying the original size with the scaling factor and rounding the result to the nearest integer.
% It resizes the image using the imresize function with the specified interpolation method.
% It determines the starting row (sr) and column (sc) indices for cropping the resized image. These indices ensure that the cropped region is centered within the desired output size.
% It extracts the cropped region from the resized image using the calculated indices.
% The cropped image is assigned to the img variable, which is then returned as the output of the function.

function img = imresizecrop(img, M, METHOD)
%
% img = imresizecrop(img, M, METHOD);
%
% Output an image of size M(1) x M(2).

if nargin < 3
    METHOD = 'bilinear';
end

if length(M) == 1
    M = [M(1) M(1)];
end

scaling = max([M(1)/size(img,1) M(2)/size(img,2)]);

%scaling = M/min([size(img,1) size(img,2)]);

newsize = round([size(img,1) size(img,2)]*scaling);
img = imresize(img, newsize, METHOD);

[nr nc cc] = size(img);

sr = floor((nr-M(1))/2);
sc = floor((nc-M(2))/2);

img = img(sr+1:sr+M(1), sc+1:sc+M(2),:);


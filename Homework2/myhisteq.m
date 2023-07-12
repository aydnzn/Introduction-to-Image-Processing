function [out_image] = myhisteq(in_image)
%Summary of this function goes here
%This function is a histogram equalization function.

%It's input can be a RGB image or a gray scale image.
%If the image is a gray image, it converts the original image to its
%grayscale equivalent.

%   Detailed explanation goes here
%check if the image is gray or not

if(size(in_image,3)>1)
    in_image=rgb2gray(in_image);
    %show the grayscale version of the image
    figure(23);
    imshow(in_image);
    title('Original Image (Grayscale)');
end

% take the size of image and create the output image
row= size(in_image,1);
column= size(in_image,2);
out_image = uint8(zeros(row,column));


%QL = 256 is the number of quantization levels, which is 256 for gray scale
%images.
QL=256;

%These are intermediary parameters used to calculate the histogram
%equalized image.
f = zeros(QL,1);
pdf = zeros(QL,1);
cdf = zeros(QL,1);
cum = zeros(QL,1);
out = zeros(QL,1);

for i=0:255
    f(i+1)=sum(sum(in_image==i));
end

%calculate the probability distribution function
pdf=f/(row*column);

% calculate cumulative distribution function 
dummy=0;
for i=1:size(pdf)
    dummy = dummy + f(i);
    cum(i) = dummy;
    cdf(i) = cum(i) / (row*column);
    out(i) = round(cdf(i)*(QL-1));
end

%calculate output image
for i = 1:row
    for j=1:column
        out_image(i,j) = out(in_image(i,j)+1);
    end
end


end


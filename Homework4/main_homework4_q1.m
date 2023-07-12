%% Aydın Uzun
% HW 4
% Q1
%%
clear all;
clf;
%% Unsharp Masking and High-Boost Filtering
%a
chest = imread('chestXray.tif');
[m, n]=size(chest);
p=m/2;
q=n/2;
d0=50; % empirically
horizontal = 1:m;
vertical = 1:n;

for i=1:m
    for j=1:n
        distance=sqrt((i-p)^2+(j-q)^2);
        G(i,j)=1-exp(-(distance)^2/(2*(d0^2)));
    end
end

figure(1);
imagesc(horizontal,vertical,G),colorbar;
colormap(flipud(jet));
xlabel('Columns');
ylabel('Rows');


%b
chest_FT=fft2(double(chest));
chest_shift=fftshift(chest_FT);
chest_out_of_G=chest_shift.*G;
image_back_shifted=ifftshift(chest_out_of_G);
image_filter_applied=abs(ifft2(image_back_shifted));
image_filter_applied=im2uint8(mat2gray(image_filter_applied));

figure(2)
imshow(image_filter_applied, [0 25]); % ranges chosen empirically
%c
k = 1;
high_boost_1 = (1+k*G).*chest_shift;
k=1.6 ;
high_boost_1_6 = (1+k*G).*chest_shift;

high_boost_1_back_shifted=ifftshift(high_boost_1);
high_boost_1_6_back_shifted=ifftshift(high_boost_1_6);

image_filter_applied_k_1=abs(ifft2(high_boost_1_back_shifted));
image_filter_applied_k_1_6=abs(ifft2(high_boost_1_6_back_shifted));

image_filter_applied_k_1=im2uint8(mat2gray(image_filter_applied_k_1));
image_filter_applied_k_1_6=im2uint8(mat2gray(image_filter_applied_k_1_6));

figure(3);
imshow(image_filter_applied_k_1);

figure(4);
imshow(image_filter_applied_k_1_6);

%d
histeq_image_filter_applied_k_1 = histeq(image_filter_applied_k_1);
histeq_image_filter_applied_k_1_6 = histeq(image_filter_applied_k_1_6);

figure(5);
imshow(histeq_image_filter_applied_k_1);

figure(6);
imshow(histeq_image_filter_applied_k_1_6);
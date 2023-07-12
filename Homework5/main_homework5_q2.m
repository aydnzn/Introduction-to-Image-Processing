%% Aydın Uzun
% HW 5 06.12.2018
%% question 2
clear all;
apartments = imread('Apartments.png');
apartment_gaussian_filtered = imgaussfilt(apartments, 1);
figure(7);
imshow(apartment_gaussian_filtered);
[gmag, gdir] = imgradient(apartment_gaussian_filtered);
%a)
figure(1);
histogram(gmag);
xlabel(' range of maginutude ');
ylabel(' number of pixels ');

figure(2);
histogram(gdir);
xlabel(' range of direction ');
ylabel(' number of pixels ');

max_of_gmag = max(max(gmag));
min_of_gmag =  min(min(gmag));
apartment_normalized = gmag/(max_of_gmag - min_of_gmag);
sorted_apartment = sort(apartment_normalized(:));
percentile_point_95 = sorted_apartment(round(length(sorted_apartment)*0.95));
percentile_point_80 = sorted_apartment(round(length(sorted_apartment)*0.80));
percentile_point_70 = sorted_apartment(round(length(sorted_apartment)*0.70));
%b find edge candidates
high_thereshold_95 = imbinarize(apartment_normalized, percentile_point_95);
high_thereshold_80 = imbinarize(apartment_normalized, percentile_point_80);
low_thereshold_70 = imbinarize(apartment_normalized, percentile_point_70);

figure(3);
imshow(high_thereshold_95);
figure(4);
imshow(high_thereshold_80);
figure(5);
imshow(low_thereshold_70);

%c)
% https://www.mathworks.com/matlabcentral/fileexchange/44648-hysteresis-thresholding-for-3d-images-or-2d
index = find(high_thereshold_95);
seed_indices=sub2ind(size(low_thereshold_70), index);
seed_indices_2=sub2ind(size(high_thereshold_80), index);
hys=imfill(~low_thereshold_70, seed_indices, 8);
hys_2=imfill(~high_thereshold_80, seed_indices_2, 8);

hys=hys & low_thereshold_70;
hys_2=hys_2 & high_thereshold_80;

figure(6);
imshow(hys);
figure(10);
imshow(hys_2);
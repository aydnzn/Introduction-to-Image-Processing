%% AYDIN UZUN
%% 2015401210
%% 26.10.2018
%% HW#3
clear all;
%% MEAN vs MEDIAN
clear;
X = zeros(8,8);
X = uint8(X);
X(1:4,2)=41;
X(3:6,3)=41;
X(4:8,4)=41;
X(3:6,5)=41;
X(1:4,6)=41;
for i = 1:8
    for j=1:8
        if X(i,j)==0
            X(i,j)=14;
        end
    end
end
filter_a = ones(1,3)/3;
X_filtered_A = imfilter(X,filter_a);
Difference_A = double(X_filtered_A) - double(X);
largest_increase_in_brightness_A = max(max(Difference_A));
counter_a = 0;
for i = 1:8
    for j=1:8
        if X(i,j)~=X_filtered_A(i,j)
            counter_a= counter_a + 1;
        end
    end
end
%% b
X_filtered_B = medfilt2(X,[1 3]) ;
counter_b = 0;
for i = 1:8
    for j=1:8
        if X(i,j)~=X_filtered_B(i,j)
            counter_b= counter_b + 1;
        end
    end
end
Difference_B = double(X_filtered_B) - double(X);
largest_increase_in_brightness_B = max(max(Difference_B));

%% CONNECTIVITY and PATH LENGTH
%Answered on the report with explanation.
%% ESTIMATION of NOISE PARAMETERS
clear;
BBC_not_contaminated  = imread('BBC_testcard.png');
BBC_contaminated  = imread('bbc_rayleigh, a=30, b=340.png');
Lena_not_contaminated = imread('lena.bmp');
Lena_contaminated = imread('lena_rayl, a=0, b=448.bmp');
%a

figure(1);
subplot(2,2,1);
imhist(BBC_not_contaminated);
title('BBC');

subplot(2,2,2);
imhist(BBC_contaminated);
title('contaminated BBC');

subplot(2,2,3);
imhist(Lena_not_contaminated);
title('lena');

subplot(2,2,4);
imhist(Lena_contaminated);
title('contaminated lena');

%b)
Difference_BBC= BBC_contaminated - BBC_not_contaminated ;
Difference_Lena = Lena_contaminated - Lena_not_contaminated ;
standard_dev_BBC = std2(Difference_BBC);
standard_dev_Lena = std2(Difference_Lena);
variance_BBC = standard_dev_BBC * standard_dev_BBC;
variance_Lena = standard_dev_Lena * standard_dev_Lena;
b_BBC = (4* variance_BBC) / (4-pi);
b_Lena = (4* variance_Lena) / (4-pi);
a_BBC = mean2(Difference_BBC) - sqrt((pi*b_BBC)/4);
a_Lena = mean2(Difference_Lena) - sqrt((pi*b_Lena)/4);

%% GAUSSIAN NOISE
% % Contaminate the Pentagon image with Gaussian noise N(0, 1000).
% % Clip underflows and overflows. Plot the original and noisy images side by side.
% % To denoise the images,
% % apply the following filters, calculate and tabulate the PSNR and SSIM values,
% % and plot filtered images.
clear;
I = imread('pentagon.tiff');
sigma = sqrt(1000);
array_gaussian_noise = randn(1024,1024)*sigma;
I_double = double(I);
noisy_I = I_double + array_gaussian_noise ;
for i = 1 : 1024
    for j = 1 : 1024
        if noisy_I(i,j)>255
            noisy_I(i,j)= 255;
        end
        if noisy_I(i,j)<0
            noisy_I(i,j)= 0;
        end
        
    end
end
noisy_I = uint8(noisy_I);

figure(2);

subplot(1,2,1);
imshow(noisy_I);
title('noisy image');

subplot(1,2,2);
imshow(I);
title('original image');


%a) 5x5 box filter, that is the mean filter,
five_by_five_box = 1/25*ones(5);
I_denoise_a = imfilter(noisy_I,five_by_five_box);

figure(3);
imshow(I_denoise_a);
title('5x5 box PSNR= 25.2422 SSIM= 0.5480');

PSNR_a = psnr(I_denoise_a,I);
SSIM_a = ssim(I_denoise_a,I);

%b)
Filter_B = (1/4.8976).* [0.3679,0.6065,0.3679;0.6065,1,0.6065;0.3679,0.6065,0.3679];
I_denoise_b = imfilter(noisy_I,Filter_B);

figure(4);
imshow(I_denoise_b);
title('Gaussian with sigma = 1 PSNR= 25.3459 SSIM= 0.5488');

PSNR_b = psnr(I_denoise_b,I);
SSIM_b = ssim(I_denoise_b,I);


Filter_B_2 = fspecial('gaussian',3,2.5);
I_denoise_b_2 = imfilter(noisy_I,Filter_B_2);

figure(5);
imshow(I_denoise_b_2);
title('Gaussian with sigma = 2,5 PSNR= 25.2502 SSIM= 0.5359');

PSNR_b_2 = psnr(I_denoise_b_2,I);
SSIM_b_2 = ssim(I_denoise_b_2,I);

%c)c) Median filter with size 5x5,
I_denoise_c = medfilt2(noisy_I,[5 5]) ;

figure(6);
imshow(I_denoise_c);
title('Median filter with size 5x5 PSNR= 25.0468 SSIM= 0.5166');

PSNR_c = psnr(I_denoise_c,I);
SSIM_c = ssim(I_denoise_c,I);

%d d) 5x5 alpha-trimmed filter with trimming parameter p = 3.
p=3;
I_denoise_d = alphatrim(noisy_I,5,p);

figure(7);
imshow(I_denoise_d);
title('5x5 alpha trimmed filter with trimming parameter p=3 PSNR= 25.2447 SSIM= 0.5473');

PSNR_d = psnr(I_denoise_d,I);
SSIM_d = ssim(I_denoise_d,I);


%e) e) Geometric mean filter in a 5x5 neighborhood
% https://blogs.mathworks.com/steve/2008/07/07/nonlinear-operations-using-imfilter/
h = ones(5,5);
double_noisy_I = double(noisy_I);
dummy = imfilter(log(double_noisy_I), h, 'replicate');
dummy2 = exp(dummy);
I_denoise_e = dummy2 .^ (1/numel(h));

figure(8);
I_denoise_e = uint8(I_denoise_e);
imshow(I_denoise_e);
title('Geometric mean filter in a nbhood 5x5 PSNR= 23.5262 SSIM= 0.5336');

PSNR_e = psnr(I_denoise_e,I);
SSIM_e = ssim(I_denoise_e,I);

%f) Harmonic mean filter in a 5x5 neighborhood
% http://fourier.eng.hmc.edu/e161/dipum/spfilt.m
h = ones(5,5);
double_noisy_I = double(noisy_I);
dummy = imfilter(1./(double_noisy_I+eps), h, 'replicate');
I_denoise_f = numel(h)./dummy;
I_denoise_f= uint8(I_denoise_f);

figure(9);
imshow(I_denoise_f);
title('Harmonic mean filter with size 5x5 PSNR= 21.9110 SSIM= 0.5066');


PSNR_f = psnr(I_denoise_f,I);
SSIM_f = ssim(I_denoise_f,I);

%e) Contraharmonic filter with Q = 2.
% http://fourier.eng.hmc.edu/e161/dipum/spfilt.m
double_noisy_I = double(noisy_I);q=2;
g = imfilter(double_noisy_I.^(q+1), ones(5, 5), 'replicate');
g = g ./ (imfilter(double_noisy_I.^q, ones(5, 5), 'replicate') + eps);
I_denoise_g= uint8(g);

figure(10);
imshow(I_denoise_g);
title('Contraharmonic filter with size 5x5 and Q=2 PSNR= 21.3642 SSIM= 0.5183');


PSNR_g = psnr(I_denoise_g,I);
SSIM_g = ssim(I_denoise_g,I);

%% 
clear;
I = imread('rose.bmp');
d = 0.15;
I_sp_15 = imnoise(I,'salt & pepper',d);

figure(11);

subplot(1,2,1);
imshow(I);
title('original image');

subplot(1,2,2);
imshow(I_sp_15);
title(' contaminated with 15% salt and pepper noise');

% I_alpha_denoised_3 = alphatrim(I_sp_15,3,3);
% I_alpha_denoised_5 = alphatrim(I_sp_15,5,3);
% I_alpha_denoised_7 = alphatrim(I_sp_15,7,3);
% I_alpha_denoised_9 = alphatrim(I_sp_15,9,3);
% I_alpha_denoised_17 = alphatrim(I_sp_15,17,3);
I_med_denoised_3 = medfilt2(I_sp_15,[3 3]);
I_med_denoised_5 = medfilt2(I_sp_15,[5 5]);
I_med_denoised_7 = medfilt2(I_sp_15,[7 7]);
I_med_denoised_9 = medfilt2(I_sp_15,[9 9]);
I_med_denoised_17 = medfilt2(I_sp_15,[17 17]);

% figure(11);
% imshow(I_alpha_denoised_3);
% figure(12);
% imshow(I_alpha_denoised_5);
% figure(13);
% imshow(I_alpha_denoised_7);
% figure(14);
% imshow(I_alpha_denoised_9);
% figure(15);
% imshow(I_alpha_denoised_17);

figure(12);
imshow(I_med_denoised_3); 

figure(13);
imshow(I_med_denoised_5); 

figure(14);
imshow(I_med_denoised_7); 

figure(15);
imshow(I_med_denoised_9); 

figure(16);
imshow(I_med_denoised_17); 

number_of_noised_Pixels_salt_pepper_15=length(find(I_sp_15==0 | I_sp_15==255));
number_of_noised_Pixels_med_denoised_3=length(find(I_med_denoised_3==0 | I_med_denoised_3==255));
number_of_noised_Pixels_med_denoised_5=length(find(I_med_denoised_5==0 | I_med_denoised_5==255));
number_of_noised_Pixels_med_denoised_7=length(find(I_med_denoised_7==0 | I_med_denoised_7==255));
number_of_noised_Pixels_med_denoised_9=length(find(I_med_denoised_9==0 | I_med_denoised_9==255));
number_of_noised_Pixels_med_denoised_17=length(find(I_med_denoised_17==0 | I_med_denoised_17==255));


percentage_noise_removed_by_med_3 = number_of_noised_Pixels_med_denoised_3 / number_of_noised_Pixels_salt_pepper_15;
percentage_noise_removed_by_med_3 = (1-percentage_noise_removed_by_med_3)*100;
percentage_noise_removed_by_med_5 = number_of_noised_Pixels_med_denoised_5 / number_of_noised_Pixels_salt_pepper_15;
percentage_noise_removed_by_med_5 = (1-percentage_noise_removed_by_med_5)*100;
percentage_noise_removed_by_med_7 = number_of_noised_Pixels_med_denoised_7 / number_of_noised_Pixels_salt_pepper_15;
percentage_noise_removed_by_med_7 = (1-percentage_noise_removed_by_med_7)*100;
percentage_noise_removed_by_med_9 = number_of_noised_Pixels_med_denoised_9 / number_of_noised_Pixels_salt_pepper_15;
percentage_noise_removed_by_med_9 = (1-percentage_noise_removed_by_med_9)*100;
percentage_noise_removed_by_med_17 = number_of_noised_Pixels_med_denoised_17 / number_of_noised_Pixels_salt_pepper_15;
percentage_noise_removed_by_med_17 = (1-percentage_noise_removed_by_med_17)*100;


x = [3,5,7,9,17];
y=[percentage_noise_removed_by_med_3,percentage_noise_removed_by_med_5,percentage_noise_removed_by_med_7,percentage_noise_removed_by_med_9,percentage_noise_removed_by_med_17];

figure(17);
scatter(x,y,'filled');
xlabel('window size ');
ylabel('percentage of S&P noise removed by the median filter ');

% 3.	
% how to detect best alpha value ?
% % % % PSNR_windowsize_3 = zeros(1,15);
% % % % for i = 1 : 15
% % % %         I_alpha_denoised_i = alphatrim(I_sp_15,3,i);
% % % %         I_alpha_denoised_i = uint8(I_alpha_denoised_i);
% % % %         figure;
% % % %         imshow(I_alpha_denoised_i);
% % % %         PSNR_windowsize_3(i) = psnr(I_alpha_denoised_i,I);
% % % % 
% % % % end
% % % % % best PSNR scenario for windows size 3 is when p = 4.
% % % % PSNR_windowsize_5 = zeros(1,15);
% % % % for i = 1 : 15
% % % %         I_alpha_denoised_i = alphatrim(I_sp_15,5,i);
% % % %         I_alpha_denoised_i = uint8(I_alpha_denoised_i);
% % % %         figure;
% % % %         imshow(I_alpha_denoised_i);
% % % %         PSNR_windowsize_5(i) = psnr(I_alpha_denoised_i,I);
% % % % 
% % % % end
% % % % % best PSNR scenario for windows size 5 is when p = 11.
% % % % 
% % % % PSNR_windowsize_7 = zeros(1,40);
% % % % for i = 1 : 40
% % % %         I_alpha_denoised_i = alphatrim(I_sp_15,7,i);
% % % %         I_alpha_denoised_i = uint8(I_alpha_denoised_i);
% % % %         figure;
% % % %         imshow(I_alpha_denoised_i);
% % % %         PSNR_windowsize_7(i) = psnr(I_alpha_denoised_i,I);
% % % % 
% % % % end
% % % % % best PSNR scenario for windows size 7 is when p = 23.
% % % % 
% % % % PSNR_windowsize_9 = zeros(1,20);
% % % % for i = 31 : 50
% % % %         I_alpha_denoised_i = alphatrim(I_sp_15,9,i);
% % % %         I_alpha_denoised_i = uint8(I_alpha_denoised_i);
% % % %         figure;
% % % %         imshow(I_alpha_denoised_i);
% % % %         PSNR_windowsize_9(i) = psnr(I_alpha_denoised_i,I);
% % % % 
% % % % end
% % % % % best PSNR scenario for windows size 9 is when p = 38.
% % % % PSNR_windowsize_17 = zeros(1,50);
% % % % for i = 100 : 150
% % % %         I_alpha_denoised_i = alphatrim(I_sp_15,17,i);
% % % %         I_alpha_denoised_i = uint8(I_alpha_denoised_i);
% % % %         figure;
% % % %         imshow(I_alpha_denoised_i);
% % % %         PSNR_windowsize_17(i) = psnr(I_alpha_denoised_i,I);
% % % % 
% % % % end
% % % % % best PSNR scenario for windows size 17 is when p = 127.

p_window_3 = 4;
p_window_5 = 11;
p_window_7 = 23;
p_window_9 = 38;
p_window_17 = 127;


I_alpha_denoised_3_p4 = alphatrim(I_sp_15,3,4);
I_alpha_denoised_5_p11 = alphatrim(I_sp_15,5,11);
I_alpha_denoised_7_p23 = alphatrim(I_sp_15,7,23);
I_alpha_denoised_9_p38 = alphatrim(I_sp_15,9,38);
I_alpha_denoised_17_p127 = alphatrim(I_sp_15,17,127);
PSNR_windowsize_3 = psnr(I_alpha_denoised_3_p4,I);
PSNR_windowsize_5 = psnr(I_alpha_denoised_5_p11,I);
PSNR_windowsize_7 = psnr(I_alpha_denoised_7_p23,I);
PSNR_windowsize_9 = psnr(I_alpha_denoised_9_p38,I);
PSNR_windowsize_17 = psnr(I_alpha_denoised_17_p127,I);

figure(18);
imshow(I_alpha_denoised_3_p4);
title('3x3 alpha-trimmed filter with trimming parameter p = 4. PSNR = 31.9105');

figure(19);
imshow(I_alpha_denoised_5_p11);
title('5x5 alpha-trimmed filter with trimming parameter p = 11. PSNR = 31.5590');

figure(20);
imshow(I_alpha_denoised_7_p23);
title('7x7 alpha-trimmed filter with trimming parameter p = 23. PSNR = 30.2199');

figure(21);
imshow(I_alpha_denoised_9_p38);
title('9x9 alpha-trimmed filter with trimming parameter p =38. PSNR = 28.8977');

figure(22);
imshow(I_alpha_denoised_17_p127);
title('17x17 alpha-trimmed filter with trimming parameter p = 127. PSNR = 25.6601');


x = [3,5,7,9,17];
y=[PSNR_windowsize_3,PSNR_windowsize_5,PSNR_windowsize_7,PSNR_windowsize_9,PSNR_windowsize_17];

figure(23);
scatter(x,y,'filled');
xlabel('window size');
ylabel('PSNR figure ');

%%
clear;

I = imread('rose.bmp');
salt_pepper_percentage=0.05:0.05:0.5;
window_size=[3,5,7,9,11,17,23];
number_of_noised_Pixels_salt_pepper = zeros(length(salt_pepper_percentage),1);
nofNoise = zeros(length(salt_pepper_percentage),length(window_size));
nonNoise = zeros(length(salt_pepper_percentage),length(window_size));
pecentage_of_noise_removed_by_med= zeros(length(salt_pepper_percentage),length(window_size));
PSNR_f = zeros(length(salt_pepper_percentage),length(window_size));
saltpepper_noise_vector = zeros(1,length(salt_pepper_percentage));
[m,n]=size(I);

for i=1:length(salt_pepper_percentage)
salt_pepper_noised = imnoise(I,'salt & pepper',salt_pepper_percentage(i));
number_of_noised_Pixels_salt_pepper(i) = sum(sum(I ~=salt_pepper_noised));
saltpepper_noise_vector(i) = number_of_noised_Pixels_salt_pepper(i)./ (m*n);

for k=1:length(window_size)
    f=medfilt2(salt_pepper_noised,[window_size(k) window_size(k)],'symmetric');
    PSNR_f(i,k) = psnr(f,I);
    nofNoise(i,k)=length(find(f==0 | f==255));
    pecentage_of_noise_removed_by_med(i,k) = nofNoise(i,k) / number_of_noised_Pixels_salt_pepper(i) ;
    pecentage_of_noise_removed_by_med(i,k) = (1-pecentage_of_noise_removed_by_med(i,k)).*100;
end
end

saltpepper_noise_vector = saltpepper_noise_vector * 100;

figure(24);
colormap(flipud(jet));
imagesc(saltpepper_noise_vector,window_size,PSNR_f),colorbar;
xlabel('S&P noise as a percentage of pixels affected');
ylabel('window size');





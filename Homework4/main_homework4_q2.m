%% Aydın Uzun
% HW 4
% Q2
%%
clear all;
%% Moiré Noise Removal
clear;
clf;
%a
car = imread('car-moire-pattern.tif');
car_fft = fft2(car);
car_fft_shifted = fftshift(car_fft);

car_fft_shifted_abs = abs(car_fft_shifted);
car_fft_shifted_abs = log(car_fft_shifted_abs+1); % Use log for perceptual scaling and +1 since log(0) is undefined
car_magnitude_spectrum=im2uint8(mat2gray(car_fft_shifted_abs));

figure(7);
mesh(car_magnitude_spectrum);
xlabel('columns');
ylabel('rows');
zlabel('magnitude');
%b
car = imread('car-moire-pattern.tif');
diameter_estimation = car;
peak_estimation = car;
[x, y] = size(car);

for i = 1 : x
    for j = 1 : y
        if double(car_magnitude_spectrum(i,j))<130
            peak_estimation(i,j) =0;
        elseif double(car_magnitude_spectrum(i,j))>130
            peak_estimation(i,j) =255;
        end
        
        
        
    end
end

for i = 1 : x
    for j = 1 : y
        if double(car_magnitude_spectrum(i,j))<120
            diameter_estimation(i,j) =0;
        elseif double(car_magnitude_spectrum(i,j))>120
            diameter_estimation(i,j) =255;
        end
        
        
        
    end
end

figure(8);
imshow(peak_estimation);

figure(9);
imshow(diameter_estimation);
%c and d

notchCenters = [56 86; 112 82; 58 166; 116 161;56 45;112 41; 58 207; 114 203];
sigmas = [8 8 8 8 4 4 4 4];
[height, width] = size(car);
car_DFT = fftshift(fft2(car));
car_DFT_Mag = abs(car_DFT);

[omega_x, omega_y] = meshgrid(1:width, 1:height);
filterDFT = ones(size(omega_x));
for n = 1:size(notchCenters,1)
    rSq = (omega_x - notchCenters(n,1)).^2 + ...
        (omega_y - notchCenters(n,2)).^2;
    filterDFT = filterDFT .* (1 - exp(-rSq / sigmas(n)^2));
end
car_Filt_DFT = car_DFT .* filterDFT;
car_Filt_DFT_Mag = abs(car_Filt_DFT);

figure(10);
imshow(filterDFT, [0 1]); colorbar;
figure(11);
imshow(log(car_Filt_DFT_Mag), [0 10]); colorbar;

car_Filt_DFT_back_shifted=ifftshift(car_Filt_DFT);
car_Filt_DFT_back_shifted_filter_applied=abs(ifft2(car_Filt_DFT_back_shifted));
image_reconstructed=im2uint8(mat2gray(car_Filt_DFT_back_shifted_filter_applied));

figure(12);
imshow(image_reconstructed); % moire pattern removed

figure(13); % extracted moire pattern
pattern = car_Filt_DFT_back_shifted_filter_applied;
pattern = pattern - double(car);
imshow(pattern, []);
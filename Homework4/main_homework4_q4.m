%% Aydın Uzun
% HW 4
% Q4
%%
clear all;
%% question 4
clear;
clf;
trump = imread('Donald_Trump.jpeg');
reis = imread('Tayyip_Erdogan.jpg');
trump_gray = rgb2gray(trump);
reis_gray = rgb2gray(reis);
% % A
% mag_phase_analysis of Trump
Trump_FT=fft2(trump_gray);
Trump_Abs=abs(Trump_FT);
Trump_angle=atan2(imag(Trump_FT),real(Trump_FT));
Trump_Phase=exp(j*Trump_angle);
Trump_Mag=real(ifft2(Trump_Abs));
Trump_Phase_only=real(ifft2(Trump_Phase));
% convert magnitude only and phase only images to uint8 format for display
Trump_Mag_uint=im2uint8(mat2gray(Trump_Mag));
Trump_Phase_only_uint=im2uint8(mat2gray(Trump_Phase_only));
% display magnitude only image in second quadrant

figure(15);
imshow(Trump_Mag_uint, [0 30]);

figure(16);
imshow(Trump_Phase_only_uint,[50  200]);
% ranges are determined empirically

% B

% mag_phase_analysis of Erdogan
Reis_FT=fft2(reis_gray);
Reis_Abs=abs(Reis_FT);
Reis_angle=atan2(imag(Reis_FT),real(Reis_FT));
Reis_Phase=exp(j*Reis_angle);
Reis_Mag=real(ifft2(Reis_Abs));
Reis_Phase_only=real(ifft2(Reis_Phase));
% convert magnitude only and phase only images to uint8 format for display
Reis_Mag_uint=im2uint8(mat2gray(Reis_Mag));
Reis_Phase_only_uint=im2uint8(mat2gray(Reis_Phase_only));
% display magnitude only image in second quadrant

figure(17);
imshow(Reis_Mag_uint, [0 30]);

figure(18);
imshow(Reis_Phase_only_uint,[50  200]);

% ranges are determined empirically

% C
% Reconstruct Trump from Erdogan’s phase spectrum and Trump’s magnitude spectrum
[numrows numcols] = size(trump_gray);
reis_trump_scaled = imresize(reis_gray,[numrows numcols]);
Reis_FT_scaled=fft2(reis_trump_scaled);
Reis_Abs_scaled=abs(Reis_FT_scaled);
Reis_angle_scaled=atan2(imag(Reis_FT_scaled),real(Reis_FT_scaled));
Reis_Phase_scaled=exp(j*Reis_angle_scaled);

Trump_Mag_reis_phase=Trump_Abs.*Reis_Phase_scaled;
Trump_Mag_reis_phase_inverse_FT=real(ifft2(Trump_Mag_reis_phase));
Trump_Mag_reis_phase_uint=im2uint8(mat2gray(Trump_Mag_reis_phase_inverse_FT));

figure(19);
imshow(Trump_Mag_reis_phase_uint, [60 150]);
% ranges are determined empirically

% D
Trump_phase_reis_mag=Reis_Abs_scaled.*Trump_Phase;
Trump_phase_reis_Mag_inverse_FT=real(ifft2(Trump_phase_reis_mag));
Trump_phase_reis_Mag_uint=im2uint8(mat2gray(Trump_phase_reis_Mag_inverse_FT));

figure(20);
imshow(Trump_phase_reis_Mag_uint, [60 150]);
% ranges are determined empirically

% E

% Clearly the phase information is far more important than
% the magnitude in- formation in preserving key aspects of
% individual images. The phase information seems to
% retain a lot of information about image edges and image orientations.
%%


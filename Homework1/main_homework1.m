%-----------------------------
% AYDIN UZUN
% 2015401210
% 09.10.2018
% HW#1
clear;
%IMAGE READ & WRITE; HISTOGRAM PLOT
I = imread('COLOR_Birds.bmp');
figure(1);
imshow(I);
imwrite(I, 'COLOR_Birds.png');
INFO=imfinfo('COLOR_Birds.png');
%%
%a)	
%extract R,G,B arrays and allocate a zeros array which is equal in size
%as R,G,B arrays. After that concetanate them to achieve a uint8 valued size1xsize2x3
%array.
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
null = zeros(size(I, 1), size(I, 2));
only_R = cat(3, R, null, null);
only_G = cat(3, null, G, null);
only_B = cat(3, null, null, B);
%plot R,G,B components and the original image
figure(2)
subplot(2,2,1)
imshow(I);
xlabel('original');
subplot(2,2,2)
imshow(only_R);
xlabel('Red component');
subplot(2,2,3)
imshow(only_G);
xlabel('Green component');
subplot(2,2,4)
imshow(only_B);
xlabel('Blue component');
%%
% b)	
% take average, show and then save to a .bmp file. Take into account that
% one cannot do this operation in uint8 values. Because the sum would cause
% overflow.
GRAY_Birds = (double(R) + double(G) + double(B))/3;
GRAY_Birds = uint8(GRAY_Birds);
figure(3);
imshow(GRAY_Birds);
imwrite(GRAY_Birds, 'GRAY_Birds.bmp');
%%
% c)
% use imhist() function to see histograms, comment on them on report.
figure(4)
subplot(2,2,1)
imhist(R);
title('histogram of red component');
subplot(2,2,2)
imhist(G);
title('histogram of green component');
subplot(2,2,3)
imhist(B);
title('histogram of blue component');
subplot(2,2,4)
imhist(GRAY_Birds);
title('histogram of GRAY level component');
%%
% d)
% The variables R_150_G_130_B_10, R_130_G_200_B_130, %B > 130, R > 130 and G < 200  
%is a logical variable. At the pixels where
% the given conditions hold, the output will be 1, otherwise 0. When one
% use imshow() function to visualize this variable, logical '1' is scaled
% to 255 and logical '0' is scaled to 0, as demanded. 
% ﻿R > 150, G > 130 and B < 10
R_150_G_130_B_10 = (R > 150) & (G > 130) & (B < 10);
figure(5);
imshow(R_150_G_130_B_10);
%%
%e
%B > 130, G > 130 and R < 100
R_100_G_130_B_130 = (R < 100) & (G > 130) & (B > 130);
figure(6)
imshow(R_100_G_130_B_130);
%%
%f
%B > 130, R > 130 and G < 200
R_130_G_200_B_130 = (R > 130) & (G < 200) & (B > 130);
figure(7)
imshow(R_130_G_200_B_130);
%%
% g
GRAY_Birds_over_2 = GRAY_Birds/2;
figure(8);
imshow(GRAY_Birds_over_2);
figure(9);
imhist(GRAY_Birds_over_2);
%%
%h
% My rough estimate for the reddest point is maximum value for R component,
% minimum value for other components. To estimate such a point the
% following conditions are checked and the output is only two pixels which
% is a good approximation. But it actrually depends on your definition of
% 'reddest'.
most_Red = (R > 220) & (G < 50) & (B < 50);
[max_row,max_col] = find(most_Red == true );
%%
%end of Image Read and Write, Histogram Plot

%}
%----------------------------------

clear;
%%
% AVERAGE OPTICAL DENSITY
% Read the face images 
face1 = imread('subject06.centerlight');
face2 = imread('subject06.noglasses');
baby = imread('Baby.png');
% face1 and face2 is gray level image, baby is RGB image.
%%
%a
% first take sizes of arrays assigned to face images. 
size_vector=[size(face1),size(face2),size(baby)];
%calculation according to given algorithm
%sum(sum()) function gives the sum of all elements of a matrix. One should
%take into account that baby is 3D array, which means result of sum(sum())
%operator will be a 1x3 vector. 
AODface1 = sum(sum(face1))/(size_vector(1) * size_vector(2));
AODface2 = sum(sum(face2))/(size_vector(3) * size_vector(4));
AODbaby = sum(sum(baby))/(size_vector(5) * size_vector(6));
%%
%b
figure(10)
subplot(1,3,1)
imhist(face1);
title('subject06.centerlight')
ylabel('pixel count');
xlabel('gray levels');
subplot(1,3,2)
imhist(face2);
ylabel('pixel count');
xlabel('gray levels');
title('subject06.noglasses')
subplot(1,3,3)
imhist(baby);
ylabel('pixel count');
xlabel('RGB levels');
title('Baby.png')
%%
%c
%Overflow issue is already taken into account. I found the constants c
%empirical. 
face1_adjusted = face1-  100;
face2_adjusted = face2-  78;
baby_adjusted = baby + 34;

AODface1_adjusted = sum(sum(face1_adjusted))/(size_vector(1) * size_vector(2));
AODface2_mult = sum(sum(face2_adjusted))/(size_vector(3) * size_vector(4));
AODbaby_adjusted = sum(sum(baby_adjusted))/(size_vector(5) * size_vector(6));
figure(11)
subplot(2,3,1)
imshow(face1);
title('original subject06.centerlight');
subplot(2,3,2)
imshow(face2);
title('original subject06.noglasses');
subplot(2,3,3)
imshow(baby);
title('original Baby.png');
subplot(2,3,4)
imshow(face1_adjusted);
title('adjusted subject06.centerlight');
subplot(2,3,5)
imshow(face2_adjusted);
title('adjusted subject06.noglasses');
subplot(2,3,6)
imshow(baby_adjusted);
title('adjusted Baby.png');
figure(12)
subplot(1,3,1)
imhist(face1_adjusted);
title('subject06.centerlight')
subplot(1,3,2)
imhist(face2_adjusted);
title('subject06.noglasses');
subplot(1,3,3)
imhist(baby_adjusted);
title('Baby.png');
%%
%d
%first multiple arrays for different values of a
face1_mult_05 = face1*0.5;
face2_mult_05 = face2*0.5; 
baby_mult_05 = baby*0.5;
face1_mult_2 = face1*2;
face2_mult_2 = face2*2; 
baby_mult_2 = baby*2;
%calculate new AODs with the same algorithm used on b)
AODface1_mult_05 = sum(sum(face1_mult_05))/(size_vector(1) * size_vector(2));
AODface2_mult_05 = sum(sum(face2_mult_05))/(size_vector(3) * size_vector(4));
AODbaby_mult_05 = sum(sum(baby_mult_05))/(size_vector(5) * size_vector(6));
AODface1_mult_2 = sum(sum(face1_mult_2))/(size_vector(1) * size_vector(2));
AODface2_mult_2 = sum(sum(face2_mult_2))/(size_vector(3) * size_vector(4));
AODbaby_mult_2 = sum(sum(baby_mult_2))/(size_vector(5) * size_vector(6));
%Image arrays are uint8 valued variables.But AOD values are doubles. Before
%adding AOD(before) – AOD(after) to all pixels one should convert it to
%uint8. One more thing to take into account is the fact that AODbaby is a
%vector.
face1_mult_05_adjusted= face1_mult_05 + uint8(AODface1-AODface1_mult_05);
face2_mult_05_adjusted= face2_mult_05 + uint8(AODface2-AODface2_mult_05);
baby_mult_05_adjusted= baby_mult_05 + uint8(AODbaby(1)-AODbaby_mult_05(1));
face1_mult_2_adjusted= face1_mult_2 + uint8(AODface1-AODface1_mult_2);
face2_mult_2_adjusted= face2_mult_2 + uint8(AODface2-AODface2_mult_2);
baby_mult_2_adjusted= baby_mult_2 + uint8(AODbaby(1)-AODbaby_mult_2(1));

%plot adjusted arrays.
figure(13)
subplot(2,3,1)
imshow(face1_mult_05_adjusted);
title('a=0.5');
subplot(2,3,2)
imshow(face2_mult_05_adjusted);
title('a=0.5')
subplot(2,3,3)
imshow(baby_mult_05_adjusted);
title('a=0.5')
subplot(2,3,4)
imshow(face1_mult_2_adjusted);
title('a=2')
subplot(2,3,5)
imshow(face2_mult_2_adjusted);
title('a=2')
subplot(2,3,6)
imshow(baby_mult_2_adjusted);
title('a=2');

%-------------------------------------------------------------------
%}

%%
clear;
% Get a Feeling About the Amount of Pixels
%a)
size_a = 640*480;
time_for_each_frame_a_in_sec = 1/25;
number_of_RGB_components_a = 3*size_a;
total_bit_number_at_each_frame_a= number_of_RGB_components_a*log2(256);
image_data_processing_rate_in_bps_a = total_bit_number_at_each_frame_a / time_for_each_frame_a_in_sec ;

%%
%b)
size_b = 256*256*256;
time_for_each_frame_b = 1/10;
total_bit_number_at_each_frame_b= size_b*log2(65536);
image_data_processing_rate_in_bps_b = total_bit_number_at_each_frame_b / time_for_each_frame_b ;


%c
size_c = 256*256;
quantization_levels=16;
total_bit_number_at_each_frame_c= size_c*quantization_levels;
seconds_in_a_day = 24*60*60;
amount_of_data_processed_per_day = seconds_in_a_day*1000*24*total_bit_number_at_each_frame_c;

%d)
size_d = 2048*1080;
two_hours_in_sec = 2*3600;
number_of_RGB_components_d = 3*size_d;
time_for_each_frame_d = 1/25;
number_of_frames = two_hours_in_sec / time_for_each_frame_d ;
storage=number_of_frames*number_of_RGB_components_d*12;
storage_in_GB= storage/(8*(10^9));

%---------------------------------------------------
%}

% PIXELS VARIETIES
%a)
clear;
% read the image and extraxt RGB arrays then convert them to doubles in
% order not to cause overflow while adding arrays. 
% The answer to this question actually depends on your definition of
% brightness. To my view when the addition of RGB values is maximum then
% this point is the most whitish point on the image. The most whitish point
%the image will emit the most amount of light.
Cetus_galaxy= imread('Cetus_NGC1052Galaxy.jpg');
R = Cetus_galaxy(:,:,1);
G = Cetus_galaxy(:,:,2);
B = Cetus_galaxy(:,:,3);
R_doub = double(R);
G_doub = double(G);
B_doub = double(B);
new = R_doub+G_doub+B_doub;
% find the point where the addition of R,G and B vectors is maximum.
maximum_galaxy = max(max(new));
[Row_galaxy,Column_galaxy]=find(new == maximum_galaxy);

%b
office= imread('Picture1.jpg');
% get rid of useless information which is last 7-8 rows of the image.
% set the R,G and B values to 0 at these useless places, because they don't
% have anything to do with distance. On this way they don't harm my
% algorithm.
office(157:164,:,:)=100;
%The rest is the same as previous question.
R_office = office(:,:,1);
G_office = office(:,:,2);
B_office = office(:,:,3);
R_office_doub = double(R_office);
G_office_doub = double(G_office);
B_office_doub = double(B_office);
new_office = R_office_doub+G_office_doub+B_office_doub;

maximum_office = max(max(new_office));
[Row_office_closest,Column_office_closest]=find(new_office == maximum_office);
Close = [Row_office_closest,Column_office_closest];
minimum_office = min(min(new_office));
[Row_office_farthest,Column_office_farthest]=find(new_office == minimum_office);
Far = [Row_office_farthest,Column_office_farthest];
clear;
%c)
skull = imread('SKULL_head24.tif');
breast = imread('Breast_density.jpg');
R_breast = breast(:,:,1);
G_breast = breast(:,:,2);
B_breast = breast(:,:,3);
R_breast_doub = double(R_breast);
G_breast_doub = double(G_breast);
B_breast_doub = double(B_breast);
sum_breast = R_breast_doub+G_breast_doub+B_breast_doub;
minimum_skull = min(min(skull));
[Row_skull_opaque,Column_skull_opague]=find(skull == minimum_skull);
maximum_skull = max(max(skull));
[Row_skull_trans,Column_skull_trans]=find(skull == maximum_skull);
minimum_breast = min(min(sum_breast));
[Row_breast_opaque,Column_breast_opague]=find(sum_breast == minimum_breast);
maximum_breast = max(max(sum_breast));
[Row_breast_trans,Column_breast_trans]=find(sum_breast == maximum_breast);

%this step is used to detect the opaquest points better. The algorithm
%above presents 8228 opaquest points for skull 23033 opaquest points for breast
%which is too much. Therefore not
%applicable.
skull_0 = (skull > 0);
figure(14);
imshow(skull_0);
breast_0 = (sum_breast > 0);
figure(15);
imshow(breast_0);

clear;
%c)

thermal= imread('Thermal_pedestrian_00005.bmp');

minimum_thermal = min(min(thermal));
[Row_thermal_cold,Column_thermal_cold]=find(thermal == minimum_thermal);

maximum_thermal = max(max(thermal));
[Row_thermal_hot,Column_thermal_hot]=find(thermal == maximum_thermal);

thermal_0 = (thermal < 40);
figure(16);
imshow(thermal_0);
clear;

%d)
%first take difference between images in double then take its absolute
%value then convert it back to uint8 to display as a image. From image one
%should expect that the brighter points are faster changing points between
%images. 
taxi36 = imread('FRAMEDIFF_taxi36.pgm');
taxi40 = imread('FRAMEDIFF_taxi40.pgm');
taxidiff = double(taxi40) - double(taxi36);
taxidiff_abs = abs(taxidiff);
uint8_taxidiff_abs = uint8(taxidiff_abs);
figure(17)
imshow(uint8_taxidiff_abs);

%-------------------------------------
clear;
% IMAGE QUANTIZATION  
lena = imread('lena.bmp');
%a)
 % Display initial image 
 figure(18)
 imshow(lena);
 lena_MSB = zeros(size(lena,1),size(lena,2));
    % Scan through all pixels in the image
    % if the pixel value > 127 in other words if the MSB is 1, turn the
    % pixel value on gray scale to 255. if not turn it to 0.
    for y = 1:size(lena, 1)
        for x = 1:size(lena, 2)
            if lena(y,x) > 127
                lena_MSB(y,x) = 255;
            else
                lena_MSB(y,x) = 0;
            end
        end
  end
    % Display image
    figure (19);   
    imshow(lena_MSB);
    
%b) LSB binarization
  
lena_LSB = zeros(size(lena,1),size(lena,2));
for y=1:size(lena,1)
    for x=1:size(lena,2)
        if mod(lena(y,x),2)==1
            lena_LSB(y,x)=255;
        else
            lena_LSB(y,x)=0;
        end
    end
end
figure(20);
imshow(lena_LSB);

%c) 
Lena5_to_8_0 = lena;

for y=1:size(lena,1)
    for x=1:size(lena,2)
        if lena(y,x) > 15
            Lena5_to_8_0(y,x)=0;
       
        end
    end
end
figure(21);
imshow(Lena5_to_8_0);

%d)
Lena1_to_4_0 = lena;

for y=1:size(lena,1)
    for x=1:size(lena,2)
        if lena(y,x) < 16
            Lena1_to_4_0(y,x)=0;
       
        end
    end
end
figure(22);
imshow(Lena1_to_4_0);
clear;

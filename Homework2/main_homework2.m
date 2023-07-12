% AYDIN UZUN
% 2015401210
% 13.10.2018
% HW#2
clear;
%%
% INTERPRETATION of HISTOGRAMS 
%The answer was just interpretation and can be found on report.
%%
% HOW TO QUANTIZE IMAGES
%I don't understand the question well. If there will be a reference image
%it would be better. But I answered vii) on the report.
%%
% I. HISTOGRAM EQUALIZATION

%first read images
lumberjack  = imread('lumbercamp.jpg');
spine = imread('Gonzalez_Fractured spine.jpg');
%My implemented histogram equalization function is called myhisteq.m. It
%can be found inside the folder.
%The algorithm is the algorithm used in the class by Prof. Sankur.
out_img_lumberjack = myhisteq(lumberjack);
figure(1);
imshow(out_img_lumberjack);

%This is the buit-in histogram equilization function.
out_img_org_lumberjack = histeq(lumberjack);
figure(2);
imshow(out_img_org_lumberjack);

%do the same for spine
out_img_spine = myhisteq(spine);
figure(3);
imshow(out_img_spine);

out_img_org_spine = histeq(spine);
figure(4);
imshow(out_img_org_spine);

% look at the outputs of built-in adapthisteq.m function. One can see that
% adaptive histogram equalization is a stronger way to equalize images.
%The comments are on the report.
out_img_adp_lumberjack = adapthisteq(lumberjack);
figure(5);
imshow(out_img_org_lumberjack);

out_img_adp_spine = adapthisteq(spine);
figure(6);
imshow(out_img_adp_spine);
clear;
%%
% COLOR IMAGE ENHANCEMENT
% read images
beach = imread('beach.jpg');
kugu = imread('kugu.jpg');
% create contrast stretched images 
beach_cont_str = zeros(size(beach,1),size(beach,2),size(beach,3));
kugu_cont_str = zeros(size(kugu,1),size(kugu,2),size(kugu,3));


% define 'a' lower limit to which image intensity values will be extended
%'b' upper limit 
a=0; 
b=255;

%calculate c and d, value limits in the original image
%complete the given operation for each channel
c_kugu = min(min(kugu)); % 1x1x3
d_kugu = max(max(kugu)); % 1x1x3
kugu_cont_str =(kugu - c_kugu).*((b-a)/(d_kugu - c_kugu)) + a;
c_beach = min(min(beach)); % 1x1x3
d_beach = max(max(beach)); % 1x1x3
beach_cont_str =(beach - c_beach).*((b-a)/(d_beach - c_beach)) + a;

%show original and contrast stretched images.
figure(7);
imshow(kugu);
figure(8);
imshow(kugu_cont_str);
figure(9);
imshow(beach);
figure(10);
imshow(beach_cont_str);

%convert into HSV color space
kugu_HSV = rgb2hsv(kugu);
beach_HSV= rgb2hsv(beach);
%extract channel V in order to apply contrast stretching
beach_V = zeros(size(beach_HSV,1),size(beach_HSV,2));
kugu_V = zeros(size(kugu_HSV,1),size(kugu_HSV,2));
beach_V = beach_HSV(:,:,3);
kugu_V = kugu_HSV(:,:,3);

% find c and d values, value limits in the original image, but it's not a
% vector anymore as in the previous part.
c_kugu_V = min(min(kugu_V)); % 1x1x1
d_kugu_V = max(max(kugu_V)); % 1x1x1
c_beach_V = min(min(beach_V)); % 1x1x1
d_beach_V = max(max(beach_V)); % 1x1x1

% create V channel stretched images.
beach_cont_str_V = zeros(size(beach_HSV,1),size(beach_HSV,2));
kugu_cont_str_V = zeros(size(kugu_HSV,1),size(kugu_HSV,2));

%complete the given operation on V channel
kugu_cont_str_V =(kugu_V - c_kugu_V)*((b-a)/(d_kugu_V - c_kugu_V)) + a;
beach_cont_str_V =(beach_V - c_beach_V)*((b-a)/(d_beach_V - c_beach_V)) + a;

% combine the results. Only the V channel should change.
beach_cont_str_HSV = zeros(size(beach_HSV,1),size(beach_HSV,2),size(beach_HSV,3));
kugu_cont_str_HSV = zeros(size(kugu_HSV,1),size(kugu_HSV,2),size(kugu_HSV,3));
kugu_cont_str_HSV(:,:,3) = kugu_cont_str_V;
kugu_cont_str_HSV(:,:,2) = kugu_HSV(:,:,2);
kugu_cont_str_HSV(:,:,1) = kugu_HSV(:,:,1);
beach_cont_str_HSV(:,:,3) = beach_cont_str_V;
beach_cont_str_HSV(:,:,2) = beach_HSV(:,:,2);
beach_cont_str_HSV(:,:,1) = beach_HSV(:,:,1);

% do not forget to convert output of hsv2rgb.m function to uint8. Because
% its output is a double. You cannot respresent an image with doubles.
out_beach = uint8(hsv2rgb(beach_cont_str_HSV));
out_kugu = uint8(hsv2rgb(kugu_cont_str_HSV));

% show HSV stretched images.
figure(11);
imshow(out_beach);
figure(12);
imshow(out_kugu);
%%
clear;

%EFFECTS of FILTERING on HISTOGRAMS

%read images
gross = imread('Checkerboard_gross.png');
fine = imread('Checkerboard_fine.png');

%convert black to 0 and white to 255 for both images
 for y = 1:size(gross, 1)
        for x = 1:size(gross, 2)
            if gross(y,x) > 127
                gross(y,x) = 255;
            else
                gross(y,x) = 0;
            end
        end
 end
  
  for y = 1:size(fine, 1)
        for x = 1:size(fine, 2)
            if fine(y,x) > 127
                fine(y,x) = 255;
            else
                fine(y,x) = 0;
            end
        end
  end
  % sketch histograms, one should expect that both images have the same
  % histogram.
figure(13);
imhist(gross);
figure(14);
imhist(fine);

clear;
%b) 
%plot the histogram of images
gross = imread('Checkerboard_gross.png');
fine = imread('Checkerboard_fine.png');
figure(15);
imhist(gross);
figure(16);
imhist(fine);

%create 3x3 averaging filter
dot3_avg_filter = ones(3,3)/9;

%use imfilter()
gross_filt3 = imfilter(gross,dot3_avg_filter);
fine_filt3  = imfilter(fine,dot3_avg_filter);

%plot new figures and corresponding histograms
figure(17);
imhist(gross_filt3);
figure(18);
imhist(fine_filt3);
figure(19);
imshow(gross_filt3);
figure(20);
imshow(fine_filt3);

%c
%crete 9x9 filter
dot9_avg_filter = ones(9,9)/81;

gross_filt9 = imfilter(gross,dot9_avg_filter);
fine_filt9 = imfilter(fine,dot9_avg_filter);

%plot new figures and corresponding histograms
figure(21);
imshow(gross_filt9);
figure(22);
imshow(fine_filt9);
figure(23);
imhist(gross_filt9);
figure(24);
imhist(fine_filt9);

clear;

% HISTOGRAM DISTANCE
% Actually I could not complete this question. But I made some calculations
% after I gave the report on Tuesday. So there is no 'Histogram Distance'
% part in my report. Here is my code to calculate histogram distances. The
% distances can be found at the end of the code as comment. 

%first read images
face_better = imread('yaleB26_P08A+000E+00.pgm');
face_bad1 = imread('yaleB26_P08A+000E+90.pgm');
face_bad2 = imread('yaleB26_P08A+020E-40.pgm');
face_bad3 = imread('yaleB26_P08A+020E+10.pgm');
face_bad4 = imread('yaleB26_P08A+050E+00.pgm');

%crop images. The values 53:460 and 208:511 are tentative. They are
%measured using the cursor.
face_cropped_better = face_better(53:460,208:511);
face_cropped_bad1 = face_bad1(53:460,208:511);
face_cropped_bad2 = face_bad2(53:460,208:511);
face_cropped_bad3 = face_bad3(53:460,208:511);
face_cropped_bad4 = face_bad4(53:460,208:511);

% histograms of cropped images
face_hist_better = imhist(face_cropped_better);
face_hist_bad1 = imhist(face_cropped_bad1);
face_hist_bad2 = imhist(face_cropped_bad2);
face_hist_bad3 = imhist(face_cropped_bad3);
face_hist_bad4 = imhist(face_cropped_bad4);

%histogram match the badly illuminated faces to the better illuminated face
%called 'face_cropped_better'
face_matched_better_bad1 = imhistmatch(face_cropped_bad1,face_cropped_better);
face_matched_better_bad2 = imhistmatch(face_cropped_bad2,face_cropped_better);
face_matched_better_bad3 = imhistmatch(face_cropped_bad3,face_cropped_better);
face_matched_better_bad4 = imhistmatch(face_cropped_bad4,face_cropped_better);

% histograms of matched images
face_hist_matched_better_bad1 = imhist(face_matched_better_bad1);
face_hist_matched_better_bad2 = imhist(face_matched_better_bad2);
face_hist_matched_better_bad3 = imhist(face_matched_better_bad3);
face_hist_matched_better_bad4 = imhist(face_matched_better_bad4);

%calculate chi square histogram distances before matching
% one comment about why I used eps
% 0 / 0 or 0 * Inf in array division is NaN. this harms my further
% calculations. therefore I get rid of this NaN by checking the array
% whether there is a NaN or not. If there is a NaN, I replace it with
% epsilon.
difference_square_face_hist_better_bad1 = (face_hist_better-face_hist_bad1).*(face_hist_better-face_hist_bad1);
sum_face_hist_better_bad1 = face_hist_better+face_hist_bad1;
dummy5= difference_square_face_hist_better_bad1 ./sum_face_hist_better_bad1;
dummy5(isnan(dummy5))=eps;
chi_face_hist_better_bad1 = sqrt(sum(dummy5)/2);

difference_square_face_hist_better_bad2 = (face_hist_better-face_hist_bad2).*(face_hist_better-face_hist_bad2);
sum_face_hist_better_bad2 = face_hist_better+face_hist_bad2;
dummy6= difference_square_face_hist_better_bad2 ./sum_face_hist_better_bad2;
dummy6(isnan(dummy6))=eps;
chi_face_hist_better_bad2 = sqrt(sum(dummy6)/2);

difference_square_face_hist_better_bad3 = (face_hist_better-face_hist_bad3).*(face_hist_better-face_hist_bad3);
sum_face_hist_better_bad3 = face_hist_better+face_hist_bad3;
dummy7= difference_square_face_hist_better_bad3 ./sum_face_hist_better_bad3;
dummy7(isnan(dummy7))=eps;
chi_face_hist_better_bad3 = sqrt(sum(dummy7)/2);

difference_square_face_hist_better_bad4 = (face_hist_better-face_hist_bad4).*(face_hist_better-face_hist_bad4);
sum_face_hist_better_bad4 = face_hist_better+face_hist_bad4;
dummy8= difference_square_face_hist_better_bad4 ./sum_face_hist_better_bad4;
dummy8(isnan(dummy8))=eps;
chi_face_hist_better_bad4 = sqrt(sum(dummy8)/2);


%calculate chi square histogram distances after matching
difference_square_face_hist_matched_better_bad1 = (face_hist_matched_better_bad1-face_hist_bad1).*(face_hist_matched_better_bad1-face_hist_bad1);
sum_face_hist_matched_better_bad1 = face_hist_matched_better_bad1+face_hist_bad1;
dummy1= difference_square_face_hist_matched_better_bad1 ./sum_face_hist_matched_better_bad1;
dummy1(isnan(dummy1))=eps;
chi_face_hist_matched_better_bad1 = sqrt(sum(dummy1)/2);


difference_square_face_hist_matched_better_bad2 = (face_hist_matched_better_bad2-face_hist_bad2).*(face_hist_matched_better_bad2-face_hist_bad2);
sum_face_hist_matched_better_bad2 = face_hist_matched_better_bad2+face_hist_bad2;
dummy2= difference_square_face_hist_matched_better_bad2 ./sum_face_hist_matched_better_bad2;
dummy2(isnan(dummy2))=eps;
chi_face_hist_matched_better_bad2 = sqrt(sum(dummy2)/2);

difference_square_face_hist_matched_better_bad3 = (face_hist_matched_better_bad3-face_hist_bad3).*(face_hist_matched_better_bad3-face_hist_bad3);
sum_face_hist_matched_better_bad3 = face_hist_matched_better_bad3+face_hist_bad3;
dummy3= difference_square_face_hist_matched_better_bad3 ./sum_face_hist_matched_better_bad3;
dummy3(isnan(dummy3))=eps;
chi_face_hist_matched_better_bad3 = sqrt(sum(dummy3)/2);

difference_square_face_hist_matched_better_bad4 = (face_hist_matched_better_bad4-face_hist_bad4).*(face_hist_matched_better_bad4-face_hist_bad4);
sum_face_hist_matched_better_bad4 = face_hist_matched_better_bad4+face_hist_bad4;
dummy4= difference_square_face_hist_matched_better_bad4 ./sum_face_hist_matched_better_bad4;
dummy4(isnan(dummy4))=eps;
chi_face_hist_matched_better_bad4 = sqrt(sum(dummy4)/2);



%%
%ii)

%calculate Kullback-Leibler  distance before matching
% use eps to get rid of above explained problems
face_hist_bad1(face_hist_bad1==0)=eps;
face_hist_bad2(face_hist_bad2==0)=eps;
face_hist_bad3(face_hist_bad3==0)=eps;
face_hist_bad4(face_hist_bad4==0)=eps;
face_hist_better(face_hist_better==0)=eps;
face_hist_matched_better_bad1(face_hist_matched_better_bad1==0)=eps;
face_hist_matched_better_bad2(face_hist_matched_better_bad2==0)=eps;
face_hist_matched_better_bad3(face_hist_matched_better_bad3==0)=eps;
face_hist_matched_better_bad4(face_hist_matched_better_bad4==0)=eps;


KL1 = sum(face_hist_bad1.*log2(face_hist_better./face_hist_bad1));
KL2 = sum(face_hist_bad2.*log2(face_hist_better./face_hist_bad2));
KL3 = sum(face_hist_bad3.*log2(face_hist_better./face_hist_bad3));
KL4 = sum(face_hist_bad4.*log2(face_hist_better./face_hist_bad4));

%calculate Kullback-Leibler  distance after matching
KL5 = sum(face_hist_bad1.*log2(face_hist_matched_better_bad1./face_hist_bad1));
KL6 = sum(face_hist_bad2.*log2(face_hist_matched_better_bad2./face_hist_bad1));
KL7 = sum(face_hist_bad3.*log2(face_hist_matched_better_bad3./face_hist_bad1));
KL8 = sum(face_hist_bad4.*log2(face_hist_matched_better_bad4./face_hist_bad1));

%% The calculated values are the following :
% % % % before matching
% % Chi-square histogram distance between histogram of cropped better illuminated face and cropped yaleB26_P08A+000E+90.pgm = 196.5595
% % Chi-square histogram distance between histogram of cropped better illuminated face and cropped yaleB26_P08A+020E-40.pgm = 96.1054
% % Chi-square histogram distance between histogram of cropped better illuminated face and cropped yaleB26_P08A+020E+10.pgm = 59.8679
% % Chi-square histogram distance between histogram of cropped better illuminated face and cropped yaleB26_P08A+050E+00.pgm = 84.7136
% % % % after matching
% % Chi-square histogram distance between histogram of matched with yaleB26_P08A+000E+90.pgm cropped better illuminated face and cropped yaleB26_P08A+000E+90.pgm =306.4533 
% % Chi-square histogram distance between histogram of matched with yaleB26_P08A+020E-40.pgm cropped better illuminated face and cropped yaleB26_P08A+020E-40.pgm =274.2081 
% % Chi-square histogram distance between histogram of matched with yaleB26_P08A+020E+10.pgm cropped better illuminated face and cropped yaleB26_P08A+020E+10.pgm =272.4969 
% % Chi-square histogram distance between histogram of matched with yaleB26_P08A+050E+00.pgm cropped better illuminated face and cropped yaleB26_P08A+050E+00.pgm =274.9604
% % % % before matching
% % Kullback-Leibler distance between histogram of cropped better illuminated face(q) and cropped yaleB26_P08A+000E+90.pgm(p) =-1.225081172096550e+05
% % Kullback-Leibler distance between histogram of cropped better illuminated face(q) and cropped yaleB26_P08A+020E-40.pgm(p) =-2.801127465955286e+04
% % Kullback-Leibler distance between histogram of cropped better illuminated face(q) and cropped yaleB26_P08A+020E+10.pgm(p) =-1.093624536446953e+04
% % Kullback-Leibler distance between histogram of cropped better illuminated face(q) and cropped yaleB26_P08A+050E+00.pgm(p) =-1.093624536446953e+04
% % % % after matching
% % Kullback-Leibler distance between histogram of matched with yaleB26_P08A+000E+90.pgm cropped better illuminated face and cropped yaleB26_P08A+000E+90.pgm =-6.517602658668200e+06 
% % Kullback-Leibler distance between histogram of matched with yaleB26_P08A+020E-40.pgm cropped better illuminated face and cropped yaleB26_P08A+020E-40.pgm =-5.447842744929808e+06 
% % Kullback-Leibler distance between histogram of matched with yaleB26_P08A+020E+10.pgm cropped better illuminated face and cropped yaleB26_P08A+020E+10.pgm =-5.219552325255899e+06
% % Kullback-Leibler distance between histogram of matched with yaleB26_P08A+050E+00.pgm cropped better illuminated face and cropped yaleB26_P08A+050E+00.pgm =-5.374202559149079e+06
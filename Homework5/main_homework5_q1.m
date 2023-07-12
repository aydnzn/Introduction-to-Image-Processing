%% Aydın Uzun
% HW 5 06.12.2018
%% question 1
clear all;

circles = imread('circles.tif');

circles_sobel = edge(circles, 'Sobel');
circles_log = edge(circles, 'log');
circles_canny = edge(circles, 'Canny');

circles_noised = imnoise(circles, 'gaussian', 0, 484/(256^2));
circles_noised_sobel = edge(circles_noised, 'Sobel');
circles_noised_log = edge(circles_noised, 'log');
circles_noised_canny = edge(circles_noised, 'Canny');

ground_truth = zeros(201,201);
ground_truth = insertShape(ground_truth,'circle',[101 101 20],'LineWidth',1);
ground_truth = insertShape(ground_truth,'circle',[101 101 40],'LineWidth',1);
ground_truth = insertShape(ground_truth,'circle',[101 101 60],'LineWidth',1);
ground_truth = insertShape(ground_truth,'circle',[101 101 80],'LineWidth',1);
ground_truth = imbinarize(rgb2gray(ground_truth));


edge_distance_smaller_than_2_ground_truth = zeros(201,201);
edge_distance_smaller_than_2_ground_truth = insertShape(edge_distance_smaller_than_2_ground_truth,'circle',[101 101 20],'LineWidth',5);
edge_distance_smaller_than_2_ground_truth = insertShape(edge_distance_smaller_than_2_ground_truth,'circle',[101 101 40],'LineWidth',5);
edge_distance_smaller_than_2_ground_truth = insertShape(edge_distance_smaller_than_2_ground_truth,'circle',[101 101 60],'LineWidth',5);
edge_distance_smaller_than_2_ground_truth = insertShape(edge_distance_smaller_than_2_ground_truth,'circle',[101 101 80],'LineWidth',5);
edge_distance_smaller_than_2_ground_truth = imbinarize(rgb2gray(edge_distance_smaller_than_2_ground_truth));



N_grt = length(find(ground_truth==1));

% Sobel
% without noise
dirac_sobel = ground_truth.*circles_sobel;
edge_distance_smaller_than_2_sobel = edge_distance_smaller_than_2_ground_truth.*circles_sobel ;
ep_sobel = (1/N_grt)*sum(sum(dirac_sobel + 0.5*(1-dirac_sobel).*edge_distance_smaller_than_2_sobel));
% with noise
dirac_sobel_noised = ground_truth.*circles_noised_sobel;
edge_distance_smaller_than_2_noised_sobel = edge_distance_smaller_than_2_ground_truth.*circles_noised_sobel ;
ep_sobel_noised = (1/N_grt)*sum(sum(dirac_sobel_noised + 0.5*(1-dirac_sobel_noised).*edge_distance_smaller_than_2_noised_sobel));

% Log
% without noise
dirac_log = ground_truth.*circles_log;
edge_distance_smaller_than_2_log = edge_distance_smaller_than_2_ground_truth.*circles_log ;
ep_log = (1/N_grt)*sum(sum(dirac_log + 0.5*(1-dirac_log).*edge_distance_smaller_than_2_log));
% with noise
dirac_log_noised = ground_truth.*circles_noised_log;
edge_distance_smaller_than_2_noised_log = edge_distance_smaller_than_2_ground_truth.*circles_noised_log ;
ep_log_noised = (1/N_grt)*sum(sum(dirac_log_noised + 0.5*(1-dirac_log_noised).*edge_distance_smaller_than_2_noised_log));

% Canny
% without noise
dirac_canny = ground_truth.*circles_canny;
edge_distance_smaller_than_2_canny = edge_distance_smaller_than_2_ground_truth.*circles_canny ;
ep_canny = (1/N_grt)*sum(sum(dirac_canny + 0.5*(1-dirac_canny).*edge_distance_smaller_than_2_canny));
% with noise
dirac_canny_noised = ground_truth.*circles_noised_canny;
edge_distance_smaller_than_2_noised_canny = edge_distance_smaller_than_2_ground_truth.*circles_noised_canny ;
ep_canny_noised = (1/N_grt)*sum(sum(dirac_canny_noised + 0.5*(1-dirac_canny_noised).*edge_distance_smaller_than_2_noised_canny));

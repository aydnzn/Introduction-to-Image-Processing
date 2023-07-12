%% Aydın Uzun
% HW 5 06.12.2018
%% question 4
clf;
clear;
gauss=imread('Gauss_rgb1.png');
gauss=double(gauss);
gauss_intensity = mean(gauss,3);
[m,n]  = size(gauss_intensity);
new_gauss = zeros(m,n);
labels = zeros(m,n);
labels(32,32) = 1; % green
labels(32,96) = 2; % pink
labels(96,64) = 3; % purple
N = 3;
dist = zeros(1,N);
M = zeros(1,N);

Gauss_R=gauss(:,:,1);
Gauss_G=gauss(:,:,2);
Gauss_B=gauss(:,:,3);
 
f1=[Gauss_R Gauss_G Gauss_B];
 
var_R=stdfilt(Gauss_R,true(3))^2;
var_G=stdfilt(Gauss_G,true(3))^2;
var_B=stdfilt(Gauss_B,true(3))^2;

f2=zeros(128,128,8);

for i=1:128
    for j=1:128
        f2(i,j,:)=[Gauss_R(i,j) Gauss_G(i,j) Gauss_B(i,j) i j var_R(i,j) var_G(i,j) var_B(i,j)];
    end
end
        

M_old = [150 150 150] ;

while(1)
    
    for i =1:m
        for j =1:n
            for k =1:N
                M(k) = mean(gauss_intensity(labels == k));
                dist(k) = abs(gauss_intensity(i,j) - M(k));
            end
            [~ ,closest_label] = min(dist);
            labels(i,j) = closest_label;
        end
    end
    
    constant = sum(M_old-M);
    
    if  constant < 0.05
        break;
    else
        M_old = M;
    end
    
end

for i = 1:m
    for j = 1:n
        if labels(i,j) == 1
            new_gauss(i,j) = uint8(M(1));
        elseif labels(i,j) ==2
            new_gauss(i,j) = uint8(M(2));
        elseif labels(i,j) ==3
            new_gauss(i,j) = uint8(M(3));
        end
        
        
    end
end
new_gauss=uint8(new_gauss);
figure(1);
imshow(new_gauss);
M = round(M);

%b
ground_truth=zeros(m,n);
for i=1:m
    for j=1:n
        if i<=64 && j<=64
            ground_truth(i,j)=M(1);
        end
        if i>64
            ground_truth(i,j)=M(3);
        end
        if i<=64 && j>64
            ground_truth(i,j)=M(2);
        end
    end
end

figure(2);
ground_truth=uint8(ground_truth);
imshow(ground_truth);

labeled_as_on_green=find(new_gauss==M(1));
labeled_as_on_pink=find(new_gauss==M(2));
labeled_as_on_purple=find(new_gauss==M(3));

ground_truth_on_green=find(ground_truth==M(1));
ground_truth_on_pink=find(ground_truth==M(2));
ground_truth_on_purple=find(ground_truth==M(3));

intersection_length_green=length(intersect(labeled_as_on_green, ground_truth_on_green));
intersection_length_pink = length(intersect(labeled_as_on_pink, ground_truth_on_pink));
intersection_length_purple = length(intersect(labeled_as_on_purple, ground_truth_on_purple));

goodness_of_segmentation_score_green=intersection_length_green/(length(labeled_as_on_green)+length(ground_truth_on_green)-intersection_length_green);
goodness_of_segmentation_score_pink=intersection_length_pink/(length(labeled_as_on_pink)+length(ground_truth_on_pink)-intersection_length_pink);
goodness_of_segmentation_score_purple=intersection_length_purple/(length(labeled_as_on_purple)+length(ground_truth_on_purple)-intersection_length_purple);

weighted_goodness_of_overall_segmentation = 0.5*goodness_of_segmentation_score_purple +0.25*goodness_of_segmentation_score_pink + 0.25*goodness_of_segmentation_score_green;

features = f1;

label_scheme=zeros(m,n);
for i =1 :m
    for j=1:m
        if i<=64 && j<=64
            label_scheme(i,j)=1;
        end
        if i>64
            label_scheme(i,j)=3;
        end
        if i<=64 && j>64
            label_scheme(i,j)=2;
        end
    end
end
total_scheme = [label_scheme label_scheme label_scheme];
total_scheme_reshaped = reshape(total_scheme,[3*m*n,1]);
features_reshaped = reshape(features,[3*m*n,1]);
multiclass_svm_model = fitcecoc(features_reshaped, total_scheme_reshaped);
% fprintf(1, 'Now testing the network\n');
% [predicted_labels,score] = predict(multiclass_svm_model, features_end(701:800,:));
% accuracy = length(find(data.data(701:800) == predicted_labels))/100;
% fprintf(1, 'The accuracy is %d\n', accuracy);
% original_labels = data.data(701:800);
% conf = confusionmat(original_labels,predicted_labels);
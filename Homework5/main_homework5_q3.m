%% Aydın Uzun
% HW 5 06.12.2018
%% question 3
clear;
clf;
berkeley_deer=imread('Berkeley_Deer.jpg');
berkeley_deer=im2double(berkeley_deer);
%extract channels
berkeley_deer_R=berkeley_deer(:,:,1);
berkeley_deer_G=berkeley_deer(:,:,2);
berkeley_deer_B=berkeley_deer(:,:,3);
%get size
[m,n,p]=size(berkeley_deer);

% for threshold= 100 :10: 200 % increase threshold from 10 to 200
% for part e uncomment the below code and comment the upper code
% because my visual judgement gives me the best result when threshold
% is 110.
for threshold= 110
    
    % create a blank deer
    new_deer=zeros(m,n);
    
    % labels uint8 values
    label1=30;
    label2=125;
    label3=220;
    %assume there is a change in the beginning of each thereshold
    change=1;
    
    new_deer(175, 208)=label1; % seed on deer
    new_deer(59, 288)=label2;  % seed on forest
    new_deer(200, 441)=label3; % seed on savannah
    
    
    while(change~=0) % if there's a change
        
        change=0;
        
        %calculate centroids
        region_1 =find(new_deer==label1);
        centroid_R_label1=sum(berkeley_deer_R(region_1))/length(region_1);
        centroid_G_label1=sum(berkeley_deer_G( region_1))/length(region_1);
        centroid_B_label1=sum(berkeley_deer_B(region_1))/length(region_1);
        
        region_2=find(new_deer==label2);
        centroid_R_label2=sum(berkeley_deer_R(region_2))/length(region_2);
        centroid_G_label2=sum(berkeley_deer_G(region_2))/length(region_2);
        centroid_B_label2=sum(berkeley_deer_B(region_2))/length(region_2);
        
        region_3=find(new_deer==label3);
        centroid_R_label3=sum(berkeley_deer_R(region_3))/length(region_3);
        centroid_G_label3=sum(berkeley_deer_G(region_3))/length(region_3);
        centroid_B_label3=sum(berkeley_deer_B(region_3))/length(region_3);
        
        relabeled_deer=new_deer;
        
        for i=2:m-1
            for j=2:n-1
                
                if new_deer(i,j)==0 % if there is no label
                    
                    %8 nbhood
                    % implement the given formula for each channel
                    % if the given condition is satisfied label the pixel
                    % if there is no change terminate it
                    
                    if(relabeled_deer(i-1,j-1)==label1 || relabeled_deer(i-1,j)==label1 ...
                            || relabeled_deer(i-1,j+1)==label1 || relabeled_deer(i,j-1)==label1 ...
                            || relabeled_deer(i,j+1)==label1 || relabeled_deer(i+1,j-1)==label1 ...
                            || relabeled_deer(i+1,j)==label1 || relabeled_deer(i+1,j+1)==label1)
                        square_difference_R_label1 = (berkeley_deer_R(i,j)-centroid_R_label1).^2 ;
                        square_difference_G_label1 = (berkeley_deer_G(i,j)-centroid_G_label1).^2 ;
                        square_difference_B_label1 = (berkeley_deer_B(i,j)-centroid_B_label1).^2 ;
                        if sqrt(square_difference_R_label1+square_difference_G_label1 +square_difference_B_label1) < (threshold/255)
                            % label it if the given condition is satisfied
                            new_deer(i,j)=label1;
                            % and indicate that there is a change
                            change=change+1;
                        end
                    end
                    
                    if(relabeled_deer(i-1,j-1)==label2 || relabeled_deer(i-1,j)==label2 ...
                            || relabeled_deer(i-1,j+1)==label2 || relabeled_deer(i,j-1)==label2 ...
                            || relabeled_deer(i,j+1)==label2 || relabeled_deer(i+1,j-1)==label2 ...
                            || relabeled_deer(i+1,j)==label2 || relabeled_deer(i+1,j+1)==label2)
                        
                        square_difference_R_label2 = (berkeley_deer_R(i,j)-centroid_R_label2).^2 ;
                        square_difference_G_label2 = (berkeley_deer_G(i,j)-centroid_G_label2).^2 ;
                        square_difference_B_label2 = (berkeley_deer_B(i,j)-centroid_B_label2).^2 ;
                        
                        if sqrt(square_difference_R_label2+square_difference_G_label2+square_difference_B_label2)<(threshold/255)
                            % label it if the given condition is satisfied
                            new_deer(i,j)=label2;
                            % and indicate that there is a change
                            change=change+1;
                        end
                    end
                    
                    if(relabeled_deer(i-1,j-1)==label3 || relabeled_deer(i-1,j)==label3 ...
                            || relabeled_deer(i-1,j+1)==label3 || relabeled_deer(i,j-1)==label3 ...
                            || relabeled_deer(i,j+1)==label3 || relabeled_deer(i+1,j-1)==label3 ...
                            || relabeled_deer(i+1,j)==label3 || relabeled_deer(i+1,j+1)==label3)
                        
                        square_difference_R_label3 = (berkeley_deer_R(i,j)-centroid_R_label3).^2 ;
                        square_difference_G_label3 = (berkeley_deer_G(i,j)-centroid_G_label3).^2 ;
                        square_difference_B_label3 = (berkeley_deer_B(i,j)-centroid_B_label3).^2 ;
                        
                        if sqrt(square_difference_R_label3+square_difference_G_label3+square_difference_B_label3)<(threshold/255)
                            new_deer(i,j)=label3;
                            change=change+1;
                        end
                    end
                end
            end
        end
    end
    
    figure();
    imshow(uint8(new_deer));
    title(['Threshold = ',num2str(threshold)]);
    
end

%e
% create groundtruth which is given
load Berkeley_Deer
ground1=groundTruth{1,1}.Boundaries;
ground1=groundTruth{1,2}.Boundaries;

labeled_as_on_raindeer=find(new_deer==label1);
labeled_as_on_forest=find(new_deer==label2);
labeled_as_on_savannah=find(new_deer==label3);

ground_truth_on_raindeer=find(groundTruth{1,1}.Segmentation==2);
ground_truth_on_forest=find(groundTruth{1,1}.Segmentation==1);
ground_truth_on_savannah=find(groundTruth{1,1}.Segmentation==4);

intersection_length_deer=length(intersect(ground_truth_on_raindeer, labeled_as_on_raindeer));
intersection_length_forest = length(intersect(ground_truth_on_forest, labeled_as_on_forest));
intersection_length_savannah = length(intersect(ground_truth_on_savannah, labeled_as_on_savannah));

goodness_of_segmentation_score_deer=intersection_length_deer/(length(labeled_as_on_raindeer)+length(ground_truth_on_raindeer)-intersection_length_deer);
goodness_of_segmentation_score_forest=intersection_length_forest/(length(labeled_as_on_forest)+length(ground_truth_on_forest)-intersection_length_forest);
goodness_of_segmentation_score_savannah=intersection_length_savannah/(length(labeled_as_on_savannah)+length(ground_truth_on_savannah)-intersection_length_savannah);

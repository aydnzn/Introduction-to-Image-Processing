%% EE 475 HW 6
%Aydın Uzun
%2015401210
clear;
%% I
fig_9_3 = zeros(7,15);
fig_9_3(3:5,2:14)=1;
fig_9_3(2,2:4)=1;
fig_9_3(6,2:4)=1;
fig_9_3(2,12:14)=1;
fig_9_3(6,12:14)=1;
se_1 = zeros(3,5);
se_2 = zeros(5,5);
se_3 = zeros(3,3);
se_1(2,3)=1; se_1(2,5)=1; se_1(3,4)=1;
se_2(3,3)=1; se_2(3,5)=1; se_2(4,4)=1; se_2(5,5)=1;
se_3(2,2:3)=1; se_3(1:3,3)=1;
eroded_with_s1 = imerode(fig_9_3,se_1);
eroded_with_s2 = imerode(fig_9_3,se_2);
eroded_with_s3 = imerode(fig_9_3,se_3);
%% II 
% on solution manual 
% on paper
%% III
image = zeros(7,15);
image(4,2:14) = 1;
image(3,2:4)=1;
image(5,2:4)=1;
image(3,12:14)=1;
image(5,12:14)=1;
se = ones(3,3);
opening = imopen(image,se);
closing = imclose(image,se);
%% IV
% on solution manual
f = imread('Figp0917.tif');
se = strel('dis', 11, 0); % Structuring element.
fa = imerode(f, se);
fb = imdilate(fa, se);
fc = imdilate(fb, se);
fd = imerode(fc, se);

figure(1); imshow(fa);
figure(2); imshow(fb);
figure(3); imshow(fc);
figure(4); imshow(fd);

%% V
% https://www.cis.rit.edu/class/simg782/homework/hw3/hw3solutions.pdf
clear;
img = imread('Picture1.png');
img_gray = rgb2gray(img);
[m,n]= size(img_gray);
number_of_black_pixels = sum(sum(img_gray==0));
fraction_white = 1-number_of_black_pixels/(m*n);
%b_
img_gray_binary = imbinarize(img_gray);
connected_components=bwconncomp(img_gray_binary);
number_of_objects = connected_components.NumObjects;
%c 
img_gray_binary_comp = imcomplement(img_gray_binary);
figure(1);
imshow(img_gray_binary_comp);
connected_components_comp=bwconncomp(img_gray_binary_comp);
number_of_comp_objects = connected_components_comp.NumObjects;
%d 
L = bwlabel(img_gray_binary_comp);
L_2 = bwlabel(img_gray_binary);

[m,n]=size(img_gray_binary);
bos = zeros(m,n);

for i=1:m
    for j=1:n
        if((img_gray_binary(i,j)>0)||(L(i,j)==1))
            bos(i,j)=1;
        end
    end
end
imb_bos = imbinarize(bos);
imbos_comp = imcomplement(imb_bos);
imb_bos_labeled = bwlabel(imbos_comp);
counter=0;
pixel_count=0;
%%
% maximum_label = max(max(L_2));
% for k=1:maximum_label
%     for i=1:m
%         for j=1:n
%             if(L_2(i,j)==k)
%                 if(imb_bos_labeled(i,j)>0)
%                     counter=counter+1;
%                 end
%                 if(counter>1)
%                     pixel_count=pixel_count+1;
%                 end
%                 
%             end
%         end
%     end
%     counter=0;
%     
% end

        
   

%%

%e
Struct_element_1 = [1,1,1,1;1,0,0,0;1,0,0,0;1,0,0,0];
Struct_element_2 = [0,0,0;0,1,0;0,0,0];
square_objects = bwhitmiss(img_gray_binary,Struct_element_2,Struct_element_1);
total_number_of_sqaure_objects=sum(sum(square_objects==true));

figure(5); imshow(square_objects);

%f
%g

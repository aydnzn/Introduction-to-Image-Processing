%% Aydın Uzun
% HW 4
% Q3
%%
clear all;
%% 3	Deblurring
clear;
clf;
%a and b
book = imread('book-cover.tif');
book_fft = fft2(book);
[k, l] = size(book);
p=k/2;
q=l/2;
horizontal = 1:k;
vertical = 1:l;
turbulance_filt = zeros(k,l);
const = 0.0025;
for i=1:k
    for j=1:l
        distance=sqrt((i-p)^2+(j-q)^2);
        turbulance_filt(i,j)=exp(-const*((distance)^2)^(5/6));
    end
end
book_fft_shifted=fftshift(book_fft);
book_out_of_turbulance=book_fft_shifted.*turbulance_filt;
book_out_of_turbulance_back_shifted=ifftshift(book_out_of_turbulance);
book_turbulanced=real(ifft2(book_out_of_turbulance_back_shifted));
book_turbulanced=im2uint8(mat2gray(book_turbulanced));

book_noised =imnoise(book_turbulanced, 'gaussian', 0, 625/(256^2));

figure(1); 
imshow(book);
figure(2);
imshow(book_noised);

%c
butterworth_LP=zeros(k,l);
order=10;
cutoff_at_radius=70;
p=k/2;
q=l/2;
for i=1:k
    for j=1:l
        distance=sqrt((i-p)^2+(j-q)^2);
        butterworth_LP(i,j)=1/(1+(distance/cutoff_at_radius)^(2*order));
    end
end

inv_turbulance_filt = zeros(k,l); % thresholding
for i=1:k
    for j=1:l
        if abs(turbulance_filt(i,j))>0.001 
            inv_turbulance_filt(i,j)=1/(turbulance_filt(i,j));
        else
            inv_turbulance_filt(i,j)=0;
        end
    end
end
j = 1i;
book_fft_noised = fft2(book_noised);
book_fft_noised_shifted=fftshift(book_fft_noised);
book_inverse_filtered = book_fft_noised_shifted.*inv_turbulance_filt;
book_inverse_filtered_butterworth_LP = book_inverse_filtered.*butterworth_LP;

book_inverse_filtered_butterworth_LP_inv_shifted=ifftshift(book_inverse_filtered_butterworth_LP);
lP_filtered=real(ifft2(book_inverse_filtered_butterworth_LP_inv_shifted));
lP_filtered=im2uint8(mat2gray(lP_filtered));

figure(3)
imshow(lP_filtered);
%d
camera_motion_filter=zeros(k,l);
camera_motion=zeros(k,l);

a=0.1;
b=0.1;
T = 1;

p1=k/2;
q1=l/2;
j = 0 +1i;
for u=1:k
    for v=1:l
         camera_motion_filter(u,v)=(1/pi*(0.1*(u-p)+0.1*(v-q)))*sin(pi*(0.1*(u-p)+0.1*(v-q)))*exp(-1j*pi*(0.1*(u-p)+0.1*(v-q)));
    end
end
book_motion_filtered=book_fft_shifted.*camera_motion_filter;
book_motion_filtered_inv_shifted=ifftshift(book_motion_filtered);
book_motion_filtered_time=real(ifft2(book_motion_filtered_inv_shifted));
book_motion_filtered_time_image=im2uint8(mat2gray(book_motion_filtered_time));
book_motion_filtered_time_image_gaussian_noised = imnoise(book_motion_filtered_time_image,'gaussian',0,(625/(256^2)));

figure(13);
imshow(book);
figure(14);
imshow(book_motion_filtered_time_image_gaussian_noised,[ ]);

%e
inv_motion_filt = zeros(k,l);
for i=1:k
    for j=1:l
        if abs(camera_motion_filter(i,j))>0.1 %
            inv_motion_filt(i,j)=1/(camera_motion_filter(i,j));
        else
            inv_motion_filt(i,j)=0;
        end
    end
end

book_motion_filtered_time_image_gaussian_noised_fft=fft2(book_motion_filtered_time_image_gaussian_noised);
book_motion_filtered_time_image_gaussian_noised_fft_shifted=fftshift(book_motion_filtered_time_image_gaussian_noised_fft);
inversed_book_motion_filtered_gaussian_noised = book_motion_filtered_time_image_gaussian_noised_fft_shifted.*inv_motion_filt;
inversed_book_motion_filtered_gaussian_noised_time=real(ifft2(inversed_book_motion_filtered_gaussian_noised));
inversed_book_motion_filtered_gaussian_noised_time_image=im2uint8(mat2gray(inversed_book_motion_filtered_gaussian_noised_time));

book_wiener_filtered = wiener2(book_motion_filtered_time_image_gaussian_noised, [5 5]);

figure(15);
imshow(inversed_book_motion_filtered_gaussian_noised_time_image,[]);

figure(16);
imshow(book_wiener_filtered);


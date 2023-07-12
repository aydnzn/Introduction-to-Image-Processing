x = -100:100;
y = -100:100;
[xx yy] = meshgrid(x,y);
u = zeros(size(xx),'uint8');
u((xx.^2+yy.^2)<80^2)=64;
u((xx.^2+yy.^2)<60^2)=128;
u((xx.^2+yy.^2)<40^2)=192;
u((xx.^2+yy.^2)<20^2)=255;

imshow(u)
imwrite(u,'circles.tif')
% This script defines a function called showGist that is used for visualizing the GIST descriptor. Here's what the function does:
% 
% The function takes two input arguments: gist, which is the GIST descriptor, and param, which contains the parameters used for computing the GIST descriptor.
% It determines the dimensions of the gist matrix.
% It extracts information from the param structure, including the number of blocks, filters, and scales.
% It creates a color map based on the number of scales and orientations using the hsv function.
% It reshapes and manipulates the GIST descriptor and the filter responses to prepare them for visualization.
% If there are multiple images, it creates a new figure for displaying the results.
% It iterates over each image and prepares the mosaic of filter responses for visualization.
% It applies some adjustments and converts the mosaic to a grayscale image.
% It uses the montage function to display the mosaic of filter responses in a grid-like layout.
% If there are multiple images, it arranges the subplots accordingly using the subplottight utility function.
% The subplottight function is a utility function used by showGist to create subplots without spacing between axes. It calculates the position of each subplot based on the number of rows, columns, and the subplot index.
% 
% Overall, the showGist function provides a convenient way to visualize the GIST descriptor by displaying the filter responses in a grid-like layout.


function showGist(gist, param)
%
% Visualization of the gist descriptor
%   showGist(gist, param)
%
% The plot is color coded, with one color per scale
%
% Example:
%   img = zeros(256,256);
%   img(64:128,64:128) = 255;
%   gist = LMgist(img, '', param);
%   showGist(gist, param)


[Nimages, Ndim] = size(gist);
nx = ceil(sqrt(Nimages)); ny = ceil(Nimages/nx);

Nblocks = param.numberBlocks;
Nfilters = sum(param.orientationsPerScale);
Nscales = length(param.orientationsPerScale);

C = hsv(Nscales);
colors = [];
for s = 1:Nscales
    colors = [colors; repmat(C(s,:), [param.orientationsPerScale(s) 1])];
end
colors = colors';

[nrows ncols Nfilters] = size(param.G);
Nfeatures = Nblocks^2*Nfilters;

if Ndim~=Nfeatures
    error('Missmatch between gist descriptors and the parameters');
end

G = param.G(1:2:end,1:2:end,:);
[nrows ncols Nfilters] = size(G);
G = G + flipdim(flipdim(G,1),2);
G = reshape(G, [ncols*nrows Nfilters]);


if Nimages>1
    figure;
end

for j = 1:Nimages
    g = reshape(gist(j,:), [Nblocks Nblocks Nfilters]);
    g = permute(g,[2 1 3]);
    g = reshape(g, [Nblocks*Nblocks Nfilters]);
           
    for c = 1:3
        mosaic(:,c,:) = G*(repmat(colors(c,:), [Nblocks^2 1]).*g)';
    end
    mosaic = reshape(mosaic, [nrows ncols 3 Nblocks*Nblocks]);    
    mosaic = fftshift(fftshift(mosaic,1),2);
    mosaic = uint8(mosaic/max(mosaic(:))*255);
    mosaic(1,:,:,:) = 255;
    mosaic(end,:,:,:) = 255;
    mosaic(:,1,:,:) = 255;
    mosaic(:,end,:,:) = 255;
    
    if Nimages>1
        subplottight(ny,nx,j,0.01);
    end
    montage(mosaic, 'size', [Nblocks Nblocks])
end


function h=subplottight(Ny, Nx, j, margin)
% General utility function
%
% This function is like subplot but it removes the spacing between axes.
%
% subplottight(Ny, Nx, j)

if nargin <4 
    margin = 0;
end

j = j-1;
x = mod(j,Nx)/Nx;
y = (Ny-fix(j/Nx)-1)/Ny;
h=axes('position', [x+margin/Nx y+margin/Ny 1/Nx-2*margin/Nx 1/Ny-2*margin/Ny]);


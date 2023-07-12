function [denoised_I] = alphatrim(Img,filter_size,p)
% This function, alphatrim, performs alpha-trimmed filtering on an input image to denoise it.
double_Img = double(Img);
[m, n] = size(Img);
denoised_I = zeros(m,n);
for k = p+1 : ((filter_size * filter_size) - p)
    denoised_I = denoised_I + ordfilt2(double_Img,k,ones(filter_size,filter_size),'zeros');
end
parameter = (filter_size * filter_size) - (2*p);
denoised_I = uint8(denoised_I / parameter);

end



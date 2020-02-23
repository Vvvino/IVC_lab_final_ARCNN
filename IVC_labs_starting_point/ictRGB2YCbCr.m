function [ output ] = ictRGB2YCbCr(image)
%     image = double(input);
%     [m, n, p] = size(image);
%     image_2d = reshape(image, m*n, p);
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    Y = 0.299*R + 0.587*G + 0.114*B;
    Cb = -0.169*R - 0.331*G + 0.5*B;
    Cr = 0.5*R - 0.419*G - 0.081*B;

    output(:,:,1) = Y;
    output(:,:,2) = Cb;
    output(:,:,3) = Cr;
    

end

% function ycgcr = ictRGB2YCbCr(rgb)
% % function ycgcr = rgb2ycgcr(rgb)
% % convert rgb image to ycgcr image
% % Inputs:
% %   rgb    - rgb image
% % 
% % Outputs:
% %   ycgcr  - ycgcr image
% 
% % reshape image to 2d matrix
% rgb = im2double(rgb);
% [m, n, p] = size(rgb);
% rgb_2d = reshape(rgb, m*n, p);
% % convert parameters
% origT = [65.481 128.553 24.966;...
%      -81.085 112 -30.915; ...
%      112 -93.768 -18.214];
% origOffset = [16; 128; 128];
% origOffset_2d = repmat(origOffset, 1, m*n);
% % rgb to ycgcr
% ycgcr = origOffset_2d + origT*rgb_2d';
% ycgcr = ycgcr';
% ycgcr = reshape(ycgcr, m, n, p);
% end



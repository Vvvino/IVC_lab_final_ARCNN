function [ output ] = ictYCbCr2RGB( input )
%ICTYCBCR2RGB Summary of this function goes here
%   Detailed explanation goes here
    image = double(input);
    Y = image(:,:,1);
    Cb = image(:,:,2);
    Cr = image(:,:,3);
    R = Y + 1.402*(Cr);
    G = Y - 0.344*(Cb) - 0.714*(Cr);
    B = Y + 1.772*(Cb);
    output(:,:,1) = R;
    output(:,:,2) = G;
    output(:,:,3) = B;

end


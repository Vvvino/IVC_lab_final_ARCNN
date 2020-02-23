function coeff = DCT8x8(block)
%  Input         : block    (Original Image block, 8x8x3)
%   
%  Output        : coeff    (DCT coefficients after transformation, 8x8x3)
         coeff(:,:,1) = dct2(block(:,:,1));
         coeff(:,:,2) = dct2(block(:,:,2));
         coeff(:,:,3) = dct2(block(:,:,3));
end
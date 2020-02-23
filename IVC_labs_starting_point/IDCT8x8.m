function block = IDCT8x8(coeff)
%  Function Name : IDCT8x8.m
%  Input         : coeff (DCT Coefficients) 8*8*3
%  Output        : block (original image block) 8*8*3
         block(:,:,1) = idct2(coeff(:,:,1));
         block(:,:,2) = idct2(coeff(:,:,2));
         block(:,:,3) = idct2(coeff(:,:,3));
end
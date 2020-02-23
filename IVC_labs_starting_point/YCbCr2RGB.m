function [image_RGB] = YCbCr2RGB( image_YCbCr_PCA,T,offset)

Y = image_YCbCr_PCA(:,:,1);
Cb = image_YCbCr_PCA(:,:,2);
Cr = image_YCbCr_PCA(:,:,3);

Y_offset = offset(1,1);
Cb_offset = offset(2,1);
Cr_offset = offset(3,1);

in_T = inv(T);
image_RGB(:,:,1) = in_T(1,1)*(Y-Y_offset)+ in_T(1,2)*(Cb-Cb_offset)+in_T(1,3)*(Cr-Cr_offset);
image_RGB(:,:,2) = in_T(2,1)*(Y-Y_offset)+ in_T(2,2)*(Cb-Cb_offset)+in_T(2,3)*(Cr-Cr_offset);
image_RGB(:,:,3) = in_T(3,1)*(Y-Y_offset)+ in_T(3,2)*(Cb-Cb_offset)+in_T(3,3)*(Cr-Cr_offset);

end


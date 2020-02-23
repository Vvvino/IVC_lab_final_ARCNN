function [image_RGB] = YCbCr2RGB_2( image_YCbCr_PCA,T,offset)

Y = image_YCbCr_PCA(:,:,1);
Y = Y(:)';
Cb = image_YCbCr_PCA(:,:,2);
Cb = Cb(:)';
Cr = image_YCbCr_PCA(:,:,3);
Cr = Cr(:)';

Y_offset = offset(1,1);
Cb_offset = offset(2,1);
Cr_offset = offset(3,1);




image_RGB(:,:,1) = T(1,1)*(Y)+ T(1,2)*(Cb)+T(1,3)*(Cr)+Y_offset;
image_RGB(:,:,2) = T(2,1)*(Y)+ T(2,2)*(Cb)+T(2,3)*(Cr)+Cb_offset;
image_RGB(:,:,3) = T(3,1)*(Y)+ T(3,2)*(Cb)+T(3,3)*(Cr)+Cr_offset;

end
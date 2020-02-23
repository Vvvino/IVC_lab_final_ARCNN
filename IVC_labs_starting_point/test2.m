clear;
image = double(imread('foreman20_40_RGB/foreman0020.bmp'));
[image_YCbCr_PCA,T,offset] = RGB2YCbCr(image);
image_RGB = YCbCr2RGB(image_YCbCr_PCA,T,offset);
PSNR = calcPSNR(image,image_RGB);
clc
clear;

E2_5
path(path,'encoder')          
path(path,'decoder')            
path(path,'analysis') 

input =  double(imread('data/images/lena.tif'));
[l,w,d] = size(input);
YCbCr = ictRGB2YCbCr(input);

Y = YCbCr(:,:,1);

Cb = YCbCr(:,:,2);
Cb = resample(resample(Cb,1,2)',1,2)';

Cr = YCbCr(:,:,3);
Cr = resample(resample(Cr,1,2)',1,2)';

pre_Y = zeros(l,w);
pre_Cb = zeros(l/2,w/2);
pre_Cr = zeros(l/2,w/2);

err_Y = zeros(l,w);
err_Cb = zeros(l/2,w/2);
err_Cr = zeros(l/2,w/2);

D_Y = zeros(l,w);
D_Cb = zeros(l/2,w/2);
D_Cr = zeros(l/2,w/2);

for i =1:l-1
    for j = 1:w-1
        pre_Y(i+1,j+1) = (7/8)*Y(i+1,j) -(1/2)*Y(i,j) +(5/8)*Y(i,j+1);
        err_Y(i,j) = Y(i,j) - pre_Y(i,j);
    end
end

% err_Y = Y - pre_Y;

for i =1:l/2-1
    for j = 1:w/2-1
        pre_Cb(i+1,j+1) = (3/8)*Cb(i+1,j) -(1/4)*Cb(i,j) +(7/8)*Cb(i,j+1);
        err_Cb(i,j) = Cb(i,j) - pre_Cb(i,j);
        
        pre_Cr(i+1,j+1) = (3/8)*Cr(i+1,j) -(1/4)*Cr(i,j) +(7/8)*Cr(i,j+1);
        err_Cr(i,j) = Cr(i,j) - pre_Cr(i,j);
    end
end

% err_Cb = Cb - pre_Cb;
% err_Cr = Cr - pre_Cr;

err_Y_Enc = err_Y(:);
err_Cb_Enc = err_Cb(:);
err_Cr_Enc = err_Cr(:);
err = [err_Y_Enc;err_Cb_Enc;err_Cr_Enc];
err = round(err);

[bytestream] = enc_huffman_new(err+256, BinCode, Codelengths);
bitrate = (length(bytestream)*8)/(512*512); 
err_Dec = dec_huffman_new(bytestream, BinaryTree, length(err))-256;

err_Y_Dec = err_Dec(1:size(err_Y,1)*size(err_Y,2));
err_Y_Dec = reshape(err_Y_Dec,size(err_Y,1),size(err_Y,2));

err_Cb_Dec = err_Dec(size(err_Y,1)*size(err_Y,2)+1:size(err_Y,1)*size(err_Y,2)+size(err_Cb,1)*size(err_Cb,2));
err_Cb_Dec = reshape(err_Cb_Dec,size(err_Cb,1),size(err_Cb,2));

err_Cr_Dec = err_Dec(size(err_Y,1)*size(err_Y,2)+size(err_Cb,1)*size(err_Cb,2)+1:size(err_Y,1)*size(err_Y,2)+size(err_Cb,1)*size(err_Cb,2)+size(err_Cr,1)*size(err_Cr,2));
err_Cr_Dec = reshape(err_Cr_Dec,size(err_Cr,1),size(err_Cr,2));

Y_Dec = err_Y_Dec + pre_Y;
Cb_Dec = err_Cb_Dec + pre_Cb;
Cr_Dec = err_Cr_Dec + pre_Cr;

Cb_D = resample(resample(Cb_Dec,2,1)',2,1)';
Cr_D = resample(resample(Cr_Dec,2,1)',2,1)';

output = zeros(512,512,3);

output(:,:,1) = Y_Dec;
output(:,:,2) = Cb_D;
output(:,:,3) = Cr_D;
% imshow(output/256);

[output_RGB] = ictYCbCr2RGB(output);
imshow(output_RGB/256);
PSNR = calcPSNR(input,output_RGB)


save output_RGB.mat output_RGB

















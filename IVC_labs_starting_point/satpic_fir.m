clear;
img1 = double(imread('data/images/satpic1.bmp'));   
pre1(:,:,1) = twoDFIR(img1(:,:,1));
pre1(:,:,2) = twoDFIR(img1(:,:,2));
pre1(:,:,3) = twoDFIR(img1(:,:,3));
img2 = downsample(pre1,2);
img3 = img2(:,1:2:end,:);
img4 = upsample(img3,2);
for i = 1:3;
    img5(:,:,i) = img4(:,:,i)';
end
img6 = upsample(img5,2);
for i = 1:3;
    img6(:,:,i) = img6(:,:,i)';
end
imgr1(:,:,1) = twoDFIR(img6(:,:,1));
imgr1(:,:,2) = twoDFIR(img6(:,:,2));
imgr1(:,:,3) = twoDFIR(img6(:,:,3));
imgr2 = imgr1 *4;
a1 = calcPSNR((img1),(imgr2));
b1 = calcMSE((img1),(imgr2));
%subplot(1,2,1),imshow(img1);subplot(1,2,2),imshow(imgr2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imga = uint8(img1);
imgb = downsample(img1,2);
imgc = imgb(:,1:2:end,:);
imgd = upsample(imgc,2);
for i = 1:3
    imge(:,:,i) = imgd(:,:,i)';
end
imgf = upsample(imge,2);
for i = 1:3;
    imgf(:,:,i) = imgf(:,:,i)';
end
imgrg(:,:,1) = twoDFIR(imgf(:,:,1));
imgrg(:,:,2) = twoDFIR(imgf(:,:,2));
imgrg(:,:,3) = twoDFIR(imgf(:,:,3));
imgrh = imgrg *4;
a2 = calcPSNR((img1),(imgrh));
b2 = calcMSE((img1),(imgrh));


clear;
img1 = double(imread('data/images/sail.tif')); 
img2 = ictRGB2YCbCr(img1);
img2 = double(img2);
Y = img2(:,:,1);
Cb = img2(:,:,2);
[m,n] = size(Cb);
Cr = img2(:,:,3);
[w,l] = size(Cr);
for i= 1:m
    a(i,:) = resample(Cb(i,:),1,2);
    b(:,i) = a(i,:)';
end
for i = 1:n/2
    h(i,:) = resample(b(i,:),1,2);
    k(:,i) = h(i,:)';
end
for i= 1:m/2
    c(i,:) = resample(k(i,:),2,1);
    d(:,i) = c(i,:)';
end
for i= 1:n
    e(i,:) = resample(d(i,:),2,1);
    f(:,i) = e(i,:)';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i= 1:w
    o(i,:) = resample(Cr(i,:),1,2);
    p(:,i) = o(i,:)';
end
for i = 1:l/2
    q(i,:) = resample(p(i,:),1,2);
    r(:,i) = q(i,:)';
end
for i= 1:w/2
    s(i,:) = resample(r(i,:),2,1);
    t(:,i) = s(i,:)';
end
for i= 1:l
    u(i,:) = resample(t(i,:),2,1);
    v(:,i) = u(i,:)';
end
Cbnew = f;
Crnew = v;
final(:,:,1)=Y;
final(:,:,2)=Cbnew;
final(:,:,3)=Crnew;
img4 = ictYCbCr2RGB(final);

subplot(2,2,1),imshow(uint8(img1)),title('orginalrgb');
subplot(2,2,2),imshow(uint8(img2));title('orginalycbcr');
subplot(2,2,3),imshow(uint8(final));title('reconstructedycbcr');
subplot(2,2,4),imshow(uint8(img4));title('reconstructedrgb');
PSNR = calcPSNR(uint8(img1),uint8(img4));

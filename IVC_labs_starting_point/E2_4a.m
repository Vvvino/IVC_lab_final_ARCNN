% clear;
% input1 = double(imread('data/images/lena.tif'));
% input1(:,:,1) = input1(:,:,1)';
% input1(:,:,2) = input1(:,:,2)';
% input1(:,:,3) = input1(:,:,3)';
% im = input1(:);
% j = 1;
% for i = 1:2:length(im)
%     e(j) = im(i)-im(i+1);
%     j = j + 1;
% end
% error_entropy = calc_entropy(e(:));
clear;
input1 = double(imread('data/images/lena.tif'));
input1(:,:,1) = input1(:,:,1)';
input1(:,:,2) = input1(:,:,2)';
input1(:,:,3) = input1(:,:,3)';
im = input1(:);
for i = 1:length(im)-1
    e(i) = im(i)-im(i+1);
end
error_entropy = calc_entropy(e(:));




    
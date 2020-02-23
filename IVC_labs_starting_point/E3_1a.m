clear;
bits = 2;
image = double(imread('data/images/lena_small.tif'));
image1 = image / 256;
image1_1 = image1(:,:,1);
image1_2 = image1(:,:,2);
image1_3 = image1(:,:,3);
image1_1 = image1_1(:);
image1_2 = image1_2(:);
image1_3 = image1_3(:);
image2 = [image1_1;image1_2;image1_3];
[m,n] = size(image2);
[w,l] = size(image1(:,:,1));
class(1)=0;
for k = 2:(2^bits)
    class(k) = k-1;
end

for i = 1:m
    for j = 1:(2^bits)
            if image2(i)>=(j-1)/(2^bits) && image2(i)<(j)/(2^bits)
                image2(i) = class(j);
            end
    end
end
image2_1 = image2(1:m/3);
image2_2 = image2(m/3+1:(2/3)*m);
image2_3 = image2((2/3)*m+1:m);

image2_1_1 = reshape(image2_1,[w,l]);
image2_2_2 = reshape(image2_2,[w,l]);
image2_2_3 = reshape(image2_3,[w,l]);

qImage = zeros(w,l,3);

qImage(:,:,1) = image2_1_1;
qImage(:,:,2) = image2_2_2;
qImage(:,:,3) = image2_2_3;

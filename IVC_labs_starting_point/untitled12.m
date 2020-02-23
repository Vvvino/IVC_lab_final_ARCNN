clear;
scales = 1 : 0.6 : 1;
for scaleIdx = 1 : numel(scales)
    qScale   = scales(scaleIdx);
end
image = double(imread('data/images/lena_small.tif'));
dst = IntraEncode(image, qScale)
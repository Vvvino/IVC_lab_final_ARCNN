clc
clear;

path(path,'encoder')          
path(path,'decoder')            
path(path,'analysis')           

input = double(imread('data/images/lena_small.tif'));
[l,w,d] = size(input);
output = ictRGB2YCbCr(input);

pre = zeros(l,w,d);
err = zeros(l,w,d);

for i =1:l-1
    for j = 1:w-1
        pre(i+1,j+1,1) = (7/8)*output(i+1,j,1) -(1/2)*output(i,j,1) +(5/8)*output(i,j+1,1);
        pre(i+1,j+1,2) = (3/8)*output(i+1,j,2) -(1/4)*output(i,j,2) +(7/8)*output(i,j+1,2);
        pre(i+1,j+1,3) = (3/8)*output(i+1,j,3) -(1/4)*output(i,j,3) +(7/8)*output(i,j+1,3);
    end
end
err = output - pre;
PMF = hist(err(:),-255:255);
PMF = PMF/sum(PMF);
[BinaryTree, HuffCode, BinCode, Codelengths] = buildHuffman(PMF);
Max = max(Codelengths);
Min = min(Codelengths);
Codenumber = numel(Codelengths);

path( path, 'analysis' )

path( path, 'encoder' )

path( path, 'decoder' )

%% Main

bits = 8;

epsilon = 0.1;

block_size = 2;

%% lena small for VQ training

image_small = double(imread('data/images/lena_small.tif'));

[clusters] = VectorQuantizer(image_small, bits, epsilon, block_size);

qImage_small = ApplyVectorQuantizer(image_small, clusters, block_size);

%% Huffman table training

PMF = hist(qImage_small(:),1:2^bits);

PMF = PMF/sum(PMF);

[BinaryTree, HuffCode, BinCode, Codelengths] = buildHuffman(PMF);

%%

image = double(imread('data/images/lena.tif'));

qImage = ApplyVectorQuantizer(image, clusters, block_size);

%% Huffman encoding

bytestream=enc_huffman_new(qImage(:),BinCode,Codelengths);

%%

bpp = (numel(bytestream) * 8) / (numel(image)/3);

%% Huffman decoding

qReconst_image = dec_huffman_new(bytestream,BinaryTree,length(qImage(:)));

qReconst_image = reshape(qReconst_image,size(qImage));

%%

reconst_image = InvVectorQuantizer(qReconst_image, clusters, block_size);

PSNR = calcPSNR(image, reconst_image);

%% sub-functions

function [clusters] = VectorQuantizer(image, bits, epsilon, block_size)

image1_1 = image(:,:,1);
image1_2 = image(:,:,2);
image1_3 = image(:,:,3);
image1_1_1 = image1_1(:);
image1_2_2 = image1_2(:);
image1_3_3 = image1_3(:);
[m,n] = size(image1_1);

intervals = zeros(1,2^bits);
for i =1:2^bits
    intervals(i) = (0.5*(255/(2^bits))+(i-1)*(255/(2^bits)));  
end
intervals = repmat(intervals,block_size^2,1)';
Quantization_table = intervals;
vectorized_image_blocks1 = zeros((m/block_size)*(n/block_size),block_size^2);
vectorized_image_blocks2 = zeros((m/block_size)*(n/block_size),block_size^2);
vectorized_image_blocks3 = zeros((m/block_size)*(n/block_size),block_size^2);
i = 1;
h = 1;
v = 1;
  
for j = 1:2:m
   for k = 1:m/2   
            vectorized_image_blocks1(i,:) = [image1_1(j,2*k-1);image1_1(j,2*k);image1_1(j+1,2*k-1);image1_1(j+1,2*k)]; 
            i = i+1;            
   end         
end 
    
for p = 1:2:m
   for q = 1:m/2   
            vectorized_image_blocks2(h,:) = [image1_2(p,2*q-1);image1_2(p,2*q);image1_2(p+1,2*q-1);image1_2(p+1,2*q)]; 
            h = h+1;            
   end         
end   

for x = 1:2:m
   for c = 1:m/2   
            vectorized_image_blocks3(v,:) = [image1_3(x,2*c-1);image1_3(x,2*c);image1_3(x+1,2*c-1);image1_3(x+1,2*c)]; 
            v = v+1;            
   end         
end
vectorized_image_blocks = [vectorized_image_blocks1;vectorized_image_blocks2;vectorized_image_blocks3];

Q_pixel = zeros(size(vectorized_image_blocks));
Distortion =999999999;
check = Distortion;
OOOOO= 1;
 
while check >= epsilon 
[I, D]   = knnsearch(Quantization_table, vectorized_image_blocks, 'Distance', 'euclidean');

sum_pixel = zeros(2^bits,4);
B_q = zeros(2^bits,1);

for i =1:2^bits   
        y=find(I==i);
        B_q(i)=numel(y);
        sum_pixel(i,:) = sum(vectorized_image_blocks(y,:));
end

Quantization_table_1 = (sum_pixel./B_q);
   
zero_pnt = find(B_q==0); 
zero_pnt_num = numel(zero_pnt);
for loop2 = 1:zero_pnt_num
    [max_val,Idx] = max(B_q);
    Quantization_table_1(zero_pnt(loop2),:) = Quantization_table_1(Idx,:);
    Quantization_table_1(zero_pnt(loop2),4) = Quantization_table_1(Idx,4)+1;
    B_q(Idx) = ceil(max_val/2);
    B_q(zero_pnt(loop2)) = floor(max_val/2);            
end
Distortion1 = mean(D.^2);
check = (abs(Distortion-Distortion1))/Distortion;
Distortion = Distortion1;
OOOOO = OOOOO+1;
end
clusters = Quantization_table_1;
end

function qImage = ApplyVectorQuantizer(image, clusters, bsize)

Size = size(image);

n = 1;

for i = 1:Size(3)

for k = 1:2:Size(2)-1

for j = 1:2:Size(1)-1

block(n,1) = image(j,k,i);

block(n,2) = image(j+1,k,i);

block(n,3) = image(j,k+1,i);

block(n,4) = image(j+1,k+1,i);

n = n+1;

end

end

end

[I, D] = knnsearch(clusters,block,'Distance', 'euclidean');

qImage = reshape(I,Size(1)/2,Size(2)/2,Size(3));

end

function image = InvVectorQuantizer(qImage, clusters, block_size)

Size = size(qImage);

I = qImage(:);

qblock = clusters(I,:);

n = 1;

for i = 1:Size(3)

for k = 1:2:2*Size(2)-1

for j = 1:2:2*Size(1)-1

image(j,k,i) = qblock(n,1);

image(j+1,k,i) = qblock(n,2);

image(j,k+1,i) = qblock(n,3);

image(j+1,k+1,i) = qblock(n,4);

n = n+1;

end

end

end

end

function PSNR = calcPSNR(Image, recImage)

PSNR=10*log10((256-1)^2/calcMSE(Image,recImage));

end

function MSE = calcMSE(Image, recImage)

[n1,n2,dim]= size(Image);

MSE = sum((Image(:)-recImage(:)).^2)/(n1*n2*dim);

end


clear;
bits = 8;
epsilon = 0.1;
block_size = 2;
image1 = double(imread('data/images/lena_small.tif'));
image1_1 = image1(:,:,1);
image1_2 = image1(:,:,2);
image1_3 = image1(:,:,3);
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





        
  





    


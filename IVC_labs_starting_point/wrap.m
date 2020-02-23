function [ output ] = wrap(input)
input1 = padarray(input,[4 4],'both','symmetric');
input1 = double(input1);
for i= 1:3
    re1(:,:,i) = resample(input1(:,:,i),1,2,3);
    re2(:,:,i) = re1(:,:,i)';
    re3(:,:,i) = resample(re2(:,:,i),1,2,3);
    re4(:,:,i) = re3(:,:,i)';
end
[wide,length,dims] = size(re4);
input2 = re4(3:wide-2,3:length-2,:);
input3 = padarray(input2,[2 2],'both','symmetric');
input3 = double(input3);
for i= 1:3
    reA(:,:,i) = resample(input3(:,:,i),2,1,3);
    reB(:,:,i) = reA(:,:,i)';
    reC(:,:,i) = resample(reB(:,:,i),2,1,3);
    reD(:,:,i) = reC(:,:,i)';
end
[w,l,d] = size(reD);
output = reD(5:w-4,5:l-4,:);
output = uint8(output);

subplot(1,2,1),imshow(input);subplot(1,2,2),imshow(output);
PSNR = calcPSNR(input,output);


end


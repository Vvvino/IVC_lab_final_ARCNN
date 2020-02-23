function [qImage, clusters] = LloydMax(image, bits, epsilon)
image1_1 = image(:,:,1);
image1_2 = image(:,:,2);
image1_3 = image(:,:,3);
image1_1 = image1_1(:);
image1_2 = image1_2(:);
image1_3 = image1_3(:);
image2 = [image1_1;image1_2;image1_3];

intervals = zeros(1,2^bits);
for i =1:2^bits
    intervals(i) = ceil(0.5*(255/(2^bits))+(i-1)*(255/(2^bits)));  
end
intervals = intervals';

Q_pixel = zeros(size(image2));
Distortion = mean((Q_pixel - image2).^2);
check = Distortion;
[m,n] = size(image2);
[w,l] = size(image(:,:,1));


while check >= epsilon   
    sum_pixel = zeros(2^bits,1);
    B_q = zeros(2^bits,1);
    [Idx,D] = knnsearch(intervals,image2);
    Q_pixel = ceil(intervals(Idx));

    for i =1:2^bits   
        y=find(Idx==i);
        B_q(i)=numel(y);
        sum_pixel(i) = sum(image2(y));
    end

    intervals = (sum_pixel./B_q);
    Distortion1 = mean(D.^2);
    check = (abs(Distortion-Distortion1))/Distortion;
    Distortion = Distortion1;
    qImage = reshape(Idx,[w,l,3]);
    clusters = intervals;
end


end


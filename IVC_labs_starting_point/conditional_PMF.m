function [ joint_PMF1, conditional_PMF ] = conditional_PMF( input )
input(:,:,1) = input(:,:,1)';
input(:,:,2) = input(:,:,2)';
input(:,:,3) = input(:,:,3)';
im = input(:);
joint_PMF1 = zeros(256,256);
for i = 1:length(im)-1
    joint_PMF1(im(i),im(i+1)) =  joint_PMF1(im(i),im(i+1)) + 1;
end
joint_PMF1 = joint_PMF1/sum(joint_PMF1(:));
joint_PMF1 = joint_PMF1 +0.0000000000000001;
conditional_PMF = (joint_PMF1)./sum(joint_PMF1);
%conditional_PMF = conditional_PMF/sum(conditional_PMF(:));
end


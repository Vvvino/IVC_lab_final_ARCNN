function [joint_PMF] = joint_PMF(input)
input(:,:,1) = input(:,:,1)';
input(:,:,2) = input(:,:,2)';
input(:,:,3) = input(:,:,3)';
im = input(:);
joint_PMF = zeros(256,256);
for i = 1:2:length(im)
    joint_PMF(im(i),im(i+1)) =  joint_PMF(im(i),im(i+1)) + 1;
end
joint_PMF = joint_PMF/sum(joint_PMF(:));
end


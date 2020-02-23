clear;
input = double(imread('data/images/lena.tif'));
[joint_PMF1, conditional_PMF] = conditional_PMF(input);
mesh(conditional_PMF);
condition_entropy = -sum(sum(joint_PMF1.*log2(conditional_PMF)));
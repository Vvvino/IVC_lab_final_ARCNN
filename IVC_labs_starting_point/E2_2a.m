clear;
input = double(imread('data/images/lena.tif'));
joint_PMF = joint_PMF(input);
mesh(joint_PMF);
joint_PMF=joint_PMF(joint_PMF~=0);
joint_entropy = -sum(sum(joint_PMF.*log2(joint_PMF)));
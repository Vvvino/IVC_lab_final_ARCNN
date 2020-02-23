function [output] = prefilterlowpass2d(input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
W1 = [1 2 1;2 4 2;1 2 1];
W1 = W1/sum(sum(W1));
output = conv2(input,W1,'same');
end


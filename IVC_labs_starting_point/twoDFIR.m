function [ output ] = twoDFIR( input )
%2_DFIR Summary of this function goes here
%   Detailed explanation goes here
w = fir1(40,0.5)
W2 = w'*w;
W2 = W2/sum(sum(W2));
output = conv2(input,W2,'same');


end


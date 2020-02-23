function [ M_entropy ] = MWL( input1,input2,input3 )
input1 = double(input1);
input2 = double(input2);
input3 = double(input3);
Px1 = stats_marg(input1);
Px2 = stats_marg(input2);
Px3 = stats_marg(input3);
Common = cat(2,input1,input2,input3);
Pc = stats_marg(Common);
M_entropy(1) = -sum(Px1.*log2(Pc));
M_entropy(2) = -sum(Px2.*log2(Pc));
M_entropy(3) = -sum(Px3.*log2(Pc));

end


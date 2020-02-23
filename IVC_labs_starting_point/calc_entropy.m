function [marg_entropy] = calc_entropy(input)
PMF = stats_marg(input);
Px = PMF(PMF~=0);
marg_entropy = -sum(Px.*log2(Px));
end


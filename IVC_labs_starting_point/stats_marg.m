function [ PMF ] = stats_marg( input )
lower_bound = -255;
upper_bound = 255;
PMF = hist(input(:),lower_bound:upper_bound);
PMF = PMF/sum(PMF);
end


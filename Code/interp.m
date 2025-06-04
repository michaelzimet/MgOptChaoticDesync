function [uinterp] = interp(tinterp,topt,uopt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ind1 = length(topt) - sum(topt > tinterp);

if tinterp > max(topt) || tinterp < min(topt)
    uinterp = 0;
elseif  ind1 == length(uopt)
    uinterp = uopt(ind1);
else
    m = (uopt(ind1+1) - uopt(ind1)) / (topt(ind1+1)-topt(ind1));
    uinterp = uopt(ind1) + m*(tinterp - topt(ind1));
end
end
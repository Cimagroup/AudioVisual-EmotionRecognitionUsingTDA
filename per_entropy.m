
function [entropy,m,L] = per_entropy(intervals)
% Compute the persistence entropy of a set of intervals. L is the total

m = size(intervals,1);
l = zeros(m,1);
for i = 1:m
    l(i) = intervals(i,2) - intervals(i,1);
end
L = sum(l);
l = l/L;
l = l.*log(l);
entropy = -sum(l);

end

s = 100;
D = 3;
theta = 11/20;
N = (s^(1/(theta*D)));
T = 100;
loc_k = ones(T,1);
diff_K = ones(T,1);

for iter = 1:T
    loc = (N/sqrt(2*log(s)))*randn(D,s);
    loc = round(loc);
    loc = unique(loc.','rows').';
    loc_k(iter) = size(loc,2);
    [loc_diffs, hasCollision] = getDiffs(loc);
    diff_K(iter) = size(loc_diffs,2);
    if mod(iter, 50) == 0
        iter
    end
end

mean(loc_k)
mean(diff_K)/s^2
mean(diff_K)
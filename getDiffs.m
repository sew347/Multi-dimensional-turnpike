%function getDiffs(loc)
%--------------------------------------------------------------------------
%Returns the sorted pairwise difference set of column vectors in loc.
%Sorting is in the sense of function vectorSign.
%--------------------------------------------------------------------------
%Inputs:
%loc: matrix of column vectors.
%--------------------------------------------------------------------------
%Outputs:
%dists_return: pairwise difference set of columns in loc.
%has_collision: true if differences were not unique.
%--------------------------------------------------------------------------
function [dists_return, has_collision] = getDiffs(loc)
    [dim, N] = size(loc);
    dists = zeros(dim,N^2);
    idx = 1;
    for i = 1:N
        for j = 1:N
            dists(:,idx) = (loc(:,i)-loc(:,j));
            idx = idx+1;
        end
    end
    dists_return = unique(dists.','rows').';
    has_collision = (length(dists_return) < N^2 - N + 1);
end
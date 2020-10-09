%testIntersection.m
%--------------------------------------------------------------------------
%tests whether a given collaboration could be a solution
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%tC = collaboration to be tested
%diffs = difference set of unknown set
%n_diffs = number of vectors in diffs
%tk = minimum number of elements needed to generate a difference set of
%size n_diffs
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%is_soln = true if tC is a solution
%is_valid = true if diffs contains n_diffs
%--------------------------------------------------------------------------
function [is_soln, is_valid] = testIntersection(tC,diffs,n_diffs, tk)
    is_soln = false;
    is_valid = false;
    if size(tC,2) >= tk
        %confirm difference set contains W
        tC_diff = getDiffs(tC);
        n_tC_diff = size(tC_diff,2);
        if n_tC_diff > n_diffs
            contains_dist = setdiff(diffs',tC_diff','rows');
            if isempty(contains_dist)
                is_soln = false;
                is_valid = true;
            end
        elseif n_tC_diff == n_diffs
            %check if tC is a solution
            sym_diff = union(setdiff(diffs',tC_diff','rows'),setdiff(tC_diff',diffs','rows'),'rows')';
            if isempty(sym_diff)
                is_soln = true;
                is_valid = true;
            end
        end
    end
end
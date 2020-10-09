%intersectionStep.m
%--------------------------------------------------------------------------
%Computes the ordering of diffs by rand_vec, and returns diffs \cap diffs+u1
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%diffs = difference set of unknown points
%rand_vec = vector used for ordering
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%U_int = diffs \cap diffs+u1
%u1 = difference between two least entries in U after ordering
%u_max = largest vector when ordered by rand_vec
%--------------------------------------------------------------------------

function [U_int, u1, u_max] = intersectionStep(diffs, rand_vec)
    idx = ceil(size(diffs,2)/2);
    D = size(diffs,1);
    diff_proj = matrixDot(diffs, rand_vec);
    %select the vectors which have nonnegative projections
    [diff_proj, projsort] = sort(diff_proj);
    diff_sort = vectorOrder(diffs, projsort);
    diff_sort = diff_sort(:, idx:length(diff_sort));

    %intersection step
    u1 = diff_sort(:,length(diff_sort)) - diff_sort(:,length(diff_sort)-1);
    u_max = diff_sort(:,end);
    dist_plus = diff_sort + u1;
    intersection = intersect(dist_plus.',diff_sort.','rows').';
    U_int = union(zeros(1,D),intersection.','rows').';
end
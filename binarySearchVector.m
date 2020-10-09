%binarySearchVector.m
%--------------------------------------------------------------------------
%Performs a binary search for target on the *sorted* matrix of column
%vectors S. Ordering is in the sense of function vectorSign.
%--------------------------------------------------------------------------
%Inputs:
%target: Column vector
%S: *sorted* matrix of column vectors of same length as target.
%--------------------------------------------------------------------------
%Outputs:
%containsFlag: true if target is in S, false otherwise.
%--------------------------------------------------------------------------
function containsFlag = binarySearchVector(target,S)
    len = size(S,2);
    while(len > 0)
        midpoint = ceil(len/2);
        sgn = vectorSign(target,S(:,midpoint));
        if sgn == 0
            containsFlag = true;
            return;
        elseif sgn == 1
            S = S(:,(midpoint + 1):end);
        else
            S = S(:,1:(midpoint-1));
        end
        len = size(S,2);
    end
    containsFlag = false;
end
%function vectorSign(x,y)
%--------------------------------------------------------------------------
%Returns the relative ordering of two column vectors of the same size. 
%Ordering is according to the first coordinate, with ties broken by
%ordering in the second coordinate, etc. Returns 1 if x > y, -1 if x < y,
%and 0 if the vectors are the same.
%--------------------------------------------------------------------------
%vectorSign.m
%--------------------------------------------------------------------------
%Inputs:
%--------------------------------------------------------------------------
%x, y: Column vectors of the same length.
%--------------------------------------------------------------------------
%Outputs:
%sgn: 1 if x > y in the sense above,-1 if x<y,0 if x = y.
%--------------------------------------------------------------------------
function sgn = vectorSign(x,y)
    for i = 1:size(x,1)
        if x(i) > y(i)
            sgn = 1;
            return;
        elseif x(i) < y(i)
            sgn = -1;
            return;
        end
    end
    sgn = 0;
end
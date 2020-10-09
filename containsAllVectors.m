%containsAllVectors.m
%--------------------------------------------------------------------------
%Checks if tU contains all vectors in req_vecs
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%tU: matrix with column vectors
%req_vecs: matrix with columns vectors
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%has_required: true iff tU contains each column in req_vecs
%--------------------------------------------------------------------------
function has_required = containsAllVectors(req_vecs,tU)
    has_required = true;
    for i = 1:size(req_vecs,2)
        if ~binarySearchVector(req_vecs(:,i),tU)
            has_required = false;
            return;
        end
    end
end
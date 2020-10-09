%getValidCollaborations.m
%--------------------------------------------------------------------------
%Computes base offsets for collaborations by taking intersections
%U \cap U - u1_1 \cap U - u1_max and U \cap U + u1_1 \cap U + u1_max
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%U: output of intersection step
%min_max: u1_1 and u1_max
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%U_int_plus: U \cap U - u1_1 \cap U - u1_max
%U_int_minus: U \cap U + u1_1 \cap U + u1_max
%--------------------------------------------------------------------------
function [U_int_plus, U_int_minus] = getValidCollaborations(U,min_max)
    U_int_plus = U;
    U_int_minus = U;
    for i = 1:2
        if (size(U_int_plus,2)+size(U_int_minus,2)) > 1
            U_int_plus = intersect(U_int_plus',(U-min_max(:,i))','rows')';
            U_int_minus = intersect(U_int_minus',(U+min_max(:,i))','rows')';
        end
    end
end
%vectorOrder.m
%--------------------------------------------------------------------------
%Puts column vectors in V in a specified order.
%--------------------------------------------------------------------------
%Inputs: 
%--------------------------------------------------------------------------
%V, matrix of column vectors to be ordered
%order, vector indicating the desired order
%--------------------------------------------------------------------------
%Outputs:
%--------------------------------------------------------------------------
%inOrder, columns of V in given order 
%--------------------------------------------------------------------------
function inOrder = vectorOrder(V,order)
    inOrder = zeros(size(V));
    for i = 1:length(order)
        inOrder(:,i) = V(:,order(i));
    end
end
%function matrixDot(M,v)
%--------------------------------------------------------------------------
%Computes the dot product of each column in M against vector v.
%--------------------------------------------------------------------------
%Inputs:
%M: KxN matrix of column vectors.
%v: Kx1 column vector
%--------------------------------------------------------------------------
%Outputs:
%d: 1xN vector of dot products of columns of M with v. d(i) = dot(M(:,i),v).
%--------------------------------------------------------------------------
function d = matrixDot(M,v)
    d = (M'*v)';
end
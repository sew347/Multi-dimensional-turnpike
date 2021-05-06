function grid = getGridIndices(n_vec)
d = length(n_vec);
N = prod(n_vec);
grid = zeros(d,N);
for k = 1:N
    c = idxToCoords(k,n_vec);
    grid(:,k) = c;
end
function v = idxToCoords(k,n_vec)
    d = length(n_vec);
    v = zeros(d,1);
    if k > prod(n_vec)
        error('k must be less than or equal to product of n_vec.')
    elseif k <= 0
        error('k must be positive.')
    end
    for i = 1:d
        prod(n_vec((i+1):end));
        v(i) = ceil((k / prod(n_vec((i+1):end))));
        k = k - (v(i)-1)*prod(n_vec(i+1:end));
    end
end
    
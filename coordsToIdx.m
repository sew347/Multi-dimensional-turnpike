function idx = coordsToIdx(n_vec,coords)
    d = length(n_vec);
    adj_vec = ones(d,1);
    adj_vec(1) = 0;
    idx = (n_vec.^(0:d-1))*(coords - adj_vec);
end
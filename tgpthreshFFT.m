function optimal_tau = tgpthreshFFT(n_vec)

N = prod(n_vec);
M = 0;
for i = 1:10000
    dat = randn(N,1);
    M = max(M,max(abs(dat)));
end
optimal_tau = M/sqrt(N);

end
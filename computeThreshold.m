%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to find optimal threshold for denoising
% 
% The function runs No Phantom Signal (NPS) test for .
% For each tau, the function will check if A and tau pass the NPS test.
% This experiment is run as a binary search.

% testn = the number of experiments run for each tau

% Input: dimensions as row vector n_vec, lower and upper bounds for tau
% Output: optimal_tau

% If the output optimal_tau = -1, it means uppertau
% does not satisfy the NPS test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Code is adapted from https://arxiv.org/abs/2103.11893 by
%Alexei Novikov and Hai Le.


function tau = computeThreshold(n_vec)

     N = prod(n_vec);
     tau = 0;
     T = 2e4;
     m = zeros(T,1);
     
     for i = 1:T
         dat = randn(N,1);
         m(i) = max(abs(dat)/vecnorm(dat));
         tau = max(m(i),tau);
     end
end
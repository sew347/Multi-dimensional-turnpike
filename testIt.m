%testIt.m
%Authors: Stephen White, Alexei Novikov
%--------------------------------------------------------------------------
%Function handle for main testing protocol
%--------------------------------------------------------------------------

if ~exist('seed','var')
    clear all
end

%Dimension
D = 3;
%Number of scatterers
s = 300;
%Sparsity, as power of N^D
theta = 0.5;
%Compute N from s and theta
N = (s^(1/(theta*D)))
%Number of random vectors used (tau)
n_rands=10;
%Number of test runs
T = 100;

%comment this for random runs
seed = 2020;
rng(2020,'twister');

[fail_count, collab_count, test_loc, fail_loc,loc_k,diff_K,recovery_times] = testHandler(N,D,s,T,n_rands);
avg_k = sum(loc_k)/T;
avg_K = sum(diff_K)/T;
avg_time = sum(recovery_times)/T;

output = fprintf('Test completed on n=%d, D=%d, s=%d, theta = %.2f.\n  Failures: %d \n  Iterations: %d \n  Recovery Percentage: %.2f%% \n  Avg. k: %.2f\n  Avg. K: %2.f\n  Avg collaboration depth: %.2f\n  Avg Time Per Iter: %.2f sec\n',...
    N,D,s,theta,fail_count,T,100*(1-fail_count/T),avg_k,avg_K,collab_count/T,avg_time);

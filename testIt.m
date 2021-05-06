%testIt.m
%Authors: Stephen White, Alexei Novikov
%--------------------------------------------------------------------------
%Function handle for main testing protocol
%--------------------------------------------------------------------------
%Parameters
%--------------------------------------------------------------------------
%n: Resolution
%d: Dimension
%s: Number of scatterers
%T: Number of test runs
%theta: sparsity parameter
%n_rands: Number of random vectors used for MISTR
%rand_type: 'uniform' for uniform random vectors on a cube; else normalized
%normal random vectors.
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%Failures: number of times algorithm failed to return a set of points with
%correct difference set
%Iterations: number of test runs
%Recovery Percentage: Percentage successful recovery
%Mean. k: Mean number of points in test sets V
%Mean. K: Mean number of points in test difference sets
%Mean. collaboration depth: Mean depth of search tree in collab. search
%Avg. Time Per Iter: average time to return
%Mean Branching: Mean number of times collaboration search explored tree branched
%--------------------------------------------------------------------------

%Dimension
d = 3;
%Number of scatterers
s = 100;
%Sparsity, as power of N^d
theta = 2/5;
%Compute N from s and theta
n = (s^(1/(theta*d)));
%Number of random vectors used (tau)
n_rands=30;
%Number of test runs
T = 100;
%Type of random vectors: 
%-'uniform' for uniform on a discrete cube
%-else, renormalized normal random vectors
rand_type = 'not uniform';

if isequal(rand_type,'uniform')
    n = floor(n);
    theta = log(s)/(d*log(n));
end

[fail_count, collab_count, test_loc, fail_loc,loc_k,diff_K,recovery_times,branchTotal] = testHandler(n,d,s,T,n_rands,rand_type);
avg_k = sum(loc_k)/T;
avg_K = sum(diff_K)/T;
avg_time = sum(recovery_times)/T;

output = fprintf('Test completed on n=%d, d=%d, s=%d, theta = %.2f.\n  Failures: %d \n  Iterations: %d \n  Recovery Percentage: %.2f%% \n  Mean. k: %.2f\n  Mean. K: %2.f\n  Mean Collaboration Depth: %.2f\n  Avg. Time Per Iter: %.2f sec\n  Mean Branching: %.3f\n',...
    n,d,s,theta,fail_count,T,100*(1-fail_count/T),avg_k,avg_K,collab_count/T,avg_time,branchTotal/T);

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
%n_rands: Number of random vectors used for MISTR
%sigma: noise level (2-norm of noise / 2-norm of autocorrelation)
%tau: thresholding parameter. Set to <= 0 to auto-compute.
%denoise_only: if true, only thresholding is tested; MISTR testing is skipped.
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%Failures: number of times algorithm failed to return a set of points with
%correct difference set
%Iterations: number of test runs
%--------------------------------------------------------------------------



n = 71; %resolution
d = 2; %dimension
sigma = 1; %noise level
tau = 0.0114; %Noise threshold. Set to <= 0 to auto-compute.
s = 8; %number of scatterers
n_rands = 30; %number of random vectors for MISTR
T = 100; %number of tests
denoise_only = false; %set to true to skip MISTR testing

[recov_pct, fail_count, fp, fn, sr, collisions, n_sig, tau] = testHandlerPhaseRetrieval(n,d,s,T,tau,sigma,n_rands,denoise_only);

output = fprintf('Test completed on n=%d, d=%d, s=%d, sigma=%d, tau=%d.\n  Failures: %d \n  Iterations: %d \n  Recovery Percentage: %.2f%% \n',...
    n,d,s,sigma,tau,fail_count,T,100*(1-fail_count/T));


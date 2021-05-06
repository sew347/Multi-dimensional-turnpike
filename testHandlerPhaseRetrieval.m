%testHandlerPhaseRetrieval.m
%--------------------------------------------------------------------------
%Wrapper for running tests of the TGP-MISTR algorithm for support recovery.
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%n_grid = resolution
%d = dimension
%s = number of scatterers
%T = number of test runs
%tau = threshold parameter for TGP. If tau <= 0, tau will be computed.
%sigma = noise level (relative 2-norm of noise to autocorrelation)
%n_rands = number of random vectors for MISTR
%denoise_only = if true, only denoising will be run. MISTR will not be
%   tested.
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%recov_pct = percentage of successful recovery
%fail_count = number of failed recoveries
%fp = false positives from denoising
%fn = false negatives from denoising
%sr = failures due to incorrect MISTR support recovery
%col_ct = number of collisions
%n_sig = 4*n_gri+1, size of signal
%tau = thresholding parameter for TGP
%--------------------------------------------------------------------------
%Notes
%--------------------------------------------------------------------------
%Support is distributed as discretized Gaussian.
%--------------------------------------------------------------------------

function [recov_pct, fail_count, fp, fn, sr, collisions, n_sig, tau] = testHandlerPhaseRetrieval(n_grid,d,s,T,tau,sigma,n_rands,denoise_only);
n_sig = 4*n_grid+1;
n_sig_vec = repmat(n_sig,1,d);

%tune tau if invalid provided
if tau <= 0
    tau = computeThreshold(2*n_sig_vec-1);
end

collisions = zeros(1,T);
fp = zeros(1,T);
fn = zeros(1,T);
sr = zeros(1,T);
for t = 1:T
    %generate random set
    loc = (n_grid/sqrt(2*log(s)))*randn(d,s);
    loc = round(loc);
    loc = unique(loc.','rows').';
    %truncate points outside of cube w/ length 4
    loc = loc(:,max(abs(loc))<=2*n_grid);
    s_act = size(loc,2);
    
    %convert to signal support
    sig_supp = loc + repmat([2*n_grid],d,1) + 1;
    
    [true_diffs, hasCollision] = getDiffs(sig_supp);
    collisions(t) = hasCollision;
    sig_idx = coordsToIdx(n_sig_vec, sig_supp);
    
    supp_phase = 2*pi*rand(s_act,1)*1i;
    supp_mags = 1*ones(s_act,1)+0.2*rand(s_act,1);
    supp_vals = supp_mags.*exp(supp_phase);
    sig = zeros(n_sig^d,1);
    sig(sig_idx) = supp_vals;
    
    sig_grid = reshape(sig, n_sig_vec);
    
    %compute magnitudes
    M = prod(2*n_sig_vec-1);
    Fsig = fftn(sig_grid, 2*n_sig_vec-1);
    Fsig_mags = abs(Fsig).^2;
    
    %add noise
    noise_vec = randn(M,1);
    noise_vec = sigma*noise_vec./vecnorm(noise_vec);
    noise = reshape(noise_vec, 2*n_sig_vec-1);
    
    %noisy_mags = Fsig_mags/vecnorm(Fsig_mags(:)) + noise;
    
    autocorr = sqrt(M)*ifftn(Fsig_mags/vecnorm(Fsig_mags(:)));
    noisy_autocorr = autocorr + noise;
    %noisy_autocorr = noisy_autocorr/vecnorm(noisy_autocorr(:));
    
    recov_supp = find(abs(noisy_autocorr) > tau*vecnorm(noisy_autocorr(:)));

    recov_embed = zeros((2*n_sig-1)^d,1);
    recov_embed(recov_supp) = 1;
    recov_embed_grid = reshape(recov_embed,2*n_sig_vec-1);
    recov_embed_grid = [recov_embed_grid(:,n_sig+1:end,:), recov_embed_grid(:,1:n_sig,:)];
    recov_embed_grid = [recov_embed_grid(n_sig+1:end,:,:); recov_embed_grid(1:n_sig,:,:)];
    if d == 3
       temp = recov_embed_grid(:,:,n_sig+1:end);
       recov_embed_grid(:,:,n_sig:end) = recov_embed_grid(:,:,1:n_sig);
       recov_embed_grid(:,:,1:n_sig-1) = temp;
    end

    if d == 2
        [recov_supp_row, recov_supp_col] = find(recov_embed_grid);
        recov_supp_grid = [recov_supp_row, recov_supp_col]';
    elseif d == 3
        [recov_supp_row, recov_supp_col, recov_supp_page] = find(recov_embed_grid);
        recov_supp_grid = [recov_supp_row, recov_supp_col, recov_supp_page]';
    end
    
    recov_diffs = unique(recov_supp_grid' - n_sig,'rows')';

    false_positives = setdiff(recov_diffs',true_diffs','rows')';
    false_negatives = setdiff(true_diffs',recov_diffs','rows')';

    denoise_success_flag = true;
    if ~isempty(false_positives)
        fp(t) = 1;
        denoise_success_flag = false;
    end
    if ~isempty(false_negatives)
        fn(t) = 1;
        denoise_success_flag = false;
    end
    if denoise_success_flag && ~denoise_only
       %run MISTR
       [~, ~, found_soln, ~] = MISTR(recov_diffs, n_rands);
       if ~found_soln
           sr(t) = 1;
       end
    end
    
    if mod(t,50) == 0
        fail_count = length(find(fp+fn+sr));
        fprintf('Iteration %d completed with %d failures\n',t,fail_count);
    end
end
fail_count = length(find(fp+fn+sr));
fprintf('Test complete with %d failures\n',fail_count);
recov_pct = 1-fail_count/T;


%testHandler.m
%--------------------------------------------------------------------------
%Wrapper for running tests of MISTR, noiseless case.
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%n: Resolution
%d: Dimension
%d: Number of scatterers
%t: Number of test runs
%n_rands: Number of random vectors used for MISTR
%rand_type: 'uniform' for uniform random vectors on a cube; else normalized
%normal random vectors.
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%failCount: number of times algorithm failed to return a set of points with
%correct difference set
%collabCountTotal: total number of collaboration steps
%test_V: collection of all sets V used for testing
%fail_data: collection of location sets that were not correctly recovered
%supp_k: number of distinct points in each set V
%diff_K: number of distinct differences in difference set of each V
%recovery_times: time for each testing iteration
%branchCountTotal: total number of times collaboration search branched

function [failCount, collabCountTotal, test_V, fail_data,supp_k,diff_kappa,recovery_times,branchCountTotal] = testHandler(n,d,s,T,n_rands,rand_type)

collisionCount = 0;
failCount = 0;
collabCountTotal = 0;
branchCountTotal = 0;

test_V = cell(1,T);
fail_data = {};
supp_k = zeros(1,T);
diff_kappa = zeros(1,T);
recovery_times = zeros(1,T);

for iter = 1:T
    %generate random set
    if isequal(rand_type, 'uniform')
        V = randi(n,d,s) - ones(d,1);
        V = unique(V.','rows').';
        while(size(V,2) < s)
            V = [V, randi(n,d,1) - ones(d,1)];
            V = unique(V.','rows').';
        end
        supp_k(iter) = size(V,2);
    else        
        V = (n/sqrt(2*log(s)))*randn(d,s);
        V = round(V);
        V = unique(V.','rows').';
        supp_k(iter) = size(V,2);
    end
    
    test_V{iter} = V;
    [loc_diffs, hasCollision] = getDiffs(V);
    if hasCollision
        collisionCount = collisionCount + 1;
    end
    diff_kappa(iter) = size(loc_diffs,2);
    
    tic
    [output, rands, found_soln,collabCount,branchCount] = MISTR(loc_diffs,n_rands);
    recovery_times(iter) = toc;
    collabCountTotal = collabCountTotal+collabCount;
    branchCountTotal = branchCountTotal+branchCount;
    
    if ~found_soln
        failCount = failCount + 1;
        fail_data{failCount} = V;
    end
    
    if mod(iter,50) == 0
        fprintf('Iteration %d completed with %d failures.\n',iter,failCount);
    end
end
% if d == 2
%     graphSolution(V, output)    
% elseif d == 3
%     graphSolutionProjections(V, output)
% end
    
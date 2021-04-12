%MISTR.m
%Authors: Stephen White, Alexei Novikov
%--------------------------------------------------------------------------
%Runs the MISTR algorithm for recovery of points from their pairwise
%difference set.
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%D: dimension of the input data
%diffs: set of pairwise differences from unknown set V
%n_rands: number of random vectors to use
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%soln = if MISTR finds a set of vectors U with diffs as their difference 
%set, returns U. If no solution is found, the original difference set is
%returned.
%rands = set of random vectors used in the MISTR algorithm.
%found_soln = true if MISTR finds a collection of vectors with pairwise
%difference set given by diffs, false otherwise
%collab_depth = number of collaboration steps required to find a solution.
%Equals n_rands if no solution is found.
%--------------------------------------------------------------------------
function [soln, rands, found_soln, collab_depth] = MISTR(diffs,n_rands)
    n_diffs = size(diffs,2);
    D = size(diffs,1);
    K = size(diffs,2);
    u1 = {};
    u_max = {};
    C = {};
    must_contain = {};
    collab_depth = 1;
    rawSoln = cell(1,1);
    rands = cell(1,n_rands);
    %compute minimum sparsity required to generate distance set
    tk = ceil((1/2)*(sqrt(4*K-3)+1));
    for i = 1:n_rands
        %choose random vectors to be decorrelated
        rand_vec = getDecorrelatedRand(D, rands, i-1);
        rands{i} = rand_vec;

        %intersection step
        [rawSoln{i},u1{i},u_max{i}] = intersectionStep(diffs, rand_vec);
        
        %check if intersection step gave a solution
        if size(rawSoln{i},2) == tk
            soln = rawSoln{i};
            found_soln = true;
            return;
        end 

        %collaboration step
        if i == 1
            u1_1 = u1{1};
            u1_max = u_max{1};
            C{1} = {rawSoln{1}};
            must_contain{1} = {[u1_1,u1_max]};
        else
            collab_depth = collab_depth + 1;
            U = rawSoln{i};
            ui_1 = u1{i};
            ui_max =u_max{i};
            [soln, found_soln, C{i}, must_contain{i}] = collabStep(U, diffs, n_diffs, tk, u1_1, u1_max, ui_1,ui_max,C,must_contain,i);
            if found_soln
                return;
            end
        end
    end
soln = diffs;
found_soln = false;
end
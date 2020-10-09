%collabStep.m
%--------------------------------------------------------------------------
%Runs the MISTR algorithm for recovery of points from their pairwise
%difference set.
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%Ui: ith intersection set.
%diffs: set of pairwise differences from unknown set V
%n_diffs: number of elements in diffs
%tk: minimal number of points that a set must contain in order to generate
%a difference set of size n_diffs.
%u1_1: minimal difference when ordered by X_1
%u1_max: maximal difference when ordered by X_1
%ui_1: minimal difference when ordered by X_i
%ui_max: maximal difference when ordered by X_i
%C: cell array of collaborations computed up to present depth
%must_contain: cell array of vectors which must be contained by each
%collaboration to be a solution or parent thereof.
%i: depth of collaboration
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%soln = if MISTR finds a set of vectors with diffs as their difference 
%set, returns it as soln.
%found_soln = true if solution is found, false otherwise.
%C_i = cell array of collaborations computed as part of this step
%must_contain_i = cell array of required vectors that must be contained in
%future collaborations to be solution or parent thereof.
%--------------------------------------------------------------------------

function [soln, found_soln, C_i, must_contain_i] = collabStep(Ui, diffs, n_diffs, tk, u1_1, u1_max, ui_1, ui_max, C, must_contain,i)
    D = size(diffs,1);
    C_i = {};
    must_contain_i = {};
    
    [U_int_pos,U_int_neg] = getValidCollaborations(Ui,must_contain{1}{1});
    
    for j = 1:size(U_int_pos,2)
        tU = Ui - U_int_pos(:,j);
        for h = 1:length(C{i-1})
            if i == 2 || containsAllVectors(must_contain{i-1}{h},tU)
                tC = intersect(tU',C{i-1}{h}','rows').';
                tC_size = size(tC,2);
                if (tC_size >= tk) &&(tC_size <= 2*tk)
                    [found_soln, is_valid] = testIntersection(tC,diffs,n_diffs,tk);
                    if found_soln
                        soln = tC;
                        return;
                    elseif is_valid
                        required = [must_contain{i-1}{h},ui_1 - U_int_pos(:,j), ui_max - U_int_pos(:,j)];
                        required = unique(setdiff(required',[u1_1,u1_max,zeros(D,1)]','rows'),'rows')';
                        C_i{end+1} = tC;
                        must_contain_i{end+1} = required;
                    end
                else
                    required = [must_contain{i-1}{h},ui_1 - U_int_pos(:,j), ui_max - U_int_pos(:,j)];
                    required = unique(setdiff(required',[u1_1,u1_max,zeros(D,1)]','rows'),'rows')';
                    C_i{end+1} = tC;
                    must_contain_i{end+1} = required;
                end
            end
        end
    end
    for j = 1:size(U_int_neg,2)
        tU = U_int_neg(:,j) - Ui;
        %order of tU will be backwards, so flip to put in sorted order
        %for binary search
        tU = flip(tU')';
        for h = 1:length(C{i-1})
            if i == 2 || containsAllVectors(must_contain{i-1}{h},tU)
                tC = intersect(tU',C{i-1}{h}','rows').';
                tC_size = size(tC,2);
                if (tC_size >= tk) &&(tC_size <= 2*tk)
                    [found_soln, is_valid] = testIntersection(tC,diffs,n_diffs,tk);
                    if found_soln
                        soln = tC;
                        return;
                    elseif is_valid
                        required = [must_contain{i-1}{h},U_int_neg(:,j)-ui_1, U_int_neg(:,j)-ui_max];
                        required = setdiff(required',[u1_1,u1_max,zeros(D,1)]','rows')';
                        C_i{end+1} = tC;
                        must_contain_i{end+1} = required;
                    end
                else
                    required = [must_contain{i-1}{h},U_int_neg(:,j)-ui_1, U_int_neg(:,j)-ui_max];
                    required = setdiff(required',[u1_1,u1_max,zeros(D,1)]','rows')';
                    C_i{end+1} = tC;
                    must_contain_i{end+1} = required;
                end
            end
        end
    end
    soln = diffs;
    found_soln = false;
end
%getDecorrelatedRand.m
%--------------------------------------------------------------------------
%Generates a random vectors with small inner products with the set rands
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%D: dimension of the input data
%rands: set of vectors as columns
%count: number of vectors in set rands
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%rand_vec: random vector with small inner product with rands
%--------------------------------------------------------------------------
function rand_vec = getDecorrelatedRand(D, rands, count)

    rand_tries = 0;
    while (true)
        rand_tries = rand_tries + 1;
        rand_vec = randn(D,1);
        rand_vec = rand_vec/norm(rand_vec);
        corr_flag = false;
        for r = 1:count
            if abs(dot(rand_vec,rands{r})) > (1-1/(count + rand_tries))
                corr_flag = true;
                break;
            end
        end
        if ~corr_flag
            break;
        end
    end
end
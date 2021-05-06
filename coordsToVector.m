function v = coordsToVector(coords, boundary, n_vec)
    stepsize = (boundary(:,2)-boundary(:,1))./(n_vec-1);
    stepsize(isnan(stepsize)) = 0;
    v = boundary(:,1) + (coords-1).*stepsize;
end
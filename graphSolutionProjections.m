%graphSolutionProjections.m
%--------------------------------------------------------------------------
%Plots projections of true location set and retrieved location set for 3-d
%case.
%--------------------------------------------------------------------------
%Inputs
%--------------------------------------------------------------------------
%loc: the true set of points to be recovered
%soln: solution to graph alongside loc
%--------------------------------------------------------------------------
%Outputs
%--------------------------------------------------------------------------
%Plot graphing loc, soln, and -1*soln
%--------------------------------------------------------------------------
function graphSolutionProjections(loc, soln,sgn)
    if ~exist('sgn','var')
        sgn = 0;
    end 

    if sgn == 0
        K = 3;
    else
        K = 2;
    end

    figure(1);
    clf;
    subplot(3,K,1)
    scatter(loc(1,:,:),loc(2,:,:),'ro','filled')
    title('Axes 1 and 2, true values')
    xlabel('x_1-axis')
    ylabel('x_2-axis')
    
    if sgn == 1 || sgn == 0
        subplot(3,K,2)
        scatter(soln(1,:,:),soln(2,:,:),'bo','filled')
        title('Axes 1 and 2, retrieved values')
        xlabel('x_1-axis')
        ylabel('x_2-axis')
    end
    
    if sgn == -1 || sgn == 0
        subplot(3,K,K)
        scatter(-soln(1,:,:),-soln(2,:,:),'ko','filled')
        title('Axes 1 and 2, -1*retrieved values')
        xlabel('x_1-axis')
        ylabel('x_2-axis')
    end

    %x_1/x_3 projection
    subplot(3,K,1+K)
    scatter(loc(1,:,:),loc(3,:,:),'ro','filled')
    title('Axes 1 and 3, true values')
    xlabel('x_1-axis')
    ylabel('x_3-axis')

    if sgn == 1 || sgn == 0
        subplot(3,K,2+K)
        scatter(soln(1,:,:),soln(3,:,:),'bo','filled')
        title('Axes 1 and 3, retrieved values')
        xlabel('x_1-axis')
        ylabel('x_3-axis')
    end
    
    if sgn == -1 || sgn == 0
        subplot(3,K,2*K)
        scatter(-soln(1,:,:),-soln(3,:,:),'ko','filled')
        title('Axes 1 and 3, -1*retrieved values')
        xlabel('x_1-axis')
        ylabel('x_3-axis')
    end
    
    %x_2,x_3 projection
    subplot(3,K,1+2*K)
    scatter(loc(2,:,:),loc(3,:,:),'ro','filled')
    title('Axes 2 and 3, true values')
    xlabel('x_2-axis')
    ylabel('x_3-axis')

    if sgn == 1 || sgn == 0
        subplot(3,K,2+2*K)
        scatter(soln(2,:,:),soln(3,:,:),'bo','filled')
        title('Axes 2 and 3, retrieved values')
        xlabel('x_2-axis')
        ylabel('x_3-axis')
    end

    if sgn == -1 || sgn == 0
        subplot(3,K,3*K)
        scatter(-soln(2,:,:),-soln(3,:,:),'ko','filled')
        title('Axes 2 and 3, -1*retrieved values')
        xlabel('x_2-axis')
        ylabel('x_3-axis')
    end
    
    set(gcf, 'Position',  [100, 100, 800, 800])
    grid
    
end
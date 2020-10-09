%graphSolution.m
%--------------------------------------------------------------------------
%Plots 2-dimensional solutions returned by MISTR alongside true data.
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
function graphSolution(loc, soln)

    max_loc = (max(loc'));
    min_loc = (min(loc'));
    range_loc = max_loc - min_loc;
    base_loc = min_loc + range_loc/2;
    
    max_soln = (max(soln'));
    min_soln = (min(soln'));
    range_soln = max_soln-min_soln;
    base_soln = min_soln + range_soln/2;
    
    side_length = round(0.65*max([range_loc, range_soln]));
   
    figure(1);
    clf;
    subplot(1,2,1)
    scatter(loc(1,:),loc(2,:),'ro','filled')
    title('True values','fontsize',14)
    xlim([base_loc(1)-side_length,base_loc(1)+side_length])
    ylim([base_loc(2)-side_length,base_loc(2)+side_length])
    axis square
    xlabel('x_1','fontsize',14)
    ylabel('x_2','fontsize',14)
    
    subplot(1,2,2)
    scatter(soln(1,:,:),soln(2,:,:),'bo','filled')
    title('Retrieved values','fontsize',14)
    xlim([base_soln(1)-side_length,base_soln(1)+side_length])
    ylim([base_soln(2)-side_length,base_soln(2)+side_length])
    axis square
    set(gcf, 'Position',  [50, 450, 600, 300])
    xlabel('x_1','fontsize',14)
    ylabel('x_2','fontsize',14)
    
    figure(2);
    clf;
    subplot(1,2,1)
    scatter(loc(1,:),loc(2,:),'ro','filled')
    title('True values','fontsize',14)
    xlim([base_loc(1)-side_length,base_loc(1)+side_length])
    ylim([base_loc(2)-side_length,base_loc(2)+side_length])
    axis square
    xlabel('x_1','fontsize',14)
    ylabel('x_2','fontsize',14)
    
    subplot(1,2,2)
    scatter(-soln(1,:,:),-soln(2,:,:),'mo','filled')
    title('-1 * retrieved values','fontsize',14)
    xlim([-base_soln(1)-side_length,-base_soln(1)+side_length])
    ylim([-base_soln(2)-side_length,-base_soln(2)+side_length])
    axis square
    set(gcf, 'Position',  [50, 50, 600, 300])
    xlabel('x_1','fontsize',14)
    ylabel('x_2','fontsize',14)
    
end
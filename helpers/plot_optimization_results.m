function plot_optimization_results(gm, range, x, x_i, title_text)

    %plot_gm_contour(gm, range);
    
    plot_gm(gm, range);
    hold on
    %plot(x(1,:), x(2,:));
    
    z = zeros(size(x(1,:)));
    col = 1:size(x(1,:),2);  % This is the color, vary with x in this case.
    
    %surface([x(1,:);x(1,:)],[x(2,:);x(2,:)],[z;z],[col;col],...
            %'facecol','no',...
            %'edgecol','interp',...
            %'linew',1);
    %colorbar();colormap( jet);
    plot(x(1,:), x(2,:));
    
    scatter(x_i(1),x_i(2),100, '^', 'black');
    for i = 1:size(gm.mu,1)
        
        scatter(gm.mu(i,1),gm.mu(i,2),100, '*', 'r');
    end
    legend('Map', 'Trajectory', 'Initial Position', 'Local Maxima');
    
    xlabel('x_1');
    ylabel('x_2');
    title(title_text);
end
function plot_distance_to_max(dd, name)

    figure();
    hold on
    for i = 1:size(dd,1)
        plot(1:size(dd,2), dd(i,:),'DisplayName',name(i));
    end
    
    set(gca, 'YScale', 'log');
    grid on
    grid minor
    legend
    title('Distance to local maximum');
end


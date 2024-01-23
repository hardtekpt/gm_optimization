function plot_distance_to_max_hybrid(dd_agd, dd, name)

    figure();
    hold on
    
    plot(1:size(dd_agd,2), dd_agd(1,:),'DisplayName',"AGD");
    nn = size(dd_agd,2);
    
    for i = 1:size(dd,1)
        plot(nn:size(dd,2)+nn-1, dd(i,:),'DisplayName',name(i));
    end
    
    set(gca, 'YScale', 'log');
    grid on
    grid minor
    legend
    title('Distance to local maximum');
end


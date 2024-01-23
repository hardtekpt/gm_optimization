function plot_gm_contour(gm, range)

    gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(gm,[x0 y0]),x,y);
    figure();
    hold on
    fcontour(gmPDF, range, 'LineWidth', 0.5 );
    colormap( copper);
    grid on
    grid minor
end

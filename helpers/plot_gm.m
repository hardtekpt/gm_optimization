function plot_gm(gm, range)

    gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(gm,[x0 y0])-1,x,y);
    figure();
    h = fsurf(gmPDF, range);
    set(h,'edgecolor','none')
    shading interp % this changes the color shading (i.e. gets rid of the grids lines on the surface)
    view(2) % same as view(0, 90)
    grid off
    %pcolor(gmPDF);
end
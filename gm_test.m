
mu = [1 2;]; % center
sigma = cat(3,[2 .5]); % size
gm = gmdistribution(mu,sigma);

plot_gm(gm);
plot_gm_contour(gm);

function plot_gm(gm)

    gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(gm,[x0 y0]),x,y);
    figure();
    fsurf(gmPDF,[-10 10]);
end

function plot_gm_contour(gm)

    gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(gm,[x0 y0]),x,y);
    figure();
    fcontour(gmPDF, [-10 10]);
end


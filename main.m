clear
close all

% Create GM
mu = [0 0;];
sigma = cat(3,[1 5]);
gm = gmdistribution(mu,sigma);

% Initialize parameters
x_i = [-1.5; 2];
niter = 90;

%% Run GD
step_size = 10;
[x_gd, d_gd, dd_gd] = gradient_descent(x_i, step_size, gm, niter);
plot_optimization_results(gm, [-6 6], x_gd, x_i, 'Gradient Descent');

%% Run AGD
step_size_i = [0.5 0.5];
u_agd = 1.05;
d_agd = 0.8;
[x_agd, d_agd, dd_agd] = adaptive_gradient_descent(x_i, step_size_i, gm, niter, u_agd, d_agd);
plot_optimization_results(gm, [-6 6], x_agd, x_i, 'Adaptive Gradient Descent');

%% Run HB
step_size = 20;
beta_hb = 0.1;
[x_hb, d_hb, dd_hb] = heavy_ball(x_i, gm, niter, step_size, beta_hb);
plot_optimization_results(gm, [-6 6], x_hb, x_i, 'Heavy Ball');

%% Run NE
step_size = 15;
beta_ne = 0.25;
[x_ne, d_ne, dd_ne] = nesterov(x_i, gm, niter, step_size, beta_ne);
plot_optimization_results(gm, [-6 6], x_ne, x_i, 'Nesterov');

%% Run TM
zeta = 0.3;
[x_tm, dd_tm] = triple_momentum(x_i, gm, niter, zeta, x_ne);
plot_optimization_results(gm, [-6 6], x_tm, x_i, 'Triple Momentum');

%% Run BB
[x_bb, dd_bb] = bb(x_i, gm, niter);
plot_optimization_results(gm, [-6 6], x_bb, x_i, 'Barzilai-Borwein');

%% Run CBB
eps = 0.2;
[x_cbb, dd_cbb] = cbb(x_i, gm, niter, eps);
plot_optimization_results(gm, [-6 6], x_cbb, x_i, 'Cauchy-Barzilai-Borwein');

%% Run Newton
lambda = 1;
p = 1;
eps = 0.2;
[x_new, dd_new] = newton(x_i, gm, niter, lambda, p, eps);
plot_optimization_results(gm, [-6 6], x_new, x_i, 'Newton');

%% Run Lion
lambda = 0.05;
eps = 0.2;
beta_1 = 0.9;
beta_2 = 0.99;
[x_lion, dd_lion] = lion(x_i, gm, niter, eps, lambda, beta_1, beta_2);
plot_optimization_results(gm, [-6 6], x_lion, x_i, 'Lion');

%% Run NSA
n = 20;
p = 40;
[x_nsa, dd_nsa] = nesterov_spokoiny(x_i, gm, niter, n, p);
plot_optimization_results(gm, [-6 6], x_nsa, x_i, 'Nesterov-Spokoiny Acceleration');

%% Plot distance to max
plot_distance_to_max(cat(1, dd_gd, dd_agd, dd_hb, dd_ne, dd_tm, dd_bb, dd_cbb, dd_new, dd_lion, dd_nsa),["GD", "AGD", "HB", "NE", "TM", "BB", "CBB", "NEW", "LION", "NSA"]);



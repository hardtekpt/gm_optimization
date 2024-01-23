clear
close all

% Create GM
mu = [0 0;];
sigma = cat(3,[1 5]);
gm = gmdistribution(mu,sigma);

% Initialize parameters
x_i = [-1.5 2];
niter = 90;

%% Run AGD and switch to normal GD when overshoot (per coordinate)
step_size_i = [0.5 0.5];
u_agd = [1.15 1.15];
gd_step_size = 20;
[x_agd_gd_overshoot_0, d_agd_gd_overshoot_0, dd_agd_gd_overshoot_0, c_agd_gd_overshoot_0] = agd_gd_overshoot(x_i, step_size_i, gm, niter, u_agd, gd_step_size, 0);
[x_agd_gd_overshoot_1, d_agd_gd_overshoot_1, dd_agd_gd_overshoot_1, c_agd_gd_overshoot_1] = agd_gd_overshoot(x_i, step_size_i, gm, niter, u_agd, gd_step_size, 1);
plot_optimization_results(gm, [-6 6], x_agd_gd_overshoot_0, x_i, 'Adaptive Gradient Descent + Gradient Descent');
plot_optimization_results(gm, [-6 6], x_agd_gd_overshoot_1, x_i, 'Adaptive Gradient Descent + Gradient Descent (Per coordinate)');

%% Run AGD and switch to BB when overshoot (per coordinate)
step_size_i = [0.5 0.5];
u_agd = [1.15 1.15];
gd_step_size = 20;
[x_agd_bb_00, d_agd_bb_00, dd_agd_bb_00, c_agd_bb_00] = agd_bb_overshoot(x_i, step_size_i, gm, niter, u_agd, 0, 0);
[x_agd_bb_10, d_agd_bb_10, dd_agd_bb_10, c_agd_bb_10] = agd_bb_overshoot(x_i, step_size_i, gm, niter, u_agd, 1, 0);
plot_optimization_results(gm, [-6 6], x_agd_bb_00, x_i, 'Adaptive Gradient Descent + BB');
plot_optimization_results(gm, [-6 6], x_agd_bb_10, x_i, 'Adaptive Gradient Descent + BB (Per coordinate)');
[x_agd_bb_01, d_agd_bb_01, dd_agd_bb_01, c_agd_bb_01] = agd_bb_overshoot(x_i, step_size_i, gm, niter, u_agd, 0, 1);
[x_agd_bb_11, d_agd_bb_11, dd_agd_bb_11, c_agd_bb_11] = agd_bb_overshoot(x_i, step_size_i, gm, niter, u_agd, 1, 1);
plot_optimization_results(gm, [-6 6], x_agd_bb_01, x_i, 'Adaptive Gradient Descent + BB - split alpha');
plot_optimization_results(gm, [-6 6], x_agd_bb_11, x_i, 'Adaptive Gradient Descent + BB (Per coordinate) - split alpha');

%% Run AGD and switch to normal GD based on l/m supervisor
step_size_i = [0.5 0.5];
u_agd = 1.15;
d_agd = 0.8;
gd_step_size = 20;
[x_agd_gd_supervisor, d_agd_gd_supervisor, dd_agd_gd_supervisor] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, 0.9);
plot_optimization_results(gm, [-6 6], x_agd_gd_supervisor, x_i, 'Adaptive Gradient Descent + Gradient Descent - supervisor');

%%
plot_distance_to_max(cat(1,dd_agd, dd_bb, dd_agd_gd_overshoot_0, dd_agd_gd_overshoot_1, dd_agd_bb_00, dd_agd_bb_10,dd_agd_bb_01, dd_agd_bb_11, dd_agd_gd_supervisor),["AGD","BB","AGD-GD-0", "AGD-GD-1", "AGD-BB-00", "AGD-BB-10", "AGD-BB-01", "AGD-BB-11", "AGD-GD-super"]);

%% Test multiple supervisor condition values

step_size_i = [0.5 0.5];
u_agd = 1.15;
d_agd = 0.8;
gd_step_size = 20;
[~, ~, dd_agd_gd_supervisor_1] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, 1);
[~, ~, dd_agd_gd_supervisor_2] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, 0.95);
[~, ~, dd_agd_gd_supervisor_3] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, 0.9);
[~, ~, dd_agd_gd_supervisor_4] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, 0.8);
[~, ~, dd_agd_gd_supervisor_5] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, 0.5);

plot_distance_to_max(cat(1,dd_agd_gd_supervisor_1, dd_agd_gd_supervisor_2, dd_agd_gd_supervisor_3, dd_agd_gd_supervisor_4, dd_agd_gd_supervisor_5),["1.0", "0.95", "0.9", "0.8", "0.5"]);

%% 

function [x, alpha, d] = bb_step(g, x_sym, x, x_prev, d_prev)
    
    % Get the gradient
    d = double(subs(g, x_sym, x));
    
    % Compute the next step size
    delta_x = x - x_prev;
    delta_g = d - d_prev;
    alpha_k_short_1 = abs((delta_x(1) * delta_g(1))/(delta_g(1) * delta_g(1)));
    alpha_k_short_2 = abs((delta_x(2) * delta_g(2))/(delta_g(2) * delta_g(2)));
    
    alpha_k_short = abs((delta_x' * delta_g)/(delta_g' * delta_g));
    
    alpha = [alpha_k_short_1; alpha_k_short_2];
    %alpha = [alpha_k_short; alpha_k_short];
    
    % Compute the next estimate
    if norm(alpha .* d) > 0.5
        alpha = 0.5;
        d = d/norm(d);
    end
    x = x + alpha .* d;
end
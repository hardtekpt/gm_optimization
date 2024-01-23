function [x, alpha, d, overshoot] = agd_step(g, x_sym, u, x, alpha, d_prev)
    
    overshoot = 0;

    % Get the gradient
    d = double(subs(g, x_sym, x));

    % Normalize the gradient
    d = d/norm(d);
    
    % Compute the next step size
    if (d_prev(1) * d(1) < 0) || (d_prev(2) * d(2) < 0)
        overshoot = 1;
    end
    
    alpha(1) = u(1) * alpha(1);
    alpha(2) = u(2) * alpha(2);
    
    % Compute the next estimate
    x = x + alpha .* d;
end


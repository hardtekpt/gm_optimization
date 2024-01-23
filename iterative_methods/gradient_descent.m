function [x, d, dd] = gradient_descent(x_i, step_size, gm, niter)

    x(:,1) = x_i;
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    % Run GD
    for i = 1:niter
        
        % Get the gradient
        d(:,i) = double(subs(g, x_sym, x(:,i)));

        % Calculate distance to maximum in the current iteration
        dd(i) = norm(x(:,i) - gm.mu);

        % Compute the next estimate
        x(:,i+1) = x(:,i) + step_size * d(:,i);
        
        if norm(x(:,i+1) - x(:,i)) < 10^-4
            x(:,i+1) = x(:,i);
        end
    end
end

function [x, dd] = bb(x_i, gm, niter)
    
    x(:,1) = x_i;
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    g_1 = double(subs(g, x_sym, x(:,1)));
    %g_1 = g_1 / norm(g_1);
    x(:,2) = x(:,1) + 0.5 * g_1;
    
    g_prev = g_1;
    
    % Run BB
    for k = 2:niter
        
        % Compute gradient
        gk = double(subs(g, x_sym, x(:,k)));

        % Compute alpha
        delta_x = x(:,k) - x(:,k-1);
        delta_g = gk - g_prev;
        
        alpha_k_long = (delta_x' * delta_x)/(delta_x' * delta_g);
        alpha_k_short = (delta_x' * delta_g)/(delta_g' * delta_g);

        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        g_prev = gk;
        
        if norm(x(:,k) - x(:,k-1)) > 10^-4
            % BB iteration
            x(:,k+1) = x(:,k) + abs(alpha_k_short) * gk;
        else
            x(:,k+1) = x(:,k);
        end
    end
end


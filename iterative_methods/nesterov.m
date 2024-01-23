function [x, d, dd] = nesterov(x_i, gm, niter, step_size, beta_ne)
    
    x(:,1) = x_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    % Run NE
    for k = 1:niter
        
        % Calculate x_
        if k > 1
            x_(:,k) = x(:,k) + beta_ne * (x(:,k) - x(:,k-1));
        else
            x_(:,k) = x(:,k);
        end
        
        % Get the gradient
        d(:,k) = double(subs(g, x_sym, x_(:,k)));

        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        x(:,k+1) = x_(:,k) + step_size * d(:,k);
        
        if norm(x(:,k+1) - x(:,k)) < 10^-4
            x(:,k+1) = x(:,k);
        end
    end
end


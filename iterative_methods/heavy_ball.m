function [x, d, dd] = heavy_ball(x_i, gm, niter, step_size, beta_hb)

    x(:,1) = x_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    % Run HB
    for k = 1:niter
        
        % Calculate x_tilde
        if k > 1
            x_tilde(:,k) = x(:,k) + beta_hb * (x(:,k) - x(:,k-1));
        else
            x_tilde(:,k) = x(:,k);
        end
        
        % Get the gradient
        d(:,k) = double(subs(g, x_sym, x(:,k)));

        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        x(:,k+1) = x_tilde(:,k) + step_size * d(:,k);
        
        if norm(x(:,k+1) - x(:,k)) < 10^-4
            x(:,k+1) = x(:,k);
        end
    end
end


function [x, dd] = lion(x_i, gm, niter, eps, lambda, beta_1, beta_2)
    
    x(:,1) = x_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    m(:,1) = - (1 - beta_2) * double(subs(g, x_sym, x(:,1)));
    
    for k = 1:niter
        
        dk = double(subs(g, x_sym, x(:,k)));
        dk = -dk;
        
        m(:,k+1) = beta_2 * m(:,k) - (1 - beta_2) * dk;
        
        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        x(:,k+1) = x(:,k) + eps * (sign( beta_1 * m(:,k) - (1 - beta_1) * dk ) - lambda * x(:,k));
        
        if norm(x(:,k+1) - x(:,k)) < 10^-4
            x(:,k+1) = x(:,k);
        end
    end
end


function [x, dd] = nesterov_spokoiny(x_i, gm, niter, n, p)
    
    x(:,1) = x_i;
    z(:,1) = x_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    for k = 1:niter
        
        alpha_k = p / (k + p);
        
        yk = (1 - alpha_k) * x(:,k) + alpha_k * z(:,k);
        
        dk_y = double(subs(g, x_sym, yk));
        x_(:,k+1) = yk + n * dk_y;
        
        dk_x = double(subs(g, x_sym, x(:,k)));
        x__(:,k+1) = x(:,k) + n * dk_x;
        
        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        if double(subs(f, x_sym, x_(:,k+1))) < double(subs(f, x_sym, x__(:,k+1)))
            x(:,k+1) = x_(:,k+1);
        else
            x(:,k+1) = x__(:,k+1);
        end
        
        if norm(x(:,k+1) - x(:,k)) < 10^-4
            x(:,k+1) = x(:,k);
        end
        
        z(:,k+1) = z(:,k) + n/alpha_k * dk_y;
        
    end
    
end


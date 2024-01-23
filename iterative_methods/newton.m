function [x, dd] = newton(x_i, gm, niter, lambda, p, eps)
    
    x(:,1) = x_i;
    [f, x_sym] = get_gm_pdf(gm);
        
    % Run Newton
    for k = 1:niter
        
        % Get quadratic fit
        [a, a_sym] = get_quadratic_fit(x(:,k), eps, f, x_sym, 'optimize');
        g = gradient(a);
        
        % Compute gradient
        gk = double(subs(g, a_sym, x(:,k)));

        % Compute hessian
        hk = double(hessian(a));
        
        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        % v is the Newton direction
        v = inv(hk) * gk;
        nv = min(norm(v), 1);
        v = nv * v/norm(v);
        
        % Newton iteration
        x(:,k+1) = x(:,k) - lambda * v;
        
        if(norm(gk) < 10^-4)
            x(:,k+1) = x(:,k);
        end
        
        lambda = lambda * p;
    end
end







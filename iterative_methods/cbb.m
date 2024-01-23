function [x, dd] = cbb(x_i, gm, niter, eps)
    
    x(:,1) = x_i;
    [f, x_sym] = get_gm_pdf(gm);
    
    % Run CBB
    for k = 1:niter
        
        % Compute search direction
        [a, a_sym] = get_quadratic_fit(x(:,k), eps, f, x_sym, 'optimize');
        Qk = double(hessian(a));
        
        % Compute gradient
        g = gradient(a);
        gk = double(subs(g, a_sym, x(:,k)));
        
        hk = Qk * gk;

        % Compute step-size
        alpha = (gk' * gk) / (gk' * hk);
        if abs(alpha) > 10
            alpha = sign(alpha) * 10;
        end

        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        % CBB iteration
        x(:,k+1) = x(:,k) - 2*alpha *gk + alpha^2 * hk;

        if norm(x(:,k+1) - x(:,k)) < 10^-4
            x(:,k+1) = x(:,k);
        end
    end
end


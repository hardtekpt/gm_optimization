function [x, dd] = esdg(x_i, gm, niter, theta)
    
    x(:,1) = x_i;
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    g_1 = double(subs(g, x_sym, x(:,1)));
    x(:,2) = x(:,1) + g_1/norm(g_1);
    
    g_prev = g_1;
        
    B(1) = eye(size(x_sym,1));
    B(2) = B(1);
    
    % Run ESDG
    for k = 2:niter
        
        % Compute gradient
        gk = double(subs(g, x_sym, x(:,k)));
        
        % Compute s(k-1) = x(k) - x(k-1) and y(k-1) = g(k) - g(k-1)
        s(k) = x(k) - x(k-1);
        y(k) = gk - g_prev;
        
        % Update g_prev
        g_prev = gk;

        % Compute dk
        dk = inv(B(k)) * gk;
        
        % Compute alpha_k
        alpha_k
        
        % Compute rho_k and gamma_k
        rho(k) = (s(k)' * y(k))/(s(k)' * B(k) * s(k));
        gamma(k) = min(rho(k), 1);
        
        % Update Bk
        E(k) = diag(s(k) .^ 2);
        if rho(k) > theta
            B(k) = gamma(k) * B(k) + ((s(k)'*y(k) - gamma(k)*s(k)'*B(k)*s(k))/trace(E(k)^2)) * E(k);
        else
            Bhat_k_1 = B(k) + ((s(k)'*y(k) - s(k)'*Bk*s(k))/trace(E(k)^2)) * E(k);
            Bhat_k_2 = Bhat_k_1 + ((s(k-1)'*y(k-1) - gamma(k-1)*s(k-1)'*Bhat_k_1*s(k-1))/trace(E(k-1)^2)) * E(k-1);
            
            B(k+1) = Bhat_k_2 + ((s(k)'*y(k) - s(k)'*Bhat_k_2*s(k))/trace(E(k)^2)) * E(k);
        end

        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        
        if norm(x(:,k) - x(:,k-1)) > 10^-4
            % ESDG iteration
            x(:,k+1) = x(:,k) + alpha_k * dk;
        else
            x(:,k+1) = x(:,k);
        end
    end
end


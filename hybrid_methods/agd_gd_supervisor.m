function [x, d, dd] = agd_gd_supervisor(x_i, step_size_i, gm, niter, u_agd, d_agd, gd_step_size, a)

    x(:,1) = x_i;
    step_size(:,1) = step_size_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    [L,m] = oracle(gm);
    
    local = 0;
    
    % Run AGD + GD
    for i = 1:niter
        
        % Get the gradient
        d(:,i) = double(subs(g, x_sym, x(:,i)));

        % Normalize the gradient
        dn(:,i) = d(:,i)/norm(d(:,i));
        
        % Compute the next step size
        if i > 1
            if d(1,i-1) * d(1,i) > 0 && local == 0
                step_size(1,i) = u_agd * step_size(1,i-1);
            else
                step_size(1,i) = d_agd * step_size(1,i-1);
            end

            if d(2,i-1) * d(2,i) > 0 && local == 0
                step_size(2,i) = u_agd * step_size(2,i-1);
            else
                step_size(2,i) = d_agd * step_size(2,i-1);
            end
        end
            
        % Calculate distance to maximum in the current iteration
        dd(i) = norm(x(:,i) - gm.mu);
        
        % Compute the next estimate
        x(:,i+1) = x(:,i) + step_size(:,i) .* dn(:,i);
        
        strategy = supervisor(gm,x(:,i), m, a);
        if strategy == 1
            local = 1;
        end
        
        if local == 1
            x(:,i+1) = x(:,i) + gd_step_size * d(:,i);
        end

        if norm(x(:,i+1) - x(:,i)) < 10^-4
            x(:,i+1) = x(:,i);
        end
    end
end


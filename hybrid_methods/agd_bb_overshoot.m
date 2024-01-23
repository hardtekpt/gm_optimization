function [x, d, dd, c] = agd_bb_overshoot(x_i, step_size_i, gm, niter, u_agd, per_coordinate, split_alpha)

    x(:,1) = x_i;
    step_size(:,1) = step_size_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    a=0;b=0;
    c = [0,0];
    
    g_prev = 0;
    
    % Run AGD + BB
    for i = 1:niter
        
        % Get the gradient
        d(:,i) = double(subs(g, x_sym, x(:,i)));

        % Normalize the gradient
        dn(:,i) = d(:,i)/norm(d(:,i));
        
        % Compute BB alpha
        if i > 1
            delta_x = x(:,i) - x(:,i-1);
            delta_g = d(:,i) - g_prev;
            alpha_k_short = abs((delta_x' * delta_g)/(delta_g' * delta_g));
            alpha_k_short_1 = abs((delta_x(1) * delta_g(1))/(delta_g(1) * delta_g(1)));
            alpha_k_short_2 = abs((delta_x(2) * delta_g(2))/(delta_g(2) * delta_g(2)));
            if split_alpha == 0
                alpha_k_short_1 = alpha_k_short;
                alpha_k_short_2 = alpha_k_short;
            end
        end
        g_prev = d(:,i);
        
        % Compute the next step size
        if i > 1
            if (d(1,i-1) * d(1,i) > 0) && (a == 0)
                step_size(1,i) = u_agd(1) * step_size(1,i-1);
                d(1,i) = dn(1,i);
            else
                % if overshoot, switch to BB
                step_size(1,i) = alpha_k_short_1;
            end

            if d(2,i-1) * d(2,i) > 0 && (b == 0)
                step_size(2,i) = u_agd(2) * step_size(2,i-1);
                d(2,i) = dn(2,i);
            else
                % if overshoot, switch to BB
                step_size(2,i) = alpha_k_short_2;
            end
        end
        
        % Calculate distance to maximum in the current iteration
        dd(i) = norm(x(:,i) - gm.mu);
        
        % Compute the next estimate
        x(:,i+1) = x(:,i) + step_size(:,i) .* d(:,i);
        
        d_next = double(subs(g, x_sym, x(:,i+1)));
        d_curr = double(subs(g, x_sym, x(:,i)));
        if (d_curr(1) * d_next(1) < 0)
            a = 1;
            if per_coordinate == 0
                b = 1;
            end
            %b = 1;
            c(1) = i-1;
            x(1,i+1) = x(1,i) + alpha_k_short_1 * d_curr(1);
        end
        if (d_curr(2) * d_next(2) < 0)
            b = 1;
            if per_coordinate == 0
                a = 1;
            end
            %a = 1;
            c(2) = i-1;
            x(2,i+1) = x(2,i) + alpha_k_short_2 * d_curr(2);
        end
        
        if norm(x(:,i+1) - x(:,i)) < 10^-4 || isnan(norm(x(:,i+1) - x(:,i)))
            x(:,i+1) = x(:,i);
        end
    end
end

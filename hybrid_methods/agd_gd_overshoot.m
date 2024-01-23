function [x, d, dd, c] = agd_gd_overshoot(x_i, step_size_i, gm, niter, u_agd, gd_step_size, per_coordinate)

    x(:,1) = x_i;
    step_size(:,1) = step_size_i;
    
    [f, x_sym] = get_gm_pdf(gm);
    g = gradient(f);
    
    a=0;b=0;
    c = [0,0];
    
    % Run AGD + GD
    for i = 1:niter
        
        % Get the gradient
        d(:,i) = double(subs(g, x_sym, x(:,i)));

        % Normalize the gradient
        dn(:,i) = d(:,i)/norm(d(:,i));
        
        % Compute the next step size
        if i > 1
            if (d(1,i-1) * d(1,i) > 0) && (a == 0)
                step_size(1,i) = u_agd(1) * step_size(1,i-1);
                d(1,i) = dn(1,i);
            else
                % if overshoot, switch to normal GD
                step_size(1,i) = gd_step_size;
            end

            if d(2,i-1) * d(2,i) > 0 && (b == 0)
                step_size(2,i) = u_agd(2) * step_size(2,i-1);
                d(2,i) = dn(2,i);
            else
                % if overshoot, switch to normal GD
                step_size(2,i) = gd_step_size;
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
            c(1) = i-1;
            x(1,i+1) = x(1,i) + gd_step_size * d_curr(1);
        end
        if (d_curr(2) * d_next(2) < 0)
            b = 1;
            if per_coordinate == 0
                a = 1;
            end
            c(2) = i-1;
            x(2,i+1) = x(2,i) + gd_step_size * d_curr(2);
        end
        
        %---
        %if abs(d_next(2)) > abs(d_curr(2))
        %    u_agd(2) = u_agd(2) * 1.25;
        %end
        %if abs(d_next(1)) > abs(d_curr(1))
        %    u_agd(1) = u_agd(1) * 1.25;
        %end

        if norm(x(:,i+1) - x(:,i)) < 10^-4
            x(:,i+1) = x(:,i);
        end
    end
end

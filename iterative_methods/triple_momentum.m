function [x, dd] = triple_momentum(x_i, gm, niter, zeta, x_ne)
    
    x(:,1) = x_i;    
    
    % Run TM
    for k = 1:niter 
        
        % Calculate distance to maximum in the current iteration
        dd(k) = norm(x(:,k) - gm.mu);
        
        x(:,k+1) = x_ne(:,k+1) + zeta * (x_ne(:,k+1) - x_ne(:,k+1));
        
        if norm(x(:,k+1) - x(:,k)) < 10^-4
            x(:,k+1) = x(:,k);
        end
    end
end


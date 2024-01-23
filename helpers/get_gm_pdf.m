function [f, x] = get_gm_pdf(gm)
    
    k = gm.NumVariables;
    x = sym('x',[k 1], 'real');
    
    for n = 1:gm.NumComponents
        
        covariance = diag(gm.Sigma(:,:,n));
        mean = gm.mu(n,:)';
        p = gm.ComponentProportion(n);
        
        if n == 1
            f = p * (( exp(-0.5 * (x - mean)' * inv(covariance) * (x - mean)) )/( sqrt((2*pi)^k * det(covariance)) ));
        else
            f = f + p * (( exp(-0.5 * (x - mean)' * inv(covariance) * (x - mean)) )/( sqrt((2*pi)^k * det(covariance)) ));
        end
    end
end


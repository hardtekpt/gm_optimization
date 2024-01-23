function [L,m] = oracle(gm)
    
    L = 0;
    m = 0;

    for n = 1:gm.NumComponents
        
        sigma_1 = gm.Sigma(:,1,n);
        sigma_2 = gm.Sigma(:,2,n);
        
        H = (1/(2*pi*sigma_1*sigma_2)) * [1/(sigma_1^2) 1/(sigma_2^2)];
        
        if n == 1
            L = max(H);
            m = min(H);
        else
            if max(H) > L
                L = max(H);
            end
            if min(H) < m
                m = min(H);
            end
        end
    end
end


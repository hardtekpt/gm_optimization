function [strategy] = supervisor(gm, x_k, m, a)
    
    epsilon = 0.001;
    
    g_1 = ( pdf(gm, [x_k(1) + epsilon, x_k(2)]) - 2 * pdf(gm, [x_k(1), x_k(2)]) + pdf(gm, [x_k(1) - epsilon, x_k(2)]) )/(epsilon ^ 2);
    g_2 = ( pdf(gm, [x_k(1), x_k(2) + epsilon]) - 2 * pdf(gm, [x_k(1), x_k(2)]) + pdf(gm, [x_k(1), x_k(2) - epsilon]) )/(epsilon ^ 2);
    
    if min(norm(g_1), norm(g_2)) > a * m
        strategy = 1; %local
    else
        strategy = 0; %global
    end
end


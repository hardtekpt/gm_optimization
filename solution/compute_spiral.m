function [spiral, a, b, alpha] = compute_spiral(delta_r, V_clv, xx, map, gamma, center)
    
    P_center = center;
    %gamma = linspace(0,5*pi);

    r = sqrt((delta_r * V_clv)/pi)*gamma;
    theta = sqrt((V_clv * 4*pi)/delta_r)*gamma;

    %[f, x_sym] = get_gm_pdf(map);
    %eps = 0.2;
    %[~, ~, Q] = get_quadratic_fit(P_center, eps, f, x_sym, 'optimize');
    
    Q = get_Q_matrix(xx, map, P_center);

    [V, D] = eig(Q);

    a = 1/(min(abs(D(1,1)),abs(D(2,2))))^2;
    b = 1/(max(abs(D(1,1)),abs(D(2,2))))^2;

    alpha = atan(V(2,1)/V(1,1));
    if abs(D(1,1)) < abs(D(2,2))
        alpha = atan(V(2,2)/V(1,2));
    end
    
    sum = a + b;
    a = a / sum;
    b = b / sum;
    
    x = P_center(1) + cos(alpha)*a*r.*cos(theta) - sin(alpha)*b*r.*sin(theta);
    y = P_center(2) + sin(alpha)*a*r.*cos(theta) + cos(alpha)*b*r.*sin(theta);
    
    spiral = [x; y];
end


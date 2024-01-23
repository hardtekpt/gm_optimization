function [a, b, alpha, c1, c2] = get_ellipse(a, b, alpha, current_waypoint, P_center)

    rel = b/a;

    % scale the axes of the elipse so it touches the current_waypoint
    A = (current_waypoint(1) - P_center(1))^2;
    B = (current_waypoint(2) - P_center(2))^2;

    %coefvct = [1  -2  (1-A-B) (2*A) -A]; 
    coefvct = [-rel^2  0  (A*rel^2+B) 0 0]; 

    tt = roots(coefvct) ;  

    a = max(real(tt));
    b = rel * a;
    
    f = sqrt(abs(a^2-b^2))/2;
    
    c1 = [P_center(1) + f * cos(alpha); P_center(1) + f * sin(alpha)];
    c2 = [P_center(2) - f * cos(alpha); P_center(2) - f * sin(alpha)];

end


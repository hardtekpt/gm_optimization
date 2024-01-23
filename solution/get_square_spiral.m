function s = get_square_spiral(k, m, r, a)

    x = linspace(0,(2*k-1)^2,150);

    i = zeros(1, length(x));
    j = zeros(1, length(x));
    
    s = -cos(pi*m);
    p = 1 - 2 *floor(m/2);
    
    for o=1:length(x)
        
        xx = x(:,o);
    
        for n=1:floor(xx)
            i(o) = i(o) + r*sin(pi/2 * floor(sqrt(4*n - 3)))*p;
            j(o) = j(o) + r*cos(pi/2 * floor(sqrt(4*n - 3)))*s;
        end
    end
    
    R = [cos(a), -sin(a); sin(a), cos(a)];
    s = R * [i; j];

end
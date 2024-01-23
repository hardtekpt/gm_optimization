function f = get_ellipse_2(a,b,alpha,c)

    Q = diag([1/a^2 1/b^2]);
    
    R = [[cos(alpha), -sin(alpha)]; [sin(alpha), cos(alpha)]];
    
    Qr = R * Q * R';
    
    f = @(x) (x-c)' * Qr * (x-c);

end


function spline = generate_b_spline(Points)

    syms gg

    for a=4:size(Points(1,:),2)
        i = 0;
        Cx =  1/6 * [(gg - i)^3, (gg - i)^2, (gg - i), 1] * [-1, 3, -3, 1; 3, -6, 3, 0; -3, 0, 3, 0; 1, 4, 1, 0] * Points(1,a-3:a)';
        Cy =  1/6 * [(gg - i)^3, (gg - i)^2, (gg - i), 1] * [-1, 3, -3, 1; 3, -6, 3, 0; -3, 0, 3, 0; 1, 4, 1, 0] * Points(2,a-3:a)';

        n = 10;
        ii = linspace(0,1,n);
        for aa=1:n
            aaa = n*(a-4)+aa;
            x(aaa) = double(subs(Cx, gg, ii(aa)));
            y(aaa) = double(subs(Cy, gg, ii(aa)));
        end

    end
    spline = [x; y];
end


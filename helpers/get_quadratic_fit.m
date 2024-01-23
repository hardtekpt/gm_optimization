function [q, q_sym, Q] = get_quadratic_fit(p,eps,f,x_sym,method)

    Q = 0;
    
    xa = [p(1); p(1) + eps; p(1) - eps; p(1)      ; p(1)      ; p(1) + eps; p(1) + eps; p(1) - eps; p(1) - eps];
    ya = [p(2); p(2)      ; p(2)      ; p(2) + eps; p(2) - eps; p(2) + eps; p(2) - eps; p(2) - eps; p(2) + eps];
    
    A = zeros(size(xa,1), 6);
    
    for i = 1:size(xa,1)
        za(i,:) = double(subs(f, x_sym, [xa(i); ya(i)]));
        A(i,:) = [xa(i)^2, ya(i)^2, xa(i)*ya(i), xa(i), ya(i), 1];
    end
    
    if strcmp(method, 'fit')
        
        a = fit([xa, ya], za, 'Poly22');
        coef = coeffvalues(a);
        q = subs(str2sym(formula(a)),coeffnames(a),num2cell(coef.'));
        q_sym = sym(indepnames(a));
    end
    
    if strcmp(method, 'optimize')
    
        c = sdpvar;
        v = sdpvar(2,1);
        Q = sdpvar(2,2);

        cost = 0;
        for ii=1:size(xa,1)
            cost = cost + norm([xa(ii); ya(ii)]'*Q*[xa(ii); ya(ii)]+v'*[xa(ii) ;ya(ii)]+c-za(ii),2)^2;
        end

        F = Q<=0;
        S = sdpsettings('verbose',0,'solver', 'sedumi', 'sedumi.eps', 1e-8, ...
                'sedumi.cg.qprec', 1, 'sedumi.cg.maxiter', 49, ...
                'sedumi.stepdif', 2);
        res = optimize(F,cost,S);
        Qv = value(Q);
        Vv = value(v);
        Cv = value(c);

        q = x_sym' * Qv * x_sym + Vv' * x_sym + Cv;
        q_sym = x_sym;
        
        Q = Qv;
    end
    
    if strcmp(method, 'pinv')
        
        cf = pinv(A)*za;
        q = [x_sym(1)^2, x_sym(2)^2, x_sym(1)*x_sym(2), x_sym(1), x_sym(2), 1] * cf;
        q_sym = x_sym;
    end
    
end


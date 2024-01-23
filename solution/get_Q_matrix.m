function [Q] = get_Q_matrix(x,map,center)
    
    [f, x_sym] = get_gm_pdf(map);
    xa = x(1,:);
    ya = x(2,:);
        
    for i = 1:size(xa,2)
        za(i) = double(subs(f, x_sym, x(:,i)));
    end
        
    %c = sdpvar;
    %v = sdpvar(2,1);
    Q = sdpvar(2,2);

    cost = 0;
    for ii=1:size(xa,2)
        %cost = cost + norm([xa(ii); ya(ii)]'*Q*[xa(ii); ya(ii)]+v'*[xa(ii) ;ya(ii)]+c-za(ii),2)^2;
        cost = cost + ([xa(ii)-center(1); ya(ii)-center(2)]' * Q * [xa(ii)-center(1); ya(ii)-center(2)] - za(ii))^2;
    end

    F = (Q-0.1*eye(2))<=0;
    S = sdpsettings('verbose',0,'solver', 'sedumi', 'sedumi.eps', 1e-8, ...
            'sedumi.cg.qprec', 1, 'sedumi.cg.maxiter', 49, ...
            'sedumi.stepdif', 2);
    res = optimize(F,cost,S);

    Q = value(Q);
end




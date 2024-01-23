

Points = [-5, 0, 2, 5; -2, 0, 3, 3];

i = 0;

syms gamma

Cx = 1/6 * [(gamma - i)^3, (gamma - i)^2, (gamma - i), 1] * [-1, 3, -3, 1; 3, -6, 3, 0; -3, 0, 3, 0; 1, 4, 1, 0] * Points(1,:)';
Cy = 1/6 * [(gamma - i)^3, (gamma - i)^2, (gamma - i), 1] * [-1, 3, -3, 1; 3, -6, 3, 0; -3, 0, 3, 0; 1, 4, 1, 0] * Points(2,:)';

n = 100;
ii = linspace(0,1,n);
for a=1:n
    x(a) = double(subs(Cx, gamma, ii(a)));
    y(a) = double(subs(Cy, gamma, ii(a)));
end

%%
figure();
hold on
for a=1:4
    scatter(Points(1,a), Points(2,a));
end
plot(x, y);

%%

Points = [0.5, 0.5, 0.5, 0.5, 0.5, 1, 2, 2, 1, 1, 1, 1, 1; 1, 1, 1, 1, 2, 3, 3, 1, 2, 1, 1, 1, 1];

Cx = 0;
Cy = 0;
syms gamma

figure();
hold on
for a=1:13
    scatter(Points(1,a), Points(2,a));
end

x(1) = 0;
y(1) = 0;

for a=4:13
    i = 0;
    Cx =  1/6 * [(gamma - i)^3, (gamma - i)^2, (gamma - i), 1] * [-1, 3, -3, 1; 3, -6, 3, 0; -3, 0, 3, 0; 1, 4, 1, 0] * Points(1,a-3:a)';
    Cy =  1/6 * [(gamma - i)^3, (gamma - i)^2, (gamma - i), 1] * [-1, 3, -3, 1; 3, -6, 3, 0; -3, 0, 3, 0; 1, 4, 1, 0] * Points(2,a-3:a)';
    
    n = 100;
    ii = linspace(0,1,n);
    for aa=1:n
        aaa = n*(a-4)+aa;
        x(aaa) = double(subs(Cx, gamma, ii(aa)));
        y(aaa) = double(subs(Cy, gamma, ii(aa)));
    end
    
end

plot(x, y);




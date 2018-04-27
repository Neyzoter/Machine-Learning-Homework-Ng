
interval = 50;
Sigma = [1 0.3;0.3 1];
mu = [0;0];
X_idx = cell(interval,interval);
m = 1;
n = 1;
for i = linspace(-4,4,interval)
    for j = linspace(-4,4,interval)
        X(m,n) = [i;j];
        X_idx{m,n} = {m,n};
        P = 1 / sqrt(2 * pi * det(Sigma)) * ...
             exp(-0.5 * (X - mu)' * pinv(Sigma) * (X - mu));
        n = n+1;
    end
    m = m+1;
    n = 1;
end

figure(1);
contourf(X,P);
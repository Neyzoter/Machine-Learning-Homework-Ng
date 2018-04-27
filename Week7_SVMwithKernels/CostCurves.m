%y = 1时
cost1 = @(t)(-log(1./(1+exp(-t))));

%y = 0
cost0 = @(t)(-log(1 - 1./(1+exp(-t))));

t = -3:0.01:3;

CostVal1 = cost1(t);
CostVal0 = cost0(t);

figure(1)
plot(t,CostVal1)
title('y=1时的cost1(z)曲线')
xlabel('z')
ylabel('cost1')

figure(2)
plot(t,CostVal0)
title('y=0时的cost0(z)曲线')
xlabel('z')
ylabel('cost0')
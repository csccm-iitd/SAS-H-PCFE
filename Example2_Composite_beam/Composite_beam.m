function [y] = myfun(x1)

%changing the distribution
mn=[100,200,80,20,200,400,600,800,1000,1200,1400];
sd=[.2,.2,.2,.2,1,1,1,1,1,1,2];
%x=zeros(n,100000);
x2=zeros(1,20);
for ii=1:11
    x2(:,ii)=z2x(x1(:,ii),1,[mn(ii),sd(ii)]);
end
for ii=12:17
    x2(:,ii)=z2x(x1(:,ii),4,[15,1.5]);
end
x2(:,18)=z2x(x1(:,18),1,[70,7]);
x2(:,19)=z2x(x1(:,19),1,[8.75,.875]);
x2(:,20)=z2x(x1(:,20),4,[21,2.1]);

%x2 is changed funtion. this module is a part of funtion
x=x2;

Sum = 0;
for ii = 5:10
    Sum = Sum + x(7+ii)*(x(11)-x(ii));
end
T = Sum/x(11);
K=(0.5*x(1)*x(2)^2+(x(18)/x(19))*x(4)*x(3)*(x(2)+.5*x(4)))/(x(1)*x(2)+(x(18)/x(19))*x(4)*x(3));
num=(T*x(7)-x(12)*(x(7)-x(5))-x(13)*(x(7)-x(6)))*K;
den=(1/12)*x(1)*x(2)^3+x(1)*x(2)*(K-.5*x(2))^2+(1/12)*(x(18)/x(19))*x(3)*x(4)^3 +(x(18)/x(19))*x(4)*x(3)*(x(2)+.5*x(4)-K)^2;
y=(x(20)/1000)-(num/den);
end
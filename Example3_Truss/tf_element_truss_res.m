%% 25 element truss
function g=tf_element_truss_res(x1)
n=length(x1);
%changing the distribution
mn=[1000,10000,10000,10000,10000,600,500,10000000,.4,.1,.1,.1,.1,3.4,3.4,3.4,3.4,.4,.4,1.3,1.3,.9,.9,.9,.9,1,1,1,1,3.4,3.4,3.4,3.4];
sd=[100,500,500,500,500,60,50,500000,.04,.01,.01,.01,.01,.34,.34,.34,.34,.04,.04,.13,.13,.09,.09,.09,.09,.1,.1,.1,.1,.34,.34,.34,.34];

x2=zeros(1,33);

x2(:,1)=z2x(x1(:,1),2,[mn(1),sd(1)]);
x2(:,2)=z2x(x1(:,2),1,[mn(2),sd(2)]);
x2(:,3)=z2x(x1(:,3),1,[mn(3),sd(3)]);
x2(:,4)=z2x(x1(:,4),1,[mn(4),sd(4)]);
x2(:,5)=z2x(x1(:,5),1,[mn(5),sd(5)]);

for ii=6:33
    x2(:,ii)=z2x(x1(:,ii),2,[mn(ii),sd(ii)]);
end

%x2 is changed funtion. this module is a part of function


for i=1:n
    x{i}=x2(i);
end
D=Data_n_m1(x{1},x{2},x{3},x{4},x{5},x{6},x{7},x{8},x{9},x{10},x{11},x{12},x{13},x{14},x{15},x{16},x{17},x{18},x{19},x{20},x{21},x{22},x{23},x{24},x{25},x{26},x{27},x{28},x{29},x{30},x{31},x{32},x{33});
[F,U,R]=ST(D);
%% Maximum nodal displacement
g11=abs(U(1,1));
g12=abs(U(1,2));
g21=abs(U(2,1));
g22=abs(U(2,2));
g_obs=max([g11,g12,g21,g22]);
g=0.4-g_obs;
end
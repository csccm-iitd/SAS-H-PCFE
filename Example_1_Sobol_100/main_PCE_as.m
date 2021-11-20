% Variables
% nvar = number of variables
% theta0 = initial value of length scale parameters in H-PCFE
% lob = lower bound of length scale parameters
% upb = upper bound of length scale parameters
% dmodel = trained H-PCFE model
% Xtrain = training input
% Ytrain = training output
% Xpred = prediction/test input
% Ypred = H-PCFE predicted output.

clc
clear all
n=100;%number of sobol variable
p=sobolset(n);
x=net(p,10000);% generating the data samples 
P=zeros(100,1);% probablity of failure in each itrations.
E=zeros(100,1);% reliabilty index in each itrations.
v=zeros(100,1);% number of samples in each iterations

j=1;%iteraions over number of training sample
while(j <2)    
Nt=1000+100*j;
v(j)=Nt;
xt=x(1:Nt,:); % trianing x data 

z1=PCE_as(xt);% output value(y data) actual function is called inside PCE_as
save('Mypce') 
[y1]=ass_sob(xt,Nt,n); % reduced space projections
Xtrain=xt*y1;%reduced dimension through active subspace
Ytrain=z1; % train y data (output data)


%HPCFE
[b,q]=size(y1);
nvar=q;%input dimension
theta0 = 10*ones(nvar,1);%hyper parameters Initializaion
lob = 0.1*ones(nvar,1);
upb = 20*ones(nvar,1);
cd('./H-PCFE_p')%load the H-PCFE folder 
% Training
dmodel = PK_fit(Xtrain, Ytrain, @PCFE, @corrgauss, theta0, lob, upb);


N=100000;% Testining data
rng(1)%random seed
Xt=rand(N,n);
Xpred1= Xt;
Xpred2=Xpred1*y1; %Reduced dimension through active subspace
Ypred = predictor(Xpred2,dmodel);%Test prediction
z=Ypred<0;
pf=sum(z==1)/N;%Failure probabilty
P(j)=pf;
%eps=norm(P(j)-.0177);Error
E(j)=icdf('normal',[(1-pf)],0,1);
j=j+1;
end

%Plot
plot(v(1:j-1),P(1:j-1),v(1:j-1),E(1:j-1))
legend('P_{f}','Beta')
title('Sobol with 100 variables1')
xlabel('No. of samples (Nt)')
ylabel('P_{f},Beta')

%Reliabilty index
fprintf('Reliabilty index')
icdf('normal',[(1-pf)],0,1)
save('EP1file2.mat','E','P','v')
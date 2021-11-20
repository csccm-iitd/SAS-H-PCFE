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

P=zeros(100,1); % probablity of failure in each itrations.
E=zeros(100,1); % reliabilty index in each itrations.
v=zeros(100,1); % number of samples in each iterations
As=zeros(100,1); %Active subspace dimensions in each iterations
x=load('X_data.mat');% loading X data
x=x.x2;
y=load('y_data.mat');% loading Y data (Simulation data)
y=y.y2;

j=1;%iteraions over number of training sample
while(eps>tol && j <2)
    
Nt=650+100*j;
v(j)=Nt;
xt=x(1:Nt,:);
yt=y(1:Nt,:);
PCE_as(xt,yt);
save('myPCE')

[y1]=ass_sob(x(1:Nt,:),Nt,n);% reduced space projections
[b,q]=size(y1);
Xtrain=xt*yr1;%reduced dimension through active subspace
Ytrain=yt;% train y data (output data)


%HPCFE
[c,nvar]=size(yr1);%input dimension
theta0 = 10*ones(nvar,1);%hyper parameters Initializaion
lob = 0.1*ones(nvar,1);
upb = 20*ones(nvar,1);
cd('./H-PCFE_p')%load the H-PCFE folder 
% Training
dmodel = PK_fit(Xtrain, Ytrain, @PCFE, @corrgauss, theta0, lob, upb);

%Testing
xtt=rand(N,n);% generate test data 
rng(1)
Xtest=xtt*yr1;%Reducing the features using active subspace
ypred = predictor(Xtest,dmodel);%Test prediction


Yp =ypred;
z=Yp<0;
pf=sum(z==1)/N;%Failure probabilty
P(j)=pf;
E(j)=icdf('normal',(1-pf),0,1);
As(j)=q;

j=j+1;
end

%Plot
plot(v(1:j-1),P(1:j-1),v(1:j-1),E(1:j-1))
legend('P_{f}','Beta')
title('Building')
xlabel('No. of samples (Nt)')
ylabel('P_{f},Beta')

%Reliabilty index
fprintf('Reliabilty index')
icdf('normal',[(1-pf)],0,1)
save('EPfile4.mat','E','P','v','As')
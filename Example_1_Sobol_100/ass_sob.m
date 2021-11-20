function [y]=ass_sob(X,Nd,n)
%-----------------------------------------------------%
% number of samples
N=Nd;
C_p=zeros(n,n);
h=0.0001;
z=zeros(N);
for i=1:N %Estimation of avarage gradient matrix
    %x=X(i,:)';
    x=datasample(X,1)';
    C_d=grad(x,h)*grad(x,h)';
    C_p=C_p+C_d;
end
   C=C_p/N;
   
[u,d,v] = svd(C);% SVD decomposition
[m,n] = size(d);

k = diag(d.^1)/sum(diag(d.^1));

for i=1:length(diag(d))
    kt=sum(k(1:i));
    if (kt>0.98)% threshold value
        na=i;
        break
    end
end
fprintf('active subspace for approximate integral')
y=v(:,1:na);
fprintf('Matrix C using approximate eigen vectors')
na


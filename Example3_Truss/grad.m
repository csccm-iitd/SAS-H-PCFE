function G = grad(Xl,h)
load('myPCE')%% load the trained PCE
[m,M] = size(Xl);
G = zeros(m,M);
f0 = uq_evalModel(Xl');%predictions of PCE
Xp1=ones(1,m).*Xl;
    e = eye(m,m)*h;
    Xp = bsxfun(@plus,Xp1,e);
     fp =uq_evalModel(Xp');
    G = (fp-f0*ones(m,1))*(1/h);%finite difference method
end
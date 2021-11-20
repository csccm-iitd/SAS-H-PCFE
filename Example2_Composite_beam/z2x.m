function x = z2x(u1,type,dist_param)
% System reliability analysis of corroding pipelines using MCS
% Code written by Souvik Chakraborty
% Department of Applied Mechanics, IIT Delhi
% -----------------------------------------------------
% INPUTS:
% z         = random numbers in standard normal space
% type      = distribution of the random variables
% dist_para = parameters of the random variables
%
% OUTPUT
% x         = random numbers in original space
% -----------------------------------------------------
z=norminv(u1);
nvar            = length(type);
mu              = dist_param(:,1);
sd              = dist_param(:,2);
zcorr           = z;
u               = normcdf(zcorr);

x = zeros(size(z));

for ivar = 1 : nvar
    if type(ivar)     == 1
        x(:,ivar) = mu(ivar)+sd(ivar)*zcorr(:,ivar);
    elseif type(ivar) == 2
        muN = log(mu(ivar)^2/(sqrt(sd(ivar)^2 + mu(ivar)^2)));
        sdN = sqrt(log((sd(ivar)/mu(ivar))^2 + 1));
        x(:,ivar)   = exp(muN + sdN*zcorr(:,ivar));
    elseif type(ivar) == 3
        lb  = mu(ivar) - sqrt(3)*sd(ivar);
        ub  = mu(ivar) + sqrt(3)*sd(ivar);
        x(:,ivar)   = lb + (ub - lb)*u(:,ivar);
    elseif type(ivar) == 4
        gamma_gumb       = 0.5772;
        beta_gumb        = sd(ivar)*sqrt(6)/pi;
        mu_gumb          = mu(ivar) - gamma_gumb*beta_gumb;
        x(:,ivar)        = mu_gumb - beta_gumb.*log(-log(u(:,ivar)));
    elseif type(ivar) == 5
        param0          = [1,1];
        param           = fsolve(@(param)weibull_param(param,mu(ivar),sd(ivar)), param0);
        lambda          = param(1);
        k               = param(2);
        x(:,ivar)       = lambda*nthroot(-log(-(u(:,ivar) - 1)),k);
    elseif type(ivar) == 6
        alpha           = mu(ivar)*dist_param(ivar,3);
        beta            = sd(ivar);
        x(:,ivar)       = gaminv(u(:,ivar),alpha,1/beta);
    else
        error('The specified type is not yet added')
    end
end
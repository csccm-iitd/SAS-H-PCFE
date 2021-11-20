function [y] = sobol_fun(xx)
 %xx = [x1, x2, ..., xd]
b=.35;
 %d = length(xx);
d=100;%number of sobol variable
prod = 1;
for ii = 1:d
    xi = xx(ii);
    if ii>2
        ai=500;
    else
        ai=1;
    end    
    new1 = abs(4*xi-2) + ai;
    new2 = 1 + ai;
    prod = prod * new1/new2;
end
y = prod-b;
end
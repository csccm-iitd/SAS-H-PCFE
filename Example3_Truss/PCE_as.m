
function [z]=PCE_as(X)
[p,q]=size(X);
Nt=p;
n=q;
Y=zeros(p,1);
uqlab

for i=1:Nt
     Y(i)=tf_element_truss_res(X(i,:));
end
%-------------%

% 3 - INPUT MODEL
for i=1:n
Input.Marginals(i).Type = 'Uniform';
Input.Marginals(i).Parameters = [0 1];
end

%Input.Copula.Type = 'Independent';
%Create an INPUT object based on the specified marginals:
myInput = uq_createInput(Input);

% 4 - POLYNOMIAL CHAOS EXPANSION (PCE) METAMODEL
% Select PCE as the metamodeling tool:
MetaOpts.Type = 'Metamodel';
MetaOpts.MetaType = 'PCE';
 
% Use experimental design loaded from the data files:
MetaOpts.ExpDesign.X = X;
MetaOpts.ExpDesign.Y = Y;

% Set the maximum polynomial degree to 5:
MetaOpts.Degree = 1:3;
MetaOpts.Method = 'LARS';

% Create the metamodel object and add it to UQLab:
myPCE = uq_createModel(MetaOpts);
z=Y;


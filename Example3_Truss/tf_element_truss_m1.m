%% 25 element truss
function g=tf_element_truss_m1(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33)
D=Data_n_m1(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33);
[F,U,R]=ST(D);
%% Maximum nodal displacement
g11=abs(U(1,1));
g12=abs(U(1,2));
g21=abs(U(2,1));
g22=abs(U(2,2));
g_obs=max([g11,g12,g21,g22]);
g=0.4-g_obs;
end
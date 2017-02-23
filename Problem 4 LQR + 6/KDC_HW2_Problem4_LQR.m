% x1 = theta, x2 = s, x3 = dtheta, x4 = ds
syms x1 x2 x3 x4
x = [x1;x2;x3;x4];

syms u
syms L J M m g

mat1 = [m*L^2 + J, -m*L*cos(x1); -m*L*cos(x1), M+m];
mat2 = [-m*g*L*sin(x1);m*L*(x3^2)*sin(x1)];
mat3 = [0;u];

f = [x3;x4;inv(mat1)*(-mat2+mat3)];

Aj = jacobian(f,x);
Bj = jacobian(f,u);

Ap = subs(Aj,[M m L g J x1 x3 x4],[1 0.1 1/2 9.81 (1/3)*0.1*(1^2) 0 0 0]);
Bp = subs(Bj,[M m L g J x1 x3 x4],[1 0.1 1/2 9.81 (1/3)*0.1*(1^2) 0 0 0]);

A = eval(Ap);
B = eval(Bp);

% Q = diag([100 50 50 1000]);
% R = 0.01;
Q = diag([100^2 1^2 1 10^2]);
R = 1;
K = lqr(A,B,Q,R)
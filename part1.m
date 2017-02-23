syms theta(t) M m g xDDot L

xP = (L/2)*sin(theta); 
yP = (L/2)*cos(theta); 

xP_ddot = diff(diff(xP)); 

fx = m*xP_ddot; 

F = fx + (M+m)*xDDot; 

F = subs(F,M,1); 
F = subs(F,m,0.1); 
F = subs(F,L,1); 

F


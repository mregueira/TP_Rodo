Kenv = 1e3; % 1000N/mm=1e6N/m
ke = diag([cos(pi/4)*Kenv, sin(pi/4)*Kenv]);
% la direccion normal a la pared es pared tiene una normal a 45� 
fd = 10;

% Ganancias Critico Amortiguado
kpf = 100;
kvf = 2*sqrt(kpf);

% condiciones iniciales para que el EE este apoyado en la pared, y con
% orientacion perpendicular a la misma. viene de resolver 
% dist((cos(theta_1), sin(theta_1), pared)=1,
% y ademas theta_2 = abs(theta_1)+45 
theta0_1 = -20.53*pi/180;
theta0_2 = pi/4 +abs(theta0_1);

R_Pared_Cart = [cos(pi/4) sin(pi/4);-sin(pi/4) cos(pi/4)];


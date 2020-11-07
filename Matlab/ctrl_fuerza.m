Kenv = 1e6; % 1000N/mm=1e6N/m
%ke = diag([cos(pi/4)*Kenv, sin(pi/4)*Kenv]);
ke = Kenv;
% la direccion normal a la pared es pared tiene una normal a 45º 
%fd = [10*cos(pi/4), 10*sin(pi/4)];
fd = 10;
% Ganancias Critico Amortiguado
kpf = 0.001;
kvf = 2*sqrt(kpf);

% condiciones iniciales para que el EE este apoyado en la pared, y con
% orientacion perpendicular a la misma. viene de resolver 
% dist((cos(theta_1), sin(theta_1), pared)=1,
% y ademas theta_2 = abs(theta_1)+45 
theta0_1 = -20.53*pi/180;
theta0_2 = pi/4+abs(theta0_1);
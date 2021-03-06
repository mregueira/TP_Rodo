%% TP Final - Automacion Industrial
% Nota: Para correr el control de fuerza y el hibrido
%       se debe correr ademas el archivo ctrl_fuerza.m
%% Manipulador RR
clc;
syms th1 th2 thd1 thd2  thdd1 thdd2 real;
Q=[th1 th2];
Qd=[thd1 thd2];
Qdd=[thdd1 thdd2];
syms L1 L2 g Ixx1 Iyy1 Izz1 m1 Ixx2 Iyy2 Izz2 m2  theta1 d2 real;
g = 10;
L1 = 1;
L2 = 1;
m1 = 1;
m2 = 1;
gravedad=[0 0 -g];

%parametros DH
alpha=[0 0 0];
a=[0 L1 L2];
d=[0 0 0];

% i=1;
% Link1=Link('alpha',alpha(i),'a',a(i),'d',d(i),'modified');
% i=2;
% Link2=RevoluteMDH('alpha',alpha(i),'a',a(i),'d',d(i));
% % Masa concentrada
% Ixx1 = 0;
% Iyy1 = 0;
% Izz1 = 0;
% Ixx2 = 0;
% Iyy2 = 0;
% Izz2 = 0;
% 
% I1=[Ixx1 0 0 ; 0 Iyy1 0 ; 0 0 Izz1];
% I2=[Ixx2 0 0 ; 0 Iyy2 0 ; 0 0 Izz2];
% 
% Link1.I=I1;
% Link2.I=I2;
% 
% Link1.m=m1;
% Link2.m=m2;
N = 2;
%Perturbacion
pert = 0;
% Masa 1kg
m = 1 +(2*rand()-1)*pert;
% Centro de masa en extremo:  'r', [1 0 0]
r=1;
rv = [r+(2*rand()-1)*pert, (2*rand()-1)*pert, 0];

% Friccion unitaria:     'B', 1
b = 1;  

% Planar, sin momento de inercia.
g=10;

DH = struct('d', cell(1,N), 'a', cell(1,N), 'alpha', cell(1,N), 'theta', cell(1,N),...
    'type', cell(1,N)); %genera estructura base
DH(1).alpha = 0;    DH(1).a = 0;    DH(1).d = 0;    DH(1).type = 'R';
DH(2).alpha = 0;    DH(2).a = L1;   DH(2).d = 0;    DH(2).type = 'R';

for  iLink = 1:N
        links{iLink} = Link('d', DH(iLink).d, 'a', DH(iLink).a, 'alpha', ...
            DH(iLink).alpha, 'm', m, 'r', rv, 'B', b, 'modified'); % Vector de estructuras Link
end

Tool = transl([L2, 0, 0]); % Offset de la herramienta (End Effector)

Robot = SerialLink( [links{:}], 'tool', Tool,'name', 'Chaplin' );

%% El Robot Perturbado
%Perturbacion
pert = 0.8;
% Masa 1kg
m = 1 +(2*rand()-1)*pert;
% Centro de masa en extremo:  'r', [1 0 0]
r=1;
rv = [r+(2*rand()-1)*pert, (2*rand()-1)*pert, 0];

% Friccion unitaria:     'B', 1
b = 1;  

% Planar, sin momento de inercia.
g=10;

DH = struct('d', cell(1,N), 'a', cell(1,N), 'alpha', cell(1,N), 'theta', cell(1,N),...
    'type', cell(1,N)); %genera estructura base
DH(1).alpha = 0;    DH(1).a = 0;    DH(1).d = 0;    DH(1).type = 'R';
DH(2).alpha = 0;    DH(2).a = L1;   DH(2).d = 0;    DH(2).type = 'R';

for  iLink = 1:N
        links_p{iLink} = Link('d', DH(iLink).d, 'a', DH(iLink).a, 'alpha', ...
            DH(iLink).alpha, 'm', m, 'r', rv, 'B', b, 'modified'); % Vector de estructuras Link
end

Tool = transl([L2, 0, 0]); % Offset de la herramienta (End Effector)

Robot_p = SerialLink( [links_p{:}], 'tool', Tool,'name', 'Chaplin_p' );
%%

M=Robot.inertia(Q);
V=Robot.coriolis(Q,Qd)*Qd'; %Matriz de coriolis
G=Robot.gravload(Q);
Tau=M*Qdd'+V+G;

% % Taui=Robot.itorque(Q,Qdd);
% TAU = Robot.rne(Q, Qd, Qdd);
% TAU(1);
% TAU(2);

% Ganancias
kp = 25;
kv = 2*sqrt(kp);
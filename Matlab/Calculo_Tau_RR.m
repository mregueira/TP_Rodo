%% RR
clear all;
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

i=1;
Link1=Link('alpha',alpha(i),'a',a(i),'d',d(i),'modified');
i=2;
Link2=RevoluteMDH('alpha',alpha(i),'a',a(i),'d',d(i));
% Masa concentrada
Ixx1 = 0;
Iyy1 = 0;
Izz1 = 0;
Ixx2 = 0;
Iyy2 = 0;
Izz2 = 0;

I1=[Ixx1 0 0 ; 0 Iyy1 0 ; 0 0 Izz1];
I2=[Ixx2 0 0 ; 0 Iyy2 0 ; 0 0 Izz2];

Link1.I=I1;
Link2.I=I2;

Link1.m=m1;
Link2.m=m2;

Tool = transl([L2, 0, 0]); % Offset de la herramienta (End Effector)

Robot = SerialLink( [Link1 Link2], 'tool', Tool,'name', 'Chaplin' );
Robot.gravity=gravedad;
T1 = Link1.A(th1) ;
T2 = Link2.A(th2);
Tt = double(T1) * double(T2) * Tool;

% q0 = [1 -1];
% Robot.teach(q0) %modelo dinamico de posicion inicial q
M=Robot.inertia(Q);
V=Robot.coriolis(Q,Qd)*Qd'; %Matriz de coriolis
G=Robot.gravload(Q);
Tau=M*Qdd'+V+G;

% Taui=Robot.itorque(Q,Qdd);
TAU = Robot.rne(Q, Qd, Qdd);
TAU(1);
TAU(2);

% Ganancias Critico Amortiguado
kp = 75;
kv = 20;
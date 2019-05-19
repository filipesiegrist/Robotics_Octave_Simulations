% Robô analisado: 3R

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms a_1;
syms a_2;
syms a_3;
syms theta_1;
syms theta_2;
syms theta_3;
syms x;
syms y;
syms phi;

%Tabela dos parametros DH
DH_3R = [
	[0 a_1 0 theta_1]
	[0 a_2 0 theta_2]
	[0 a_3 0 theta_3]
];

% Cinematica direta:
mDH(DH_3R)

% Cinematica inversa:
[ th1, th2, th3 ] = Inv_3R(x,y,phi,a_1,a_2,a_3)

% Exemplo do Craig "Exercício para o matlab 4" b) i)
L1 = 4; %m
L2 = 3; %m
L3 = 2; %m
% matriz de referencia
%T = [
%	[1 0 0 9]
%	[0 1 0 0]
%	[0 0 1 0]
%	[0 0 0 1]
%];
angulo = 0;
px = 9;
py = 0;

% Calcula os angulos pra chegar nessa posicao e orientacao
[ th1, th2, th3 ] = Inv_3R(px,py,angulo,L1,L2,L3)
% Calcula a posicao e orientacao com esses angulos.
DH_3R_numerica = [
	[0 L1 0 th1]
	[0 L2 0 th2]
	[0 L3 0 th3]
];
% vpa: mostra os valores da matriz sem frações.
matriz_sistema = vpa(mDH(DH_3R_numerica))

clear;
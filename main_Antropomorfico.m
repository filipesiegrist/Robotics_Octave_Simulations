% Robô analisado: Antropomórfico

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms a_2;
syms a_3;
syms d_6;
syms theta_1;
syms theta_2;
syms theta_3;
syms theta_4;
syms theta_5;
syms theta_6;

%Tabela dos parametros DH
%ATENÇÃO: Essa tabela segue o padrão apresentado no livro do Craig (ver exemplos 3.3 e 3.4), com a(i-1) e alfa(i-1) nas linhas.
DH_Antropomorfico = [
	[0 0 0 theta_1]
	[pi/2 0 0 theta_2]
	[0 a_2 0 theta_3]
	[0 a_3 0 theta_4]
	[-pi/2 0 0 theta_5]
	[pi/2 0 d_6 theta_6]
	[0 0 0 0]
];

syms joint_z joint_p;

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_Antropomorfico);

% jacobiano da cinemática
Jc = jacobianMatrix(joint_z, joint_p);

% Substituicoes para deixar a expressao mais legivel.
syms s1;
syms s2;
syms s5;
syms s23;
syms s234;
syms c1;
syms c2;
syms c5;
syms c23;
syms c234;

Jc = subs(Jc,sin(theta_1),s1);
Jc = subs(Jc,sin(theta_2),s2);
Jc = subs(Jc,sin(theta_5),s5);
Jc = subs(Jc,sin(theta_2+theta_3),s23);
Jc = subs(Jc,sin(theta_2+theta_3+theta_4),s234);
Jc = subs(Jc,cos(theta_1),c1);
Jc = subs(Jc,cos(theta_2),c2);
Jc = subs(Jc,cos(theta_5),c5);
Jc = subs(Jc,cos(theta_2+theta_3),c23);
Jc = subs(Jc,cos(theta_2+theta_3+theta_4),c234)

% jacobiano da estática
%Je = transpose(Jc)

clear;
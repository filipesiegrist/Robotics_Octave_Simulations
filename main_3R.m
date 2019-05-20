% Robô analisado: Planar 3R

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms a_1;
syms a_2;
syms a_3;
syms theta_1;
syms theta_2;
syms theta_3;

%Tabela dos parametros DH
%ATENÇÃO: Essa tabela segue o padrão apresentado no livro do Craig (ver exemplos 3.3 e 3.4), com a(i-1) e alfa(i-1) nas linhas.
DH_3R = [
	[0 0 0 theta_1]
	[0 a_1 0 theta_2]
	[0 a_2 0 theta_3]
	[0 a_3 0 0]
];

% Cinematica direta:
%mDH(DH_Antropomorfico);

syms joint_z joint_p;

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_3R);

% jacobiano da cinemática
Jc = jacobianMatrix(joint_z, joint_p);

% Substituicoes para deixar a expressao mais legivel.
syms s1;
syms s12;
syms s123;
syms c1;
syms c12;
syms c123;

Jc = subs(Jc, sin(theta_1),s1);
Jc = subs(Jc, sin(theta_1+theta_2),s12);
Jc = subs(Jc, sin(theta_1+theta_2+theta_3),s123);
Jc = subs(Jc, cos(theta_1),c1);
Jc = subs(Jc, cos(theta_1+theta_2),c12);
Jc = subs(Jc, cos(theta_1+theta_2+theta_3),c123)

% jacobiano da estática
Je = transpose(Jc)

clear;
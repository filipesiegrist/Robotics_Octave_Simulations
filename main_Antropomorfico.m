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
];

syms joint_z joint_p;

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_Antropomorfico)

% jacobiano da cinemática
%Jc = jacobianMatrix(joint_z, joint_p)

% jacobiano da estática
%Je = transpose(Jc)

clear;
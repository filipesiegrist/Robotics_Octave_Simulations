% Robô analisado: Stanford

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms d_2;
syms d_3;
syms d_6;
syms theta_1;
syms theta_2;
syms theta_4;
syms theta_5;
syms theta_6;

%Tabela dos parametros DH
%ATENÇÃO: Essa tabela segue o padrão apresentado no livro do Craig (ver exemplos 3.3 e 3.4), com a(i-1) e alfa(i-1) nas linhas.
DH_Stanford = [
	[0 0 0 theta_1]
	[-pi/2 0 d_2 theta_2]
	[pi/2 0 d_3 0]
	%[0 0 0 theta_4]
	%[-pi/2 0 0 theta_5]
	%[pi/2 0 d_6 theta_6]
];

% Mapeamento dos tipos de juntas
ROTATIVA = 0;
PRISMATICA = 1;

Juntas_Antropomorfico = [ROTATIVA, ROTATIVA, PRISMATICA, ROTATIVA, ROTATIVA, ROTATIVA];

syms joint_z joint_p;

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_Stanford, Juntas_Antropomorfico)

% jacobiano da cinemática
%Jc = jacobianMatrix(joint_z, joint_p)

% jacobiano da estática
%Je = transpose(Jc)

clear;
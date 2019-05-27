% Robô analisado: Planar 2R

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');
addpath('./Dynamics/');

%Variaveis simbolicas
syms a_1;
syms a_2;
syms theta_1;
syms theta_2;

%Tabela dos parametros DH
%ATENÇÃO: Essa tabela segue o padrão apresentado no livro do Craig (ver exemplos 3.3 e 3.4), com a(i-1) e alfa(i-1) nas linhas.
DH_2R = [
	[0 0 0 theta_1]
	[0 a_1 0 theta_2]
	[0 a_2 0 0]
];

syms joint_z joint_p joint_r;

% Parametros das juntas:
[joint_z, joint_p, joint_r] = jointParameters(DH_2R)

% jacobiano da cinemática
Jc = jacobianMatrix(joint_z, joint_p)

% jacobiano da estática
Je = transpose(Jc)

clear;
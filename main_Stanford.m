% Robô analisado: Stanford

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');
addpath('./basic_functions/');

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
	[0 0 0 theta_4]
	[-pi/2 0 0 theta_5]
	[pi/2 0 d_6 theta_6]
	[0 0 0 0]
];

% Mapeamento dos tipos de juntas
ROTATIVA = 0;
PRISMATICA = 1;

Juntas_Antropomorfico = [ROTATIVA, ROTATIVA, PRISMATICA, ROTATIVA, ROTATIVA, ROTATIVA];

syms joint_z joint_p;

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_Stanford, Juntas_Antropomorfico);

% jacobiano da cinemática
Jc = jacobianMatrix(joint_z, joint_p);

% Substituicoes para deixar a expressao mais legivel.
syms s1;
syms s2;
syms s4;
syms s5;
syms c1;
syms c2;
syms c4;
syms c5;

% Valores Z's mostrados no livro do Sicilano
joint_z = subs(joint_z,sin(theta_1),s1);
joint_z = subs(joint_z,sin(theta_2),s2);
joint_z = subs(joint_z,sin(theta_4),s4);
joint_z = subs(joint_z,sin(theta_5),s5);
joint_z = subs(joint_z,cos(theta_1),c1);
joint_z = subs(joint_z,cos(theta_2),c2);
joint_z = subs(joint_z,cos(theta_4),c4);
joint_z = subs(joint_z,cos(theta_5),c5)

% Valores P's mostrados no livro do Sicilano
joint_p = subs(joint_p,sin(theta_1),s1);
joint_p = subs(joint_p,sin(theta_2),s2);
joint_p = subs(joint_p,sin(theta_4),s4);
joint_p = subs(joint_p,sin(theta_5),s5);
joint_p = subs(joint_p,cos(theta_1),c1);
joint_p = subs(joint_p,cos(theta_2),c2);
joint_p = subs(joint_p,cos(theta_4),c4);
joint_p = subs(joint_p,cos(theta_5),c5)

Jc = subs(Jc,sin(theta_1),s1);
Jc = subs(Jc,sin(theta_2),s2);
Jc = subs(Jc,sin(theta_4),s4);
Jc = subs(Jc,sin(theta_5),s5);
Jc = subs(Jc,cos(theta_1),c1);
Jc = subs(Jc,cos(theta_2),c2);
Jc = subs(Jc,cos(theta_4),c4);
Jc = subs(Jc,cos(theta_5),c5)

% jacobiano da estática
Je = transpose(Jc)

clear;
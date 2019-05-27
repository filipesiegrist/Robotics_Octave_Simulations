% Robô analisado: Antropomórfico (só o manipulador)

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms d_1;
syms a_1;
syms a_2;
syms a_3;
syms theta_1;
syms theta_2;
syms theta_3;
syms x;
syms y;
syms z;

%Tabela dos parametros DH
DH_ARR5 = [
	[0 0 d_1 theta_1]
	[-pi/2 a_1 0 theta_2]
	[0 a_2 0 theta_3]
	[0 a_3 0 0]
];

% Cinematica direta:
Direct = mDH(DH_ARR5);

% Substituicoes para deixar as expressoes mais legiveis.
syms s1;
syms s2;
syms s3;
syms s23;
syms c1;
syms c2;
syms c23;

% Substituicoes na Matriz 
Direct = subs(Direct,sin(theta_1),s1);
Direct = subs(Direct,sin(theta_2),s2);
Direct = subs(Direct,sin(theta_2+theta_3),s23);
Direct = subs(Direct,cos(theta_1),c1);
Direct = subs(Direct,cos(theta_2),c2);
Direct = subs(Direct,cos(theta_2+theta_3),c23)

% Coordenadas do Objetivo
obj_col = 4;
obj_lines = 1:3;

Objective = Direct(obj_lines, obj_col)

syms joint_z joint_p;

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_ARR5);

% jacobiano da cinemática
Jc = jacobianMatrix(joint_z, joint_p);
valid_lines = 1:3;
Jc = Jc(valid_lines, :);

% Jacobiano Inverso:
Inv_Jc = inv(Jc);

% Substituicoes no Jacobiano
Jc = subs(Jc,sin(theta_1),s1);
Jc = subs(Jc,sin(theta_2),s2);
Jc = subs(Jc,sin(theta_2+theta_3),s23);
Jc = subs(Jc,cos(theta_1),c1);
Jc = subs(Jc,cos(theta_2),c2);
Jc = subs(Jc,cos(theta_2+theta_3),c23)

% Jacobiano Transposto:
Transposed_Jc = transpose(Jc)

% Simplificando o Jacobiano Inverso:
Inv_Jc = simplify(Inv_Jc);

% Substituicoes no Jacobiano Inverso:
Inv_Jc = subs(Inv_Jc,sin(theta_1),s1);
Inv_Jc = subs(Inv_Jc,sin(theta_2),s2);
Inv_Jc = subs(Inv_Jc,sin(theta_3),s3);
Inv_Jc = subs(Inv_Jc,sin(theta_2+theta_3),s23);
Inv_Jc = subs(Inv_Jc,cos(theta_1),c1);
Inv_Jc = subs(Inv_Jc,cos(theta_2),c2);
Inv_Jc = subs(Inv_Jc,cos(theta_2+theta_3),c23)

clear;
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


syms joint_z joint_p joint_r joint_rp;

% Parametros dos elos:
[joint_r, joint_rp] = linkParameters(DH_3R);

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_3R);

% jacobiano da cinemática
Jc = jacobianMatrix(joint_z, joint_p);

% jacobiano da estática
Je = transpose(Jc);

% Substituicoes para deixar a expressao mais legivel.
syms s1;
syms s2;
syms s3;
syms s12;
syms s23;
syms s123;
syms c1;
syms c2;
syms c3;
syms c12;
syms c23;
syms c123;

Jc = subs(Jc, sin(theta_1),s1);
Jc = subs(Jc, sin(theta_1+theta_2),s12);
Jc = subs(Jc, sin(theta_1+theta_2+theta_3),s123);
Jc = subs(Jc, cos(theta_1),c1);
Jc = subs(Jc, cos(theta_1+theta_2),c12);
Jc = subs(Jc, cos(theta_1+theta_2+theta_3),c123)

% jacobiano da estática
Je = transpose(Jc)

% calculo da dinamica:

%Numero de elos
N_3R = 3;

% Velocidades e aceleracoes angulares
syms speed_joint_1 speed_joint_2 speed_joint_3;
syms acc_joint_1 acc_joint_2 acc_joint_3;
speeds_3R = [speed_joint_1; speed_joint_2; speed_joint_3];
acc_3R = [acc_joint_1; acc_joint_2; acc_joint_3];

% Os centros de massa estão nas pontas.
mass_centers_3R = [
	[a_1 a_2 a_3]
	[ 0   0   0 ]
	[ 0   0   0 ]
]; 

syms m_1 m_2 m_3;
masses_3R = [m_1; m_2; m_3];


% Tensores de inercia (considerados como zero.)
I_tensor_3R = zeros(3,9);

% Remover a primeira parte dos parametros:
joint_r = joint_r(:, 4:12);
%joint_rp = joint_rp(:, 2:3);
joint_z = joint_z(:, 2:4);

% Aceleracao no efetuador:
syms g;
initial_acceleration_3R = [0; g ; 0];

%Teste alternativo para os joint points. FUNCIONOU
joint_rp = [
	[0 a_1 a_2 a_3]
	[0  0   0   0 ]
	[0  0   0   0 ]
];

% Forças e torques nas juntas

[joint_F, joint_T] = robotDynamics(N_3R, joint_z, joint_rp, joint_r, speeds_3R, acc_3R, masses_3R, I_tensor_3R, mass_centers_3R, initial_acceleration_3R);

joint_F = subs(joint_F, sin(theta_1),s1);
joint_F = subs(joint_F, sin(theta_2),s2);
joint_F = subs(joint_F, sin(theta_3),s3);
joint_F = subs(joint_F, sin(theta_1+theta_2),s12);
joint_F = subs(joint_F, sin(theta_2+theta_3),s23);
joint_F = subs(joint_F, sin(theta_1+theta_2+theta_3),s123);
joint_F = subs(joint_F, cos(theta_1),c1);
joint_F = subs(joint_F, cos(theta_2),c2);
joint_F = subs(joint_F, cos(theta_3),c3);
joint_F = subs(joint_F, cos(theta_1+theta_2),c12);
joint_F = subs(joint_F, cos(theta_2+theta_3),c23);
joint_F = subs(joint_F, cos(theta_1+theta_2+theta_3),c123)

joint_T = subs(joint_T, sin(theta_1),s1);
joint_T = subs(joint_T, sin(theta_2),s2);
joint_T = subs(joint_T, sin(theta_3),s3);
joint_T = subs(joint_T, sin(theta_1+theta_2),s12);
joint_T = subs(joint_T, sin(theta_2+theta_3),s23);
joint_T = subs(joint_T, sin(theta_1+theta_2+theta_3),s123);
joint_T = subs(joint_T, cos(theta_1),c1);
joint_T = subs(joint_T, cos(theta_2),c2);
joint_T = subs(joint_T, cos(theta_3),c3);
joint_T = subs(joint_T, cos(theta_1+theta_2),c12);
joint_T = subs(joint_T, cos(theta_2+theta_3),c23);
joint_T = subs(joint_T, cos(theta_1+theta_2+theta_3),c123)

clear;
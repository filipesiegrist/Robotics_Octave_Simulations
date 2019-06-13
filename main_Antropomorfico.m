% Robô analisado: Antropomórfico

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Differential_Kinematics/');
addpath('./Denavit_Hartenberg/');
addpath('./Dynamics/');

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

syms joint_z joint_p joint_r joint_rp;

% Parametros dos elos:
[joint_r, joint_rp] = linkParameters(DH_Antropomorfico);

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
Je = transpose(Jc)

% calculo da dinamica:

%Numero de elos
N_Antropomorfico = 6;

% Velocidades e aceleracoes angulares
syms speed_joint_1 speed_joint_2 speed_joint_3 speed_joint_4 speed_joint_5 speed_joint_6;
syms acc_joint_1 acc_joint_2 acc_joint_3 acc_joint_4 acc_joint_5 acc_joint_6;
speeds_Antropomorfico = [speed_joint_1; speed_joint_2; speed_joint_3; speed_joint_4; speed_joint_5; speed_joint_6];
acc_Antropomorfico = [acc_joint_1; acc_joint_2; acc_joint_3; acc_joint_4; acc_joint_5; acc_joint_6];

% Os centros de massa estão nas pontas.
mass_centers_Antropomorfico = [
	[ 0  a_2 a_3  0   0   0 ]
	[ 0   0   0   0   0   0 ]
	[ 0   0   0   0   0   0 ]
]; 

syms m_1 m_2 m_3 m_4 m_5 m_6;
masses_Antropomorfico = [m_1; m_2; m_3; m_4; m_5; m_6];


% Tensores de inercia (considerados como zero.)
I_tensor_Antropomorfico = zeros(3,18);

% Remover a primeira parte dos parametros:
joint_r = joint_r(:, 4:21);
%joint_rp = joint_rp(:, 2:3);
joint_z = joint_z(:, 2:7);

% Aceleracao no efetuador:
syms g;
initial_acceleration_Antropomorfico = [0; g ; 0];

%Teste alternativo para os joint points. FUNCIONOU
joint_rp = [
	[0  0  a_2  a_3  0  0  0]
	[0  0   0   0  0  0  0]
	[0  0   0   0  0  0  0]
];

% Forças e torques nas juntas

[joint_F, joint_T] = robotDynamics(N_Antropomorfico, joint_z, joint_rp, joint_r, speeds_Antropomorfico, acc_Antropomorfico, masses_Antropomorfico, I_tensor_Antropomorfico, mass_centers_Antropomorfico, initial_acceleration_Antropomorfico);

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
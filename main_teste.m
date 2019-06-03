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

syms joint_z joint_p joint_r joint_rp;

% Parametros dos elos:
[joint_r, joint_rp] = linkParameters(DH_2R);

% Parametros das juntas:
[joint_z, joint_p] = jointParameters(DH_2R);

% jacobiano da cinemática
%Jc = jacobianMatrix(joint_z, joint_p)

% jacobiano da estática
%Je = transpose(Jc)

% calculo da dinamica:

%Numero de elos
N_2R = 2;

% Velocidades e aceleracoes angulares
syms speed_joint_1 speed_joint_2;
syms acc_joint_1 acc_joint_2;
speeds_2R = [speed_joint_1; speed_joint_2];
acc_2R = [acc_joint_1; acc_joint_2];

% Os centros de massa estão nas pontas.
mass_centers_2R = [
	[a_1 a_2]
	[ 0   0 ]
	[ 0   0 ]
]; %MUDAR para a1*x1 e a2*x2

syms m_1 m_2;
masses_2R = [m_1; m_2];


% Tensores de inercia (considerados como zero.)
I_tensor_2R = zeros(3,6);

% Remover a primeira parte dos parametros:
joint_r = joint_r(:, 4:9);
%joint_rp = joint_rp(:, 2:3);
joint_z = joint_z(:, 2:3);

% Aceleracao no efetuador:
syms g;
initial_acceleration_2R = [0; g ; 0];

%Teste alternativo para os joint points. FUNCIONOU
joint_rp = [
	[0 a_1 a_2]
	[0  0   0 ]
	[0  0   0 ]
];

[joint_F, joint_T] = robotDynamics(N_2R, joint_z, joint_rp, joint_r, speeds_2R, acc_2R, masses_2R, I_tensor_2R, mass_centers_2R, initial_acceleration_2R);

clear;
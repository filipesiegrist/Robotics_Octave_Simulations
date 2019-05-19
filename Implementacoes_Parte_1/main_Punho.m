% Robô analisado: Antropomórfico (só o manipulador)

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms d_6;
syms theta_4;
syms theta_5;
syms theta_6;
syms ax ay az nx ny nz sx sy sz;

%Tabela dos parametros DH
DH_Punho = [
	[-pi/2 0 0 theta_4]
	[pi/2 0 0 theta_5]
	[0 0 d_6 theta_6]
];

% Cinematica direta:
mDH(DH_Punho)

% Cinematica inversa:
orientacao = [
	[nx sx ax]
	[ny sy ay]
	[nz sz az]
];
[th_4,th_5,th_6] = Inv_Punho (orientacao)

% Exemplo numerico
L6 = 3; % (m)
orientacao_desejada = [
	[-1 0 0]
	[0 -1 0]
	[0 0 1]
];

% Calculando os angulos para chegar nessa orientacao
[th_4,th_5,th_6] = Inv_Punho (orientacao_desejada)

% Verificando se a orientacao resultante com esses angulos bate.
DH_Punho_numerica = [
	[-pi/2 0 0 th_4]
	[pi/2 0 0 th_5]
	[0 0 L6 th_6]
];
vpa(mDH(DH_Punho_numerica))

clear;
% Robô analisado: Antropomórfico (só o manipulador)

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms a_2;
syms a_3;
syms theta_1;
syms theta_2;
syms theta_3;
syms x;
syms y;
syms z;

%Tabela dos parametros DH
DH_Antropomorfico = [
	[0 0 0 theta_1]
	[pi/2 0 0 theta_2]
	[0 a_2 0 theta_3]
	[0 a_3 0 0]
];

% Cinematica direta:
mDH(DH_Antropomorfico)

% Cinematica inversa:
vector = [x;y;z];
[th_1,th_2,th_3] = Inv_Antropomorfico (a_2,a_3,vector)

% Exemplo numerico
L2 = 4; % (m)
L3 = 3; % (m)

th1 = pi/4;
th2 = pi/2;
th3 = pi/4;

DH_Antropomorfico_numerica = [
	[0 0 0 th1]
	[pi/2 0 0 th2]
	[0 L2 0 th3]
	[0 L3 0 0]
];

% Calcula a posicao com esses dados.
% vpa: mostra os valores da matriz sem frações.
matriz_sistema = vpa(mDH(DH_Antropomorfico_numerica))

% Calcula os dados pra chegar nessa posicao
px = matriz_sistema(1,4);
py = matriz_sistema(2,4);
pz = matriz_sistema(3,4);
pos = [px;py;pz]
% Esses angulos de junta serao diferentes.
[th_1,th_2,th_2] = Inv_Antropomorfico(L2,L3,pos)


% Realimenta a matriz mais uma vez, pra garantir que esses dados chegarao no mesmo resultado. 
DH_Antropomorfico_numerica_2 = [
	[0 0 0 th1]
	[pi/2 0 0 th2]
	[0 L2 0 th3]
	[0 L3 0 0]
];
matriz_sistema_2 = vpa(mDH(DH_Antropomorfico_numerica_2));

% Como o resultado dessa operacao é uma matriz vazia, os dados de junta obtidos resultaram em uma posicao valida.
matriz_sistema_2 - matriz_sistema

clear;
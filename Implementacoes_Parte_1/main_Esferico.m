% Robô analisado: Esférico (só o manipulador)

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas
syms d_2;
syms d_3;
syms theta_1;
syms theta_2;
syms x;
syms y;
syms z;

%Tabela dos parametros DH
DH_Esferico = [
	[-pi/2 0 0 theta_1]
	[pi/2 0 d_2 theta_2]
	[0 0 d_3 0]
];

% Cinematica direta:
mDH(DH_Esferico)

% Cinematica inversa:
vector = [x;y;z];
[ theta_1, theta_2, d_3 ] = Inv_Esferico(vector,d_2)

% Exemplo numerico
L2 = 5; % (m)

th1 = pi/4;
th2 = pi/2;
L3 = 4;

DH_Esferico_numerica = [
	[-pi/2 0 0 th1]
	[pi/2 0 L2 th2]
	[0 0 L3 0]
];

% Calcula a posicao com esses dados.
% vpa: mostra os valores da matriz sem frações.
matriz_sistema = vpa(mDH(DH_Esferico_numerica))

% Calcula os dados pra chegar nessa posicao
px = matriz_sistema(1,4);
py = matriz_sistema(2,4);
pz = matriz_sistema(3,4);
pos = [px;py;pz]
% Esses valores de junta serao diferentes.
[th_1,th_2,d3] = Inv_Esferico(pos,L2)


% Realimenta a matriz mais uma vez, pra garantir que esses dados chegarao no mesmo resultado. 
DH_Esferico_numerica_2 = [
	[-pi/2 0 0 th1]
	[pi/2 0 L2 th2]
	[0 0 L3 0]
];
matriz_sistema_2 = vpa(mDH(DH_Esferico_numerica_2));

% Como o resultado dessa operacao é uma matriz vazia, os dados de junta obtidos resultaram em uma posicao valida.
matriz_sistema_2 - matriz_sistema

clear;
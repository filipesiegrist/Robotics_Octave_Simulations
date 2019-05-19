% Robô analisado: Esférico (só o manipulador)

clear;
warning('off','all');

% Importações
addpath('./Inverse_Kinematics/');
addpath('./Denavit_Hartenberg/');

%Variaveis simbolicas

% Parametros do robo
syms d_2;
syms d_6;

% Parametros de juntas
syms theta_1;
syms theta_2;
syms d_3;
syms theta_4;
syms theta_5;
syms theta_6;

% Saida
syms x;
syms y;
syms z;
syms ax ay az nx ny nz sx sy sz;
orientacao = [
	[nx sx ax]
	[ny sy ay]
	[nz sz az]
];

%Tabela dos parametros DH
DH_Stanford = [
	[-pi/2 0 0 theta_1]
	[pi/2 0 d_2 theta_2]
	[0 0 d_3 0]
	[-pi/2 0 0 theta_4]
	[pi/2 0 0 theta_5]
	[0 0 d_6 theta_6]
];


% Cinematica direta:
mDH(DH_Stanford)  							%TIRA

% Cinematica inversa:
vector = [x;y;z];
[th_1,th_2,d3,th_4,th_5,th_6] = Inv_Stanford (vector, d_2, orientacao);				%TIRA

% Exemplo numerico:

% Parametros do robo
L2 = 5; % (m)
L6 = 4; % (m)

% Parametros de juntas
th1 = pi/2;
th2 = pi/4;
d3 = 5;		% (m)
th4 = -pi/4;
th5 = 0;
th6 = -pi/6;

DH_Stanford_numerica = [
	[-pi/2 0 0 th1]
	[pi/2 0 L2 th2]
	[0 0 d3 0]
	[-pi/2 0 0 th4]
	[pi/2 0 0 th5]
	[0 0 L6 th6]
];

% Calcula a posicao e orientacao com esses dados.
% vpa: mostra os valores da matriz sem frações.
matriz_sistema = vpa(mDH(DH_Stanford_numerica))

% Calcula os dados pra chegar nessa posicao e orientacao
px = matriz_sistema(1,4);
py = matriz_sistema(2,4);
pz = matriz_sistema(3,4);
pos = [px;py;pz];
orientacao_numerica = matriz_sistema(1:3,1:3);

% Os valores deram diferentes.
[th1,th2,d3,th4,th5,th6] = Inv_Stanford (pos, L2, orientacao_numerica)

% Realimentar o sistema com esses valores para ver se chega-se na mesma matriz
DH_Stanford_numerica_2 = [
	[-pi/2 0 0 th1]
	[pi/2 0 L2 th2]
	[0 0 d3 0]
	[-pi/2 0 0 th4]
	[pi/2 0 0 th5]
	[0 0 L6 th6]
];
matriz_sistema_2 = vpa(mDH(DH_Stanford_numerica_2));

% Se forem iguais, a diferença será uma matriz de zeros
matriz_sistema_2 - matriz_sistema

clear;
% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 13: Transmissao Digital
% DIA 27/03/2018
% Jessica de Souza

%Representando um sinal NRZ bipolar 4PAM

clear all;
close all;
clc;

% Dados
N = 4;                   % Numero de niveis, Modulação 4PAM
L = 100;                 % Fator de superamostragem
info = randint(1,10,4);  % Gera sinais aleat. entre 0 e 3
info = (info*2)-3;       % Faz com que tudo fique entre 3,1,-1 e -3

% Filtro que ira formatar o sinal
filtro_format = ones(1,L);

% Superamostrar o sinal com fator L
info_up = upsample(info,L);

% Passar o sinal pelo filtro
sinal_filter = filter(filtro_format,1,info_up);

% Plotando os sinais
figure,
subplot(311),stem (info);
title('Sinal Original');
ylim([-3.5 3.5]);
subplot(312),plot (info_up);
title('Sinal Superamostrado');
ylim([-3.5 3.5]);
subplot(313),plot(sinal_filter);
title('Sinal Superamostrado e Filtrado');
ylim([-3.5 3.5]); 

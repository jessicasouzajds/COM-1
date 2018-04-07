% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 15: Transmissao Digital - Parte 3
% DIA 02/04/2018
% Jessica de Souza

% Simulando uma transmissao em um canal AWGN

close all;
clear all;
clc;

% Dados
Rb = 10000;   % taxa de transmissao de bit
N = 100;      % fator de superamostragem

% Gerando a informação

%NO MATLAB:
%info = randint(1,10000);
%NO OCTAVE:
info = randi(2,1, Rb)-1;
info_up = upsample(info,N);

% Criando o filtro e formatando o sinal
filtro = ones(1,N);
info_format = filter(filtro,1,info_up);

% Gerando o ruido
ruido = randn(1,length(info_up))*0.2;

% Soma do sinal com o ruido (sinal AWGN de um receptor)
sinal_rx = info_format + ruido;   % sinal recebido

% Amostra o sinal para cada pulso iniciar no centro de cada bit
Z_t = sinal_rx(50:100:end);

% Compara o sinal com o valor de 0,5 para transforma-lo em binario
info_hat = Z_t>0.5;

% Verificação de erro do sinal recebido
num_err = sum(xor(info,info_hat));
BER = num_err/length(info_hat)

% Cria o filtro para recuperar o sinal
filtro_rx = fir1(50,0.1);   % filtro passa baixa de ordem 50
sinal_rx_filt = filter(filtro_rx,1,sinal_rx); % sinal recebido e filtrado

% Amostra o sinal para cada pulso iniciar no centro de cada bit
Zt2 = sinal_rx_filt(50:100:end);

% Compara o sinal com o valor de 0,5 para transforma-lo em binario
info_ft = Zt2>0.5;

% Verificação de erro do sinal recebido apos filtra-lo
num_err2 = sum(xor(info,info_ft));
BER2 = num_err2/length(info_hat)

% Plotando os resultados
figure,
subplot(311),plot(info_format);
title('Sinal original');
axis([0 1000 -0.5 1.5]);
subplot(312),plot(sinal_rx);
title('Sinal recebido sem filtro');
xlim([0 1000]);
subplot(313),plot(sinal_rx_filt);
title('Sinal recebido com filtro');
xlim([0 1000]);
% --- SISTEMAS DE COMUNICAÇÃO 1 ---
% Trabalho 4: Transmissão binária e análise de desempenho de erro
% DIA 24/04/2018
% Aluna: Jessica de Souza

% Questao 1 de 2: Recepção com e sem filtro casado

clear all;
close all;
clc;

% Dados
info = [0 1 1 0 1 0 1 1 0 1 0]; % Informação, NRZ unipolar
SNR = 10; % dB
N = 100;  % Fator de superamostragem
Rb = length(info);   % Taxa de transmissao de bit
Fs = Rb*N;
t = [0:1/Fs:1-1/Fs];

% Gerando o filtro
filtro_tx = ones(1,N);      % pulso de 100 amostras
info_up = upsample(info,N); % insere 100 amostras a cada valor da info

% Passando o sinal pelo filtro
sinal_tx = filter(filtro_tx,1,info_up);

% Sinal recebido
sinal_rx = awgn(sinal_tx,SNR); % Ruido no receptor
Z_t = sinal_rx(N/2:N:end); % info hat


% Adicionando um filtro casado no receptor
filtro_rx = filtro_tx;
sinal_rx_filt = filter(filtro_rx,1,sinal_rx)/N;
Z_t_filt = sinal_rx_filt(N/2:N:end); % info hat filt

% Resultados
figure,
subplot(411),plot(t,info_up);
%title('Informação Superamostrada');
title('(a)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');
ylim([-0.5 1.5]);

subplot(412),plot(t,sinal_tx);
%title('Informação Transmitida');
title('(b)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');
ylim([-0.5 1.5]);

subplot(413),plot(t,sinal_rx);
%title('Informação Recebida');
title('(c)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');
ylim([-0.5 1.5]);

subplot(414),plot(t,sinal_rx_filt);
%title('Informação Recebida');
title('(d)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');
ylim([-0.5 1.5]);
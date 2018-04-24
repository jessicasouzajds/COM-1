% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 18: Filtro casado em um canal AWGN
% DIA 10/04/2018
% Jessica de Souza

close all;
clear all;
clc;

% Dados
A = 1;    % Amplitude do sinal
Rb = 5;   % Taxa de tx
N = 100;  % Fator de superamostragem
Ts = 1/(Nsamp*Rb);  % Periodo de superamostragem
t = [0:Ts:1-Ts];
SNR = 10;           % SNR do canal AWGN

% Gerando a informação
info = randint(1,Rb);
info_NRZ = (info*2*A)-A;

% Criando os filtros de TX: O filtro determina o tipo de sinalização PCM
filtro_tx = ones(1,Nsamp);                       % filtro NRZ
filtro_tx2 = [ones(1,Nsamp/2) zeros(1,Nsamp/2)]; % filtro RZ
filtro_tx3 = [ones(1,Nsamp/2) zeros(1,Nsamp/2)]*2-1; % filtro manchester

% Os filtros RX: o filtro casado requer que o filtro tx e rx sejam iguais
% para que a SNR seja maximizada
filtro_rx = flip(filtro_tx);

% Formatando o sinal para transmitir
info_up = upsample(info_NRZ,Nsamp);
sinal_TX = filter(filtro_tx,1,info_up);

% Sinal recebido
sinal_RX = awgn(sinal_TX,SNR); %AWGN() ja adiciona o ruido no sinal 
sinal_rx_filt = filter(filtro_rx,1,sinal_RX)/Nsamp;

% Plotando os resultados
figure,
subplot(311),plot(t,sinal_TX);
subplot(312),plot(t,sinal_RX);
ylim([-1.5 1.5]);
subplot(313),plot(t,sinal_rx_filt);
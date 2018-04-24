% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 17: Detecção de sinais binários em um canal AWGN
% DIA 05/04/2018
% Jessica de Souza

clear all;
close all;
clc;

% Dados
N = 100; % Fator de superamostragem
SNR_max=10;  % Razao Sinal-Ruido
limiar = 0;
Rb = 10000;

% Gerando a informação
info= randint(1,Rb); 
info_nrz = (info * 2) - 1; % Gerando os níveis do sinal;

% Criando o filtro que irá formatar a informação
filtro_nrz = ones(1,N);
info_up = upsample(info_nrz,N);  % Superamostrando a informação em Nsamp

% Filtrando o sinal
sinal_tx=filter(filtro_nrz,1,info_up);

% Verificação de erro em função da SNR
for SNR = 0 : SNR_max
    sinal_rx = awgn(sinal_tx,SNR); % Adiciona ruido branco gaussiano no sinal com dada SNR
    Z_T = sinal_rx(N/2:N:end); % Amostra o sinal para cada pulso iniciar no centro de cada bit
    info_hat = (Z_T > limiar); % Compara o sinal com limiar para transforma-lo em binario
    Pb(SNR+1) = sum(xor(info,info_hat))/length(info_hat); % Probabilidade de erro do sinal Rx
end

% Plotando os resultados
figure, semilogy([0:SNR_max],Pb);
xlabel('SNR');
ylabel('Probabilidade de erro'); % Gráfico para verificar a função Q.

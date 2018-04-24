% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 17: Detec��o de sinais bin�rios em um canal AWGN
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

% Gerando a informa��o
info= randint(1,Rb); 
info_nrz = (info * 2) - 1; % Gerando os n�veis do sinal;

% Criando o filtro que ir� formatar a informa��o
filtro_nrz = ones(1,N);
info_up = upsample(info_nrz,N);  % Superamostrando a informa��o em Nsamp

% Filtrando o sinal
sinal_tx=filter(filtro_nrz,1,info_up);

% Verifica��o de erro em fun��o da SNR
for SNR = 0 : SNR_max
    sinal_rx = awgn(sinal_tx,SNR); % Adiciona ruido branco gaussiano no sinal com dada SNR
    Z_T = sinal_rx(N/2:N:end); % Amostra o sinal para cada pulso iniciar no centro de cada bit
    info_hat = (Z_T > limiar); % Compara o sinal com limiar para transforma-lo em binario
    Pb(SNR+1) = sum(xor(info,info_hat))/length(info_hat); % Probabilidade de erro do sinal Rx
end

% Plotando os resultados
figuire, semilogy([0:SNR_max],Pb);
xlabel('SNR');
ylabel('Probabilidade de erro'); % Gr�fico para verificar a fun��o Q.
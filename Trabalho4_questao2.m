% --- SISTEMAS DE COMUNICAÇÃO 1 ---
% Trabalho 4: Transmissão binária e análise de desempenho de erro
% DIA 24/04/2018
% Aluna: Jessica de Souza

% Questao 2 de 2: Fazer simulação de desempenho de erro para comparar, através 
% de um gráfico de Probabilidade de erro de bit (Pb) x SNR, os seguintes sistemas

%% Sistema 1
% Transmissão utilizando sinalização NRZ unipolar com amplitude de 1V e 2V,
% ambos sem a utilização de filtro casado;

clear all;
close all;
clc;

% Dados
N = 100;     % Fator de superamostragem
SNR_max=15;  % Razao Sinal-Ruido
Rb = 10000;
A1 = 1;
A2 = 2;
limiar1 = 0.5;
limiar2 = 1;
Fs = Rb;
t = [0:1/Fs:1-1/Fs];

% Gerando a informação
info= randint(1,Rb); 
info_nrz1 = info * A1; % Gerando os níveis do sinal;
info_nrz2 = info * A2; % Gerando os níveis do sinal;

% Criando o filtro que irá formatar a informação
filtro_nrz = ones(1,N);
info_up1 = upsample(info_nrz1,N);  % Superamostrando a informação em Nsamp
info_up2 = upsample(info_nrz2,N);  % Superamostrando a informação em Nsamp

% Filtrando o sinal
sinal_tx1=filter(filtro_nrz,1,info_up1);
sinal_tx2=filter(filtro_nrz,1,info_up2);

% Verificação de erro em função da SNR
for SNR = 0 : SNR_max
    % Adiciona ruido branco gaussiano no sinal com dada SNR
    sinal_rx1 = awgn(sinal_tx1,SNR);
    sinal_rx2 = awgn(sinal_tx2,SNR);
    
    % Amostra o sinal para cada pulso iniciar no centro de cada bit
    Z_T1 = sinal_rx1(N/2:N:end);
    Z_T2 = sinal_rx2(N/2:N:end);
    
    % Compara o sinal com limiar para transforma-lo em binario
    info_hat1 = (Z_T1 > limiar1);
    info_hat2 = (Z_T2 > limiar2);
    
    % Probabilidade de erro de bit do sinal Rx
    Pb1(SNR+1) = sum(xor(info_nrz1,info_hat1))/length(info_hat1);
    Pb2(SNR+1) = sum(xor(info_nrz2,info_hat2))/length(info_hat2);
end

% Plotando os resultados
figure, semilogy([0:SNR_max],Pb1);
hold on,
semilogy([0:SNR_max],Pb2);
xlabel('SNR');
ylabel('Probabilidade de erro (Pb)'); % Gráfico para verificar a função Q.
legend('1V','2V');
hold off;

figure,
subplot(221),
plot(t,info_nrz1);
axis([0 20/Fs -1 2]);
title('(a)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(222);
plot(t,info_nrz2);
axis([0 20/Fs -1 3]);
title('(b)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(223),
plot(t,Z_T1);
axis([0 20/Fs -1 2]);
title('(c)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(224),
plot(t,Z_T2);
axis([0 20/Fs -1 3]);
title('(d)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');

%% Sistema 2
% Transmissão utilizando sinalização NRZ unipolar com amplitude de 1V, 
% com e sem filtro casado;

clear all;
close all;
clc;

% Dados
N = 10;      % Fator de superamostragem
SNR_max=15;  % Razao Sinal-Ruido
Rb = 10000;  
A = 1;
limiar = A/2;
Fs = Rb;
t = [0:1/Fs:1-1/Fs];


info= randint(1,Rb);               % Gerando a informação
info_nrz1 = info * A;              % Gerando os níveis do sinal;
filtro_nrz = ones(1,N);            % Criando o filtro que irá formatar a informação
info_up1 = upsample(info_nrz1,N);  % Superamostrando a informação em Nsamp

sinal_tx1=filter(filtro_nrz,1,info_up1); % Filtrando o sinal

filtro_rx = flip(filtro_nrz);            % Filtro do receptor

% Verificação de erro de bit em função da SNR
for SNR = 0 : SNR_max
    % Adiciona ruido branco gaussiano no sinal com dada SNR
    sinal_rx1 = awgn(sinal_tx1,SNR); 
    sinal_rx2 = filter(filtro_rx,1,sinal_rx1)/N;
    
    % Amostra o sinal para cada pulso iniciar no centro de cada bit
    Z_T1 = sinal_rx1(N/2:N:end);
    Z_T2 = sinal_rx2(N:N:end);
    
    % Compara o sinal com limiar para transforma-lo em binario
    info_hat1 = (Z_T1 > limiar); 
    info_hat2 = (Z_T2 > limiar);
    
    % Probabilidade de erro dos sinais Rx
    Pb1(SNR+1) = sum(xor(info_nrz1,info_hat1))/length(info_hat1); 
    Pb2(SNR+1) = sum(xor(info_nrz1,info_hat2))/length(info_hat2);
end

% Plotando os resultados
figure, semilogy([0:SNR_max],Pb1);
hold on,
semilogy([0:SNR_max],Pb2);
xlabel('SNR');
ylabel('Probabilidade de erro (Pb)'); % Gráfico para verificar a função Q.
legend('1V','2V');
hold off;

figure,
subplot(221),
plot(t,info_nrz1);
axis([0 40/Fs -1 2]);
title('(a)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(222);
plot(t,info_nrz1);
axis([0 40/Fs -1 2]);
title('(b)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(223),
plot(t,Z_T1);
axis([0 40/Fs -1 2]);
title('(c)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(224),
plot(t,Z_T2);
axis([0 40/Fs -1 2]);
title('(d)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');

%% Sistema 3
% Transmissão utilizando sinalização NRZ unipolar e bipolar, ambos com a 
% utilização de filtro casado;

clear all;
close all;
clc;

% Dados
N = 1;       % Fator de superamostragem
SNR_max=15;  % Razao Sinal-Ruido
Rb = 100000;
A = 1;
limiar = A/2;
Fs = Rb;
t = [0:1/Fs:1-1/Fs];

% Gerando a informação
info= randint(1,Rb); 
info_nrz_uni = info * A;
info_nrz_bi = (info*2)-1;

% Criando o filtro que irá formatar a informação
filtro_nrz = ones(1,N);

% Superamostrando a informação em N
info_up_uni = upsample(info_nrz_uni,N);  
info_up_bi = upsample(info_nrz_bi,N);

% Filtrando o sinal
sinal_tx_uni=filter(filtro_nrz,1,info_up_uni);
sinal_tx_bi=filter(filtro_nrz,1,info_up_bi);

% Filtro do receptor
filtro_rx = filtro_nrz;


% Verificação de erro em função da SNR
for SNR = 0 : SNR_max
    % Adiciona ruido branco gaussiano no sinal com dada SNR
    sinal_rx_uni = awgn(sinal_tx_uni,SNR); 
    sinal_rx_bi = awgn(sinal_tx_bi,SNR);
    
    % Adiciona ruido branco gaussiano no sinal com dada SNR
    sinal_rx_uni_filt = filter(filtro_rx,1,sinal_rx_uni)/N;   
    sinal_rx_bi_filt = filter(filtro_rx,1,sinal_rx_bi)/N; 

    % Amostra o sinal para cada pulso iniciar no fim de cada bit
    Z_T_uni = sinal_rx_uni_filt(N:N:end);
    Z_T_bi = sinal_rx_bi_filt(N:N:end);
    
    % Compara o sinal com limiar para transforma-lo em binario
    info_hat_uni = (Z_T_uni > limiar); 
    info_hat_bi = (Z_T_bi > limiar);
    
    % Probabilidade de erro do sinal Rx
    Pb1(SNR+1) = sum(xor(info_nrz_uni,info_hat_uni))/length(info_hat_uni); 
    Pb2(SNR+1) = sum(xor(info_nrz_uni,info_hat_bi))/length(info_hat_bi);   
end

% Plotando os resultados
figure, semilogy([0:SNR_max],Pb1);
hold on,
semilogy([0:SNR_max],Pb2);
xlabel('SNR');
ylabel('Probabilidade de erro (Pb)'); % Gráfico para verificar a função Q.
legend('Sem filtro','Filtro casado');
hold off;

figure,
subplot(221),
plot(t,info_nrz_uni);
axis([0 20/Fs -1 2]);
title('(a)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(222);
plot(t,info_nrz_bi);
axis([0 20/Fs -2 2]);
title('(b)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(223),
plot(t,Z_T_uni);
axis([0 20/Fs -1 2]);
title('(c)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');
subplot(224),
plot(t,Z_T_bi);
axis([0 20/Fs -2 2]);
title('(d)');
xlabel('Tempo (s)');
ylabel('Amplitude (v)');

%% Sistema 4
% Plote as expressões teóricas de Pb das sinalizações Polar e Bipolar 
%(eq. 3.73 e 3.76) e compare-as com os resultados da simulação do item 3. 
%Observe que as simulações anteriores estão em função de SNR e as expressões em função de Eb/No!

clear all;
close all;
clc;

% Dados
N = 1;     % Fator de superamostragem
Eb_N0=15;  % Razao Sinal-Ruido
Rb = 100000;
A = 1;
limiar = A/2;
Fs = Rb;
t = [0:1/Fs:1-1/Fs];

% Gerando a informação
info= randint(1,Rb); 
info_nrz_uni = info * A;
info_nrz_bi = (info*2)-1;

% Criando o filtro que irá formatar a informação
filtro_nrz = ones(1,N);

% Superamostrando a informação em N
info_up_uni = upsample(info_nrz_uni,N);
info_up_bi = upsample(info_nrz_bi,N);

% Filtrando o sinal
sinal_tx_uni=filter(filtro_nrz,1,info_up_uni);
sinal_tx_bi=filter(filtro_nrz,1,info_up_bi);

% Filtro do receptor
filtro_rx = filtro_nrz;

% Verificação de erro em função da SNR
for EBN0 = 0 : Eb_N0
    % Adiciona ruido branco gaussiano no sinal com dada SNR
    sinal_rx_uni = awgn(sinal_tx_uni,10^(EBN0/10)); 
    sinal_rx_bi = awgn(sinal_tx_bi,10^(EBN0/10));
    
    %SNR
    sinal_rx_uni2 = awgn(sinal_tx_uni,EBN0); 
    sinal_rx_bi2 = awgn(sinal_tx_bi,EBN0);
    
    % Adiciona ruido branco gaussiano no sinal com dada Eb/N0
    sinal_rx_uni_filt = filter(filtro_rx,1,sinal_rx_uni)/N;   
    sinal_rx_bi_filt = filter(filtro_rx,1,sinal_rx_bi)/N; 
    
    %SNR
    sinal_rx_uni_filt2 = filter(filtro_rx,1,sinal_rx_uni2)/N;   
    sinal_rx_bi_filt2 = filter(filtro_rx,1,sinal_rx_bi2)/N;  

    % Amostra o sinal para cada pulso iniciar no fim de cada bit
    Z_T_uni = sinal_rx_uni_filt(N:N:end);
    Z_T_bi = sinal_rx_bi_filt(N:N:end);
    
    %SNR
    Z_T_uni2 = sinal_rx_uni_filt2(N:N:end);
    Z_T_bi2 = sinal_rx_bi_filt2(N:N:end); 
    
    % Compara o sinal com limiar para transforma-lo em binario
    info_hat_uni = (Z_T_uni > limiar); 
    info_hat_bi = (Z_T_bi > limiar);
 
    %SNR
    info_hat_uni2 = (Z_T_uni2 > limiar); 
    info_hat_bi2 = (Z_T_bi2 > limiar);   
    
    % Probabilidade de erro do sinal Rx
    Pb1(EBN0+1) = qfunc(sqrt(10^(EBN0/10))); %unipolar
    Pb2(EBN0+1) = qfunc(sqrt(2*10^(EBN0/10))); %bipolar
 
    %SNR (pratica)
    Pb12(EBN0+1) = sum(xor(info_nrz_uni,info_hat_uni2))/length(info_hat_uni2); 
    Pb22(EBN0+1) = sum(xor(info_nrz_uni,info_hat_bi2))/length(info_hat_bi2);   
    
end

% Plotando os resultados
figure,

subplot(121),semilogy([0:Eb_N0],Pb1);
hold on,
semilogy([0:Eb_N0],Pb2);
ylim([10^-3 10^0]);
xlim([0 10]);
xlabel('Eb/N0');
ylabel('Probabilidade de erro (Pb)'); % Gráfico para verificar a função Q.
legend('Eb/N0 unipolar','Eb/N0 bipolar');
hold off;
title('(a)');

subplot(122),semilogy([0:Eb_N0],Pb12);
hold on,
xlim([0 10]);
semilogy([0:Eb_N0],Pb22);
ylim([10^-3 10^0]);
xlabel('SNR');
ylabel('Probabilidade de erro de bit (Pb)'); % Gráfico para verificar a função Q.
legend('SNR unipolar', 'SNR bipolar');
title('(b)');

% --- SISTEMAS DE COMUNICAÇÃO 1 ---
% Trabalho 5: Pulse Code Modulation
% DIA 29/05/2018
% Aluna: Jessica de Souza

% O arquivo captura_jessicasouza.wav foi gerado a partir do codigo
% desenvolvido em sala de aula: aula24.m

close all;
clear all;
clc;

% Extraindo caracteristicas do sinal
[y,Fs] = audioread('captura_jessicasouza2.wav');
info_audio = audioinfo('captura_jessicasouza2.wav');
t = 0:1/Fs:5-1/Fs;
k = 8;       % Bits de quantizacao: variar entre 3, 5, 8 e 13
L = 2^k;     % Niveis de quantizacao

% Quantizacao
y_up_pos = y+1;                 % Inserindo offset de 1v no audio
passo_delta = max(y_up_pos)/L;  % Volts por nivel
y_q = y_up_pos/passo_delta;     % Sinal quantizado

% Codificacao
y_dec = round(y_q);             % Transformando para decimal
y_bin = de2bi(y_dec);           % Transformando em binario para transmitir
[m,n] = size(y_bin);
y_dig = reshape(y_bin, 1, m*n); % Sinal em formato digital

% min(y_q)
% max(y_q)

% min(y_dec)
% max(y_dec)

%%
% Transmitindo em um canal agwn uzando NRZ polar e filtro casado
N = 10;
y_dig2 = (y_dig*2)-1;

% Gerando o filtro
filtro_tx = ones(1,N);              % Pulso de N amostras
filtro_rx = filtro_tx;
info_up = upsample(y_dig2,N);       % Insere N amostras a cada valor da informacao

% Passando o sinal pelo filtro
y_tx = filter(filtro_tx,1,info_up); % Este é o sinal transmitido
t2 = [0:5/length(y_tx):5-1/length(y_tx)];

%%
% Recepcao do sinal - Canal AWGN
SNR = 100; % Variar SNR entre: 0, 5 e 10 para 8 niveis (fixo). Para variar os niveis mantem SNR=100 
y_rx = awgn(y_tx,SNR);
y_rx_filt = filter(filtro_rx,1,y_rx)/N;
Z_t = y_rx_filt(N:N:end); % Pega o valor de bit no fim de cada pulso
y_fim = (Z_t > 0);

%%
% Decodificação e restauração do sinal recebido
y_dig_rx = reshape(y_fim, m, n);
y_int = bi2de(y_dig_rx);

y_int = y_int/L;      % Volta ao formato original
y_int = y_int - 1;    % Remove o offset
sound(y_int,Fs)
%%
% Plotando os resultados


% Sinal pronto para transmitir
figure,
subplot(411),plot(t,y); % Sinal Original
%ylim([-3.5 3.5]);
title('(a)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');

subplot(412),plot(t,y_q); % Sinal Quantizado
%ylim([-3.5 3.5]);
title('(b)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');

subplot(413),plot(t,y_dec); % Sinal Codificado Decimal
%ylim([-3.5 3.5]);
title('(c)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');

subplot(414),plot(t,y_int); % Sinal decodificado
ylim([-1.2 1.2]);
title('(d)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');



% Sinal NRZ transmitido e recebido
figure,
subplot(311),plot(t2,y_tx); % sinal TX
xlim([1.595 1.60]);
ylim([-1.2 1.2]);
title('(a)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');

subplot(312),plot(t2,y_rx); % sinal RX
xlim([1.595 1.60]);
ylim([-2 2]);
title('(b)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');

subplot(313),plot(t2,y_rx_filt); % sinal RX filtrado
xlim([1.595 1.60]);
ylim([-1.2 1.2]);
title('(c)');
xlabel('Tempo (s)');
ylabel('Amplitude(v)');
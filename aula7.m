% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 7: Modulacao em amplitude AM-DSB-SC
% DIA 05/03/2018
% Jessica de Souza

close all;
clear all;
clc;

%dados
N = 200;    % numero de amostras
f_m = 1e3;  %frequencia da informação
f_p = 10e3; %frequencia da portadora
fs = N*f_m; % frequencia de amostragem
ts = 1/fs;

t = [0:ts:1-ts];  %duracao de 1s
f = [-fs/2:fs/2-1];

%Criando os sinais no tempo
m_t = cos(2*pi*t*f_m); %sinal modulante
c_t = cos(2*pi*t*f_p); %sinal da portadora
s_t = m_t .* c_t;      %sinal modulado

%criando os sinais na frequencia
X_m = fftshift(fft(m_t)/length(m_t));
X_c = fftshift(fft(c_t)/length(c_t));
X_s = fftshift(fft(s_t)/length(s_t));

%plot dos sinais no tempo e na frequencia
figure,
subplot(321);
plot(t*1e3,m_t);
xlim([0 2]);
title('Sinal da informacao no tempo');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(322);
stem(f/1000,X_m);
xlim([-15 15]);
ylim([0 1]);
title('Sinal da informacao na frequencia');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(323);
plot(t*1e3,c_t);
xlim([0 2]);
title('Sinal da portadora no tempo');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(324);
stem(f/1000,X_c);
xlim([-15 15]);
ylim([0 1]);
title('Sinal da portadora na frequencia');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(325);
plot(t*1e3,s_t);
xlim([0 2]);
title('Sinal modulado no tempo');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(326);
stem(f/1000,X_s);
xlim([-15 15]);
ylim([0 1]);
title('Sinal modulado na frequencia');  %note a portadora suprimida
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

%%
%demodulando

%passo 1 = multiplica por c_t
s_dem = s_t.*c_t;  %para demodular multiplica pela envoltoria novamente

% passo 2 = filtragem passa baixa para detectar envoltoria 
filtro = fir1(50,(1500*2)/200e4);
m_t_filtrado = filter(filtro,1,s_dem);

figure,
subplot(211), plot(t*1e3,s_dem);
xlim([0 2]);
subplot(212), plot(t*1e3,m_t_filtrado);
xlim([0 2]);

% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 8: Modulacao em amplitude AM-DSB-TC
% DIA 06/03/2018
% Jessica de Souza

close all;
clear all;
clc;

%implementacao da equacao 6.13 no matlab

%utilizacao da modulacao am-dsb-tc

%m = Am/A0

% dados
A0 = 1;     % offset para evitar inversao de fase
Ac = 1;     % amplitude portadora
Am = [0.5 1 1.5];     % amplitude sinal modulante
N = 250;   % acima de 10e3 prova que M=1 não inverte fase
fm = 1e3;   % frequencia sinal modulante
fc = 10e3; % frequencia portadora

fs = N*fm;  %frequencia de amostragem respeitando Nyquist

t = [0:1/fs:1-(1/fs)];
f = [-fs/2:fs/2-1];

%criando os sinais no tempo

%M=0.5
m_t0 = Am(1).*cos(2*pi*fm.*t);
c_t0 = Ac.*cos(2*pi*fc.*t);
s_t0 = (A0 + m_t0).* c_t0;  % eq. 6.12 livro matlab pg 210

%M=1
m_t1 = Am(2).*cos(2*pi*fm.*t);
c_t1 = Ac.*cos(2*pi*fc.*t);
s_t1 = (A0 + m_t1).* c_t1;

%M=1.5
m_t2 = Am(3).*cos(2*pi*fm.*t);
c_t2 = Ac.*cos(2*pi*fc.*t);
s_t2 = (A0 + m_t2).* c_t2;

%transformando para o dominio da frequencia
X_s0 = fftshift(fft(s_t0)/length(s_t0));
X_s1 = fftshift(fft(s_t1)/length(s_t1));
X_s2 = fftshift(fft(s_t2)/length(s_t2));

%plot dos sinais no tempo e na frequencia
figure,
subplot(321);
plot(t,s_t0);
xlim([0 2/fm]);
title('Informacao no tempo, M=0.5');
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

subplot(322);
stem(f/1000,X_s0);
xlim([-12 12]);
ylim([0 0.6]);
title('Informacao na frequencia, M=0.5');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(323);
plot(t,s_t1);
xlim([0 2/fm]);
title('Informacao no tempo, M=1');
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

subplot(324);
stem(f/1000,X_s1);
xlim([-12 12]);
ylim([0 0.6]);
title('Informacao na frequencia, M=1');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(325);
plot(t,s_t2);
xlim([0 2/fm]);
title('Informacao no tempo, M=1.5');
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

subplot(326);
stem(f/1000,X_s2);
xlim([-12 12]);
ylim([0 0.6]);
title('Informacao na frequencia, M=1.5');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
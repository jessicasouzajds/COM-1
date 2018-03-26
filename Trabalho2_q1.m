% --- SISTEMAS DE COMUNICACOES 1 ---
% Trabalho 2: Modulacao AM
% DIA 13/03/2018
% Aluna: Jessica de Souza

% Questao 1 de 2
% Realizar um processo de modulação AM DSB(TC) e AM DSB-SC

clear all;
close all;
clc;

%% dados
A0 = 1;     % offset para evitar inversao de fase
Ac = 1;     % amplitude portadora
Am = [0.25 0.5 0.75 1 1.5];     % amplitude sinal modulante

N = 250;   % acima de 10e3 prova que M=1 nao inverte fase

fm = 1e3;   % frequencia sinal modulante
fc = 10e3; % frequencia portadora
fs = N*fm; % frequencia de amostragem
fr_corte = fc + 500; %frequencia de corte do filtro passa baixas

ts = 1/fs; %periodo de amostragem

t = [0:ts:1-ts];  %duracao de 1s
f = [-fs/2:fs/2-1];

%% Modulação AM DSB-SC

%Criando os sinais no tempo
m_t = cos(2*pi*t*fm); %sinal modulante
c_t = cos(2*pi*t*fc); %sinal da portadora
s_t = m_t .* c_t; %sinal modulado

%criando os sinais na frequencia
X_m = fftshift(fft(m_t)/length(m_t));
X_c = fftshift(fft(c_t)/length(c_t));
X_s = fftshift(fft(s_t)/length(s_t));

%plot dos sinais no tempo e na frequencia
figure,
subplot(321);
plot(t*1e3,m_t);
xlim([0 2]);
title('(a)');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(322);
stem(f/1000,X_m);
xlim([-15 15]);
ylim([0 1]);
title('(b)');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(323);
plot(t*1e3,c_t);
xlim([0 2]);
title('(c)');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(324);
stem(f/1000,X_c);
xlim([-15 15]);
ylim([0 1]);
title('(d)');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(325);
plot(t*1e3,s_t);
xlim([0 2]);
title('(e)');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(326);
stem(f/1000,X_s);
xlim([-15 15]);
ylim([0 1]);
title('(f)');  %note a portadora suprimida
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

%demodulando

%passo 1 = multiplica por c_t
s_dem = s_t.*c_t;  %para demodular multiplica pela envoltoria novamente

% passo 2N*fc = filtragem passa baixa para detectar envoltoria 
filtro = fir1(50,(fr_corte*2)/fs);
figure,
title('Filtro passa-baixas fc = 1,5 KHz');
freqz(filtro);

m_t_filtrado = filter(filtro,1,s_dem);
M_f_filtrado = fftshift(fft(m_t_filtrado)/length(m_t_filtrado));

figure,
subplot(311), plot(t*1e3,s_dem);
xlim([0 2]);
title('(a)');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)'); 

subplot(312), plot(t*1e3,m_t_filtrado);
xlim([0 2]);
title('(b)');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)'); 

subplot(313), plot(f/1e3,M_f_filtrado);
xlim([-5 5]);
title('(c)');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

%% Modulaçao AM DSB(TC)

%M=0.25
m_t0 = Am(1).*cos(2*pi*fm.*t);
c_t0 = Ac.*cos(2*pi*fc.*t);
s_t0 = (A0 + m_t0).* c_t0;  % eq. 6.12 livro matlab pg 210

%M=0.5
m_t1 = Am(2).*cos(2*pi*fm.*t);
c_t1 = Ac.*cos(2*pi*fc.*t);
s_t1 = (A0 + m_t1).* c_t1;

%M=0.75
m_t2 = Am(3).*cos(2*pi*fm.*t);
c_t2 = Ac.*cos(2*pi*fc.*t);
s_t2 = (A0 + m_t2).* c_t2;

%M=1
m_t3 = Am(4).*cos(2*pi*fm.*t);
c_t3 = Ac.*cos(2*pi*fc.*t);
s_t3 = (A0 + m_t3).* c_t3;

%M=1.5
m_t4 = Am(5).*cos(2*pi*fm.*t);
c_t4 = Ac.*cos(2*pi*fc.*t);
s_t4 = (A0 + m_t4).* c_t4;

X_s0 = fftshift(fft(s_t0)/length(s_t0));
X_s1 = fftshift(fft(s_t1)/length(s_t1));
X_s2 = fftshift(fft(s_t2)/length(s_t2));

%plot dos sinais no tempo
figure,
subplot(511);
plot(t*1000,s_t0);
xlim([0 2]);
title('(a)');
legend('M=0.25');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(512);
plot(t*1000,s_t1);
xlim([0 2]);
title('(b)');
legend('M=0.5');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(513);
plot(t*1e3,s_t2);
xlim([0 2]);
title('(c)');
legend('M=0.75');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(514);
plot(t*1e3,s_t3);
xlim([0 2]);
title('(d)');
legend('M=1');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

subplot(515);
plot(t*1e3,s_t4,'r');
xlim([0 2]);
title('(e)');
legend('M=1.5');
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');

%plot dos sinais na frequencia
figure,

subplot(311);
stem(f/1000,X_s0);
xlim([-12 12]);
ylim([0 0.6]);
title('Informacao na frequencia, M=0.25');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(312);
stem(f/1000,X_s1);
xlim([-12 12]);
ylim([0 0.6]);
title('Informacao na frequencia, M=0.5');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');

subplot(313);
stem(f/1000,X_s2);
xlim([-12 12]);
ylim([0 0.6]);
title('Informacao na frequencia, M=0.75');
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
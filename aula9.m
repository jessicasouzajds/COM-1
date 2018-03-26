% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 9: Modulacao em amplitude AM-SSB (banda lateral suprimida)
% DIA 08/03/2018
% Jessica de Souza

clear all;
close all;
clc;

%dados
Ac = 1;
Am = 1;
N = 100;
fm = 1e3;
fc = 10e3;

fs = N*fm;
ts = 1/fs;

t = [0:ts:1-ts];
f = [-fs/2:1:fs/2-ts];

%sinais no tempo
m = Am.*cos(2*pi*fm*t);  %sinal modulante
c = Ac.*cos(2*pi*fc*t);  %portadora
s = m.*c;                %sinal modulado (convolucao de m(t) com c(t)

%sinais na frequencia
M = fftshift(fft(m)/length(m));
C = fftshift(fft(c)/length(c));
S = fftshift(fft(s)/length(s));

%criando filtro passa-faixa com banda passante na faixa lateral superior
bpf = [zeros(1,38000) ones(1,2000) zeros(1,20000) ones(1,2000) zeros(1,38000)];
Sf = bpf.*S; %passando o sinal pelo filtro

%fazer novamente a convolucao com a portadora para ter o sinal original
sf = ifft(ifftshift(Sf))*length(Sf);
s_orig = sf.*c;
S_orig = fftshift(fft(s_orig)/length(s_orig));

%criando um filtro passa-baixas para resgatar o sinal original m(t) sem
%repeticoes nas outras frequencias
lpf = [zeros(1,48500) ones(1,3000) zeros(1,48500)];
Sm_t = lpf.*S_orig;

%%
figure,
subplot(121), plot(t*1e3,s);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
xlim([0 1]);
title('Sinal no tempo');

subplot(122), stem(f/1000,abs(S));
axis([-15 15 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('Sinal na frequencia');

figure, plot(f/1000,bpf);
axis([-15 15 0 2]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('Filtro passa faixa. fs1 = 10 KHz e fs2 = 12 KHz.');

figure,

subplot(411), stem(f/1000,abs(S));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('Sinal modulado');

subplot(412),stem(f/1000,abs(Sf));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('Sinal com filtro passa-faixa - banda superior');

subplot(413),stem(f/1000,abs(S_orig));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('Sinal multiplicado pela portadora - Demodulacao');

subplot(414),stem(f/1000,abs(Sm_t));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('Sinal com filtro passa-baixas - Resultado final');
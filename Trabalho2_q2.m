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
Ac = 1;
Am = 1;
N = 100;

fm1 = 1e3;
fm2 = 2e3;
fm3 = 3e3;

fc1 = 9e3;  %portadora alterada para banda superior em 10k
fc2 = 10e3; %portadora alterada para banda superior em 12k
fc3 = 11e3; %portadora alterada para banda superior em 14k

fs = N*fm1;
ts = 1/fs;

t = [0:ts:1-ts];
f = [-fs/2:1:fs/2-ts];

%sinais no tempo
m1 = Am.*cos(2*pi*fm1*t);  %sinal modulante
m2 = Am.*cos(2*pi*fm2*t);  %sinal modulante
m3 = Am.*cos(2*pi*fm3*t);  %sinal modulante

c1 = Ac.*cos(2*pi*fc1*t);  %portadora
c2 = Ac.*cos(2*pi*fc2*t);  %portadora
c3 = Ac.*cos(2*pi*fc3*t);  %portadora

s1 = m1.*c1;                %sinal modulado (convolucao de m(t) com c(t)
s2 = m2.*c2;                %sinal modulado (convolucao de m(t) com c(t)
s3 = m3.*c3;                %sinal modulado (convolucao de m(t) com c(t)

%sinais na frequencia
S1 = fftshift(fft(s1)/length(s1));
S2 = fftshift(fft(s2)/length(s2));
S3 = fftshift(fft(s3)/length(s3));

%criando filtro passa-faixa com banda passante na faixa lateral superior
bpf1 = [zeros(1,39000) ones(1,2000) zeros(1,18000) ones(1,2000) zeros(1,39000)];
bpf2 = [zeros(1,37000) ones(1,2000) zeros(1,22000) ones(1,2000) zeros(1,37000)];
bpf3 = [zeros(1,35000) ones(1,2000) zeros(1,26000) ones(1,2000) zeros(1,35000)];


Sf1 = bpf1.*S1; %passando o sinal 1 pelo filtro
Sf2 = bpf2.*S2; %passando o sinal 2 pelo filtro
Sf3 = bpf3.*S3; %passando o sinal 3 pelo filtro

%fazer novamente a convolucao com a portadora para ter o sinal original
sf1 = ifft(ifftshift(Sf1))*length(Sf1);
s_orig1 = sf1.*c1;
S_orig1 = fftshift(fft(s_orig1)/length(s_orig1));

sf2 = ifft(ifftshift(Sf2))*length(Sf2);
s_orig2 = sf2.*c2;
S_orig2 = fftshift(fft(s_orig2)/length(s_orig2));

sf3 = ifft(ifftshift(Sf3))*length(Sf3);
s_orig3 = sf3.*c3;
S_orig3 = fftshift(fft(s_orig3)/length(s_orig3));

%criando um filtro passa-baixas para resgatar o sinal original m(t) sem
%repeticoes nas outras frequencias
lpf1 = [zeros(1,48500) ones(1,3000) zeros(1,48500)];

%criando filtro passa faixa para resgatar os sinais originais
lpf2 = [zeros(1,46500) ones(1,2000) zeros(1,3000) ones(1,2000) zeros(1,46500)];
lpf3 = [zeros(1,45500) ones(1,2000) zeros(1,5000) ones(1,2000) zeros(1,45500)];

Sm_t1 = lpf1.*S_orig1;
Sm_t2 = lpf2.*S_orig2;
Sm_t3 = lpf3.*S_orig3;

%%
figure,
subplot(321), plot(t*1e3,s1);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
xlim([0 1]);
title('(a)');

subplot(322), stem(f/1000,abs(S1));
axis([-15 15 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(323), plot(t*1e3,s2);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
xlim([0 1]);
title('(c)');

subplot(324), stem(f/1000,abs(S2));
axis([-15 15 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(d)');

subplot(325), plot(t*1e3,s3);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
xlim([0 1]);
title('(e)');

subplot(326), stem(f/1000,abs(S3));
axis([-15 15 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(f)');


figure,
subplot(311), plot(f/1000,bpf1);
axis([-16 16 0 2]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(a)');

subplot(312), plot(f/1000,bpf2);
axis([-16 16 0 2]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(313), plot(f/1000,bpf3);
axis([-16 16 0 2]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(c)');


figure,
subplot(411), stem(f/1000,abs(S1));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
%title('Sinal modulado');
title('(a)');

subplot(412),stem(f/1000,abs(Sf1));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
%title('Sinal com filtro passa-faixa - banda superior');
title('(b)');

subplot(413),stem(f/1000,abs(S_orig1));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
%title('Sinal multiplicado pela portadora - Demodulacao');
title('(c)');

subplot(414),stem(f/1000,abs(Sm_t1));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
%title('Sinal com filtro passa-baixas - Resultado final');
title('(d)');

figure,
subplot(411), stem(f/1000,abs(S2));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(a)');

subplot(412),stem(f/1000,abs(Sf2));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(413),stem(f/1000,abs(S_orig2));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(c)');

subplot(414),stem(f/1000,abs(Sm_t2));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(d)');


figure,
subplot(411), stem(f/1000,abs(S3));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(a)');

subplot(412),stem(f/1000,abs(Sf3));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(413),stem(f/1000,abs(S_orig3));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(c)');

subplot(414),stem(f/1000,abs(Sm_t3));
axis([-25 25 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(d)');

figure,
stem(f/1000,abs(Sf1));
hold on;
stem(f/1000,abs(Sf2),'r');
stem(f/1000,abs(Sf3),'k');
hold off;
axis([-16 16 0 0.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
%title('(b)');
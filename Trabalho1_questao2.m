% --- SISTEMAS DE COMUNICACOES 1 ---
% Trabalho 1: Revisao de sinais de espectro
% DIA 08/03/2018
% Aluna: Jessica de Souza

% Questao 2 de 3

clear all;
close all;
clc;

%parametros iniciais
N = 10; %Numero de amostras
f1 = 1e3;
f2 = 3e3;
f3 = 5e3;
a1 = 5;
a2 = 5/3;
a3 = 1;

fa = N*f3;
ta = 1/fa;
t = [0:ta:(N*(1/f3))-ta];
f = [-fa/2:1/(N*(1/f3)):fa/2-1]; 

%Gerar um sinal s(t) composto pela somatória de 3 senos com amplitudes
%de 5V, 5/3V e 1V e frequências de 1, 3 e 5 kHz, respectivamente.

x1 = a1*sin(2*pi*f1*t);
x2 = a2*sin(2*pi*f2*t);
x3 = a3*sin(2*pi*f3*t);
s = x1 + x2 + x3;

X1 = fftshift(fft(x1)/length(x1));
X2 = fftshift(fft(x2)/length(x2));
X3 = fftshift(fft(x3)/length(x3));
S = fftshift(fft(s)/length(s));  %%dividir por length de s muda a amplitude para a escala original

%Plotar em uma figura os três cossenos e o sinal 's ' no domínio do tempo e
%da frequência

figure,
subplot(421);
plot(1e3*t,x1);
axis([0 2 -a1-1 a1+1]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(a)');

subplot(422);
stem(f/1000,abs(X1));
axis([0 6 0 (a1/2)+1]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(423);
plot(t*1e3,x2);
axis([0 2 -a2-1 a2+1]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(c)');

subplot(424);
stem(f/1000,abs(X2));
axis([0 6 0 (a2/2)+1]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(d)');

subplot(425);
plot(t*1e3,x3);
axis([0 2 -a3-1 a3+1]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(e)');

subplot(426);
stem(f/1000,abs(X3));
axis([0 6 0 (a3/2)+1]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(f)');

subplot(427);
plot(t*1e3,s);
axis([0 2 -a3-a2-a1 a3+a2+a1]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(g)');

subplot(428);
stem(f/1000,abs(S));
axis([0 6 0 1+(a1/2)]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(h)');

%Gerar 3 filtros ideais: 1 - Passa baixa (frequência de corte em 2kHz);
%2 - Passa alta (banda de passagem acima de 4kHz)
%3 - Passa faixa (banda de passagem entre 2 e 4kHz)

%1 - filtro pb
filt1 = [zeros(1,46) ones(1, 8) zeros(1,46)];

%2 - filtro pa
filt2 = [ones(1,42) zeros(1,16) ones(1,42)];

%3 - filtro pf
filt3 = [zeros(1,42) ones(1, 4) zeros(1,8) ones(1,4) zeros(1,42)];

%Plotar em uma figura a resposta em frequência dos 3 filtros
figure,
subplot(311), plot(f/1000,filt1);
axis([-6 6 0 1.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(a)');

subplot(312), plot(f/1000,filt2);
axis([-6 6 0 1.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(313), plot(f/1000,filt3);
axis([-6 6 0 1.5]);
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(c)');

%Passar o sinal s(t) através dos 3 filtros e plotar as saídas, no domínio do
%tempo e da frequência, para os 3 casos

SIG1 = filt1.*S;
SIG2 = filt2.*S;
SIG3 = filt3.*S;

sig1 = ifft(ifftshift(SIG1))*length(SIG1);
sig3 = ifft(ifftshift(SIG3))*length(SIG3);
sig2 = ifft(ifftshift(SIG2))*length(SIG2);

figure,

subplot(321),plot(t*1e3,sig1);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
axis([0 2 -a1-1 a1+1]);
title('(a)');

subplot(322),stem(f/1e3,abs(SIG1));
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
axis([0 6 0 (a1/2)+1]);
title('(b)');

subplot(323),plot(t*1e3,sig3);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
axis([0 2 -a3-1 a3+1]);
title('(c)');

subplot(324),stem(f/1e3,abs(SIG3));
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
axis([0 6 0 (a2/2)+1]);
title('(d)');

subplot(325),plot(t*1e3,sig2);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
axis([0 2 -a2-0.5 a2+0.5]);
title('(e)');

subplot(326),stem(f/1e3,abs(SIG2));
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
axis([0 6 0 (a3/2)+1]);
title('(f)');

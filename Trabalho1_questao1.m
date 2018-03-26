% --- SISTEMAS DE COMUNICACOES 1 ---
% Trabalho 1: Revisao de sinais de espectro
% DIA 08/03/2018
% Aluna: Jessica de Souza

% Questao 1 de 3

clear all;
close all;
clc;

%parametros iniciais
N = 500;  %Numero de amostras
f1 = 1e3;
f2 = 3e3;
f3 = 5e3;
a1 = 6;
a2 = 2;
a3 = 4;

fa = N*f3;
ta = 1/fa;
t = [0:ta:(N*(1/f3))-ta];
f = [-fa/2:1/(N*(1/f3)):fa/2-1]; 

%Gerar um sinal s(t) composto pela somatória de 3 senos com
%amplitudes de 6V, 2V e 4V e frequências de 1, 3 e 5 kHz,
%respectivamente.

x1 = a1*sin(2*pi*f1*t);
x2 = a2*sin(2*pi*f2*t);
x3 = a3*sin(2*pi*f3*t);
s = x1 + x2 + x3;

X1 = fftshift(fft(x1)/length(x1));
X2 = fftshift(fft(x2)/length(x2));
X3 = fftshift(fft(x3)/length(x3));
S = fftshift(fft(s)/length(s));  %%dividir por length de s muda a amplitude para a escala original

%Plotar em uma figura os três senos e o sinal 's ' no domínio do
%tempo e da frequência.

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

%Utilizando a função 'norm', determine a potência média do sinal 's'.

P_s = norm(s);
Potencia = P_s*P_s/(length(s))  %potencia do sinal s eh o quadrado da norm
%var(s), que é a variancia, contem o mesmo resultado para potencia


%Utilizando a função 'pwelch', plote a Densidade Espectral de
%Potência do sinal 's'.
figure,
[a,b] = pwelch(s,[],[],[],fa);
plot(b/1000,5*log10(a));
xlim([0 20]);
xlabel('Frequência (KHz)');
ylabel('Densidade Espectral de Potência (dB/Hz)');
% --- SISTEMAS DE COMUNICACOES 1 ---
% Trabalho 1: Revisao de sinais de espectro
% DIA 08/03/2018
% Aluna: Jessica de Souza

% Questao 3 de 3


clear all;
close all;
clc;

%Gerar um vetor representando um ruido com distribuicao normal utilizando 
%a funcao 'randn' do matlab. Gere 1 segundo de ruido considerando um tempo 
%de amostragem de 1/10k.

ta = 1/10e3;
fa = 1/ta;
t = [0:ta:1-ta];
f = [-fa/2:1:fa/2-ta];

a = randn(size(t));  %vetor gaussiano

%Plotar o histograma do ruido para observar a distribuicao
%Gaussiana. Utilizar a funcao 'histogram'
figure,histogram(a,100);

%Plotar o ruido no domínio do tempo e da frequencia
A = fftshift(fft(a)/length(a));

%Utilizando a funcao 'xcorr', plote a funcao de autocorrelacao
%do ruido.

Ac = xcorr(A,length(A)/2);
Ac = Ac(1:length(Ac)-1);

figure,
subplot(311),plot(t,a);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('(a)');

subplot(312),plot(f/1e3,abs(A));
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(313),plot(f/1e3,abs(Ac));
xlabel('Frequência (KHz)');
ylabel('Autocorrelação');
title('(c)');

%Utilizando a funcao 'filtro=fir1(50,(1000*2)/fs)', realize uma operacao 
%de filtragem passa baixa do ruido. Para visualizar a resposta em 
%frequencia do filtro projetado, utilize a funcao 'freqz'.

filtro=fir1(50,(1000*2)/fa);

%a resposta em frequencia do filtro
figure, freqz(filtro);

af = filter(filtro,1,a);
Af = fftshift(fft(af)/length(af));

%comparativo do sinal original com o filtrado
figure, 
hold on;
plot(t,a);
plot(t,af);
legend('Ruido puro','Ruido apos Filtro PB')
hold off;

%Plote, no dominio do tempo e da frequencia, a saida do filtro
%e o histograma do sinal filtrado

figure, 
subplot(211),plot(t,af);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('(a)');

subplot(212),plot(f/1e3,abs(Af));
xlabel('Frequência (KHz)');
ylabel('Amplitude (V)');
title('(b)');
xlim([-2 2]);

%histograma final
figure, histogram(af,100);
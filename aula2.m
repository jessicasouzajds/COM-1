% --- SISTEMAS DE COMUNICACOES 1 ---
% AULA 2: Revisao de sinais e sistemas
% DIA 15/02/2018
% Jessica de Souza

% EX2 - plotando tres cossenos e somando na frequencia 
% Exemplo do livro SDR, pg 176 - "Sum of three tones’ signal in the Complex
% Frequency Domain"

%%
clc;
clear all;
close all;

% Especificacoes
f1 = 100;                       % Frequencia do sinal
f2 = 200;
f3 = 300;
N = 20;                        % Numero de amostras (periodos)
fa = N*f3;                      % Frequencia de amostragem, sempre respeitar fa minimo de 2*f
t = [0:1/fa:(N*(1/f3))-(1/fa)]; % Como criar um vetor de tempo com mesmo tamanho de vetor

%% 
% Funcao
x = 10*cos(2*pi*f1*t) + cos(2*pi*f2*t) + 4*cos(2*pi*f3*t);
figure(1), plot(t,x);
xlabel('Tempo (s)');
ylabel('Amplitude');
ylabel('Amplitude');
title(['Funcao cosseno: F = ',num2str(f3), ' Hz e N = ',num2str(N), ' amostras.']);

%%
% Fazendo a fft do cosseno

% OBS: a funcao fft() usa como variacao de freq. de 0 ate fa.
f_fft = [0:1/(N*(1/f3)):fa-1]; % Vetor de frequencia
X = fft(x)*(1/length(x));
figure(2), plot(f_fft,abs(X));
xlim([0 fa]);
xlabel('Frequencia (Hz)');
ylabel('Amplitude');
title('Fft() -  Funcao cosseno');

%%
% Fazendo o shift da fft do cosseno

%OBS: como a funcao fft() faz a transformada deslocada ate fa, deve-se utilizar o fftshift() 
% para colocar na frequencia correta a fft do cosseno, de -fa/2 ate fa/2.
f_fftshift = [-fa/2:1/(N*(1/f3)):fa/2-1]; % Vetor de frequencia no tempo correto
X_2 = fftshift(X);
figure(3), plot(f_fftshift,abs(X_2));
xlim([-2*f3 2*f3]);
xlabel('Frequencia (Hz)');
ylabel('Amplitude');
title('Fftshift() -  Deslocamento da funcao cosseno');
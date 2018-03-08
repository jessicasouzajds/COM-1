% --- SISTEMAS DE COMUNICACOES 1 ---
% AULA 1: Revisao de sinais e sistemas
% DIA 15/02/2018 
% Jessica de Souza

% EX1 - plotando uma onda cosseno 

clc;
clear all;
close all;

% Especificacoes
f = 1e3;                       % Frequencia do sinal
N = 20;                        % Numero de amostras (periodos)
fa = N*f;                      % Frequencia de amostragem, sempre respeitar fa minimo de 2*f
t = [0:1/fa:(N*(1/f))-(1/fa)]; % Como criar um vetor de tempo com mesmo tamanho de vetor

%% 
% Funcao cosseno
x = cos(2*pi*f*t);
figure(1), plot(t,x);
xlabel('Tempo (s)');
ylabel('Amplitude');
ylabel('Amplitude');
title(['Funcao cosseno: F = ',num2str(f), ' Hz e N = ',num2str(N), ' amostras.']);

%%
% Fazendo a fft do cosseno

% OBS: a funcao fft() usa como variacao de freq. de 0 ate fa.
f_fft = [0:1/(20e-3):fa-1]; % Vetor de frequencia
X = fft(x);
figure(2), plot(f_fft,abs(X));
xlim([0 fa]);
xlabel('Frequencia (Hz)');
ylabel('Amplitude');
title('Fft() -  Funcao cosseno');

%%
% Fazendo o shift da fft do cosseno

%OBS: como a funcao fft() faz a transformada deslocada ate fa, deve-se utilizar o fftshift() 
% para colocar na frequencia correta a fft do cosseno, de -fa/2 ate fa/2.
f_fftshift = [-fa/2:1/(20e-3):fa/2-1]; % Vetor de frequencia no tempo correto
X_2 = fftshift(X);
figure(3), plot(f_fftshift,abs(X_2));
xlim([-2*f 2*f]);
xlabel('Frequencia (Hz)');
ylabel('Amplitude');
title('Fftshift() -  Deslocamento da funcao cosseno');

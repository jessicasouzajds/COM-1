
% --- SISTEMAS DE COMUNICAÇÃO 1 ---
% AULA 4: Revisao de sinais e sistemas
% DIA 22/02/2018
% Jessica de Souza

clear all;
close all;

%criacao de ruido branco com variancias de 0.1, 1 e 10
%as variancias determinam a largura da gaussiana e a potencia do sinal

x1 = randn(1,1000000) * 0.1;  %se somar muda a media,desloca o sinal... multiplicar muda a variancia
x2 = randn(1,1000000) * 1;
x3 = randn(1,1000000) * 10;

X1 = fft(x1);
X2 = fft(x2);
X3 = fft(x3);

figure,
subplot(321),hist(x1,100);
title('Distribuicao do ruido branco');
subplot(322),plot(abs(X1));
title('Potencia do ruido');
subplot(323),hist(x2,100);
subplot(324),plot(abs(X2));
subplot(325),hist(x3,100);
subplot(326),plot(abs(X3));

%criando um sinal retangular e somando um ruido
var_s = 0.05;                     %variancia (potencia) do ruido no sinal
info = [0 1 1 0];                 %o sinal é um degrau
info_f = rectpulse(info,20);      %cria um rect com 20 amostras de cada valor
sig_r = info_f + var_s*randn(1,80); %soma ruido com sinal


figure,
subplot(211),plot(info_f);
axis([0 80 -1 2]);
title('Sinal limpo');
subplot(212),plot(sig_r);
axis([0 80 -1 2]);
title('Sinal + ruido');

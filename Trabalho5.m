% --- SISTEMAS DE COMUNICAÇÃO 1 ---
% Trabalho 5: Pulse Code Modulation
% DIA 29/05/2018
% Aluna: Jessica de Souza

% O arquivo captura_jessicasouza.wav foi gerado a partir do codigo
% desenvolvido em sala de aula: aula24.m

[y,Fs] = audioread('captura_jessicasouza.wav');
%extraindo as informaçoes do audio
info_audio = audioinfo('captura_jessicahahn.wav');
t = 0:seconds(1/Fs):seconds(info_audio.Duration);
t = t(1:end-1);

%ouvindo
sound(y,Fs)
figure();
subplot(211);
plot(t,y);


%%
% Resumo do que é para fazer:

% fs = 44100 (placa de som)
% apos a placa de som, vai p matlab
% escala de audio de -1 ate 1V
% voz, vetor de 1 ate 220500 (5*fs)
% plot(voz,t)
% depois faz a quantizacao
% fazer utilizando 3, 5 e 8 bits para k  (deixar generico para alterar estes valores na entrada)
% 
% quantizar para 3 niveis = L=2^3=8 niveis
% primeiro desloca o sinal de 0 ate 2 -> voz=voz+1
% calcular o passo delta = Amax/Niveis = 2/8 = 0.25V por nivel
% voz = voz/delta
% arredonda os valores para inteiro utilizando o round
% round(voz)
% depois vai para a codificacao
% utiliza a funcao de2bi(voz) e o sinal esta pronto para transmitir e fazer o reshape
% 
% utiliza NRZ com fator N=10
% transmite AWGN, recebe e faz o processo de conversao D/A
% mantem a SNR constante entre 0,5 e 10 (e 100 limpa) (generico) e usa apenas 8 niveis de quantizacao
% ouvir e diferenciar os efeitos da variazao de SNR
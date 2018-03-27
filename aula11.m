% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 11: Conversão analógico digital
% DIA 20/03/2018
% Jessica de Souza

clear all;
close all;
clc;

%dados
f1 = 1e3;
fa = 100e3;
ta = 1/fa;
t = 0:ta:(2e-3)-ta;
f = -fa/2:f1/2:fa/2-ta;
passo_quant = 2/8;              %determina num. de niveis do sistema

%%
%dado a transmitir:

%a informacao
info_tx = 0.75*sin(2*pi*f1*t);                    %informacao original
info_tx = info_tx+1;                             %da 1v de offset na informacao

%quantizacao
info_quant = info_tx/passo_quant;                %adequa a informacao ao num. de niveis
info_quant_round = round(info_quant);            %deixa a info com valor inteiro

%codificacao
info_bin = de2bi(info_quant_round);              %transforma para binario
info_bin = transpose(info_bin);                  %inverte linha por coluna
[linha,coluna] = size(info_bin);                 %pega o tamanho para reshape

%dado pronto para transmissao
info_bin_tx = reshape(info_bin,1, linha*coluna); %reshape(dado,num. linha, num. colunas);


%%
%recuperando o sinal recebido

info_bin_rx = reshape(info_bin_tx, linha, coluna); %vetorizando para o formato original
info_bin_rx = info_bin_rx';                        %invertendo o vetor
info_rx_dec = bi2de(info_bin_rx);                  %transformando para decimal
info_rx1 = info_rx_dec*passo_quant;                %removendo os níveis
info_rx = info_rx1 -1;                             %removendo o offset


%filtrando para remover os degraus dos niveis
filtro = fir1(50,(2*1500)/100e3);
info_rx_filt = filter(filtro,1,info_rx);

%analise no dominio da frequencia
espectro_rx = fft(info_rx);
espectro_rxf = fftshift(espectro_rx);

espectro_rx2 = fft(info_rx_filt);
espectro_rxf2 = fftshift(espectro_rx2);

%%
figure,
subplot(311),plot(t, info_tx);
title('Informação original');
subplot(312),plot(t,info_quant);
title('Informação Quantizada para 8 niveis');
subplot(313),plot(t,info_quant_round);
title('Informação Arrendondada para 8 niveis');

figure,
subplot(311),plot(info_rx_dec);
title('Informação Recebida com Niveis');
subplot(312), plot(t,info_rx);
title('Informação Recuperada');
subplot(313), plot(t,info_rx_filt);
title('Informação Recuperada com Filtro Passa Baixa');

figure,
subplot(211), stem(f,abs(espectro_rxf));
title('Espectro da informacao sem filtro');
xlim([-20000 20000]);

subplot(212), stem(f,abs(espectro_rxf2));
title('Espectro da informacao com filtro');
xlim([-20000 20000]);
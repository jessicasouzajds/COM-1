% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 14: Transmissao Digital - Parte 2
% DIA 29/03/2018
% Jessica de Souza

%Considere três sinais com os seguintes casos: 
%1o - sinal NRZ de 2 niveis (polar)
%2o - sinal RZ binario
%3o - sinal NRZ de 4 niveis (bipolar)

clear all;
close all;
clc;

%%
% Caso 1 - NRZ polar

% Dados
Rb = 10e3;   % taxa de transmissao de bit
fs = 200e3;  % frequencia de amostragem
N = 20;      % fator de superamostragem
t = [0:1/fs:1-1/fs];
f = [-fs/2:fs/2-1];

% Gerando a informação
%NO MATLAB: info = randint(1,Rb); % dois niveis de -1 ate 1
%NO MATLAB: info = (info*2)-1;

%NO OCTAVE:
info = ((randi(2,1, Rb)-1)*2)-1;

% Gerando o filtro
filtro_tx = ones(1,N);      % pulso de 20 amostras
info_up = upsample(info,N); % insere 20 pontos a cada valor da informação original

% Passando o sinal pelo filtro
sinal_tx = filter(filtro_tx,1,info_up);  % no tempo
sinal_TX =  fftshift(fft(sinal_tx));     % na frequencia

% Plotando os resultados
figure,
subplot(211),plot(t,sinal_tx);
xlim([0 20*N*1/fs]);
title('NRZ Polar no tempo');
subplot(212),plot(f,abs(sinal_TX));
title('NRZ Polar na frequencia');

%%
% Caso 2 - Codificação  RZ simples

clear all;
close all;
clc;

% Dados
Rb = 10e3;   % taxa de transissao de bit
fs = 200e3;  % frequencia de amostragem
N = 20;      % fator de superamostragem
t = [0:1/fs:1-1/fs];
f = [-fs/2:fs/2-1];

% Gerando a informacao
%NO MATLAB: info = randint(1,Rb,2); % dois niveis de 0 ate 1
%NO OCTAVE:
info = (randi(2,1,Rb)-1;

% Gerando o filtro
filtro_tx = ones(1,N);      % pulso de 20 amostras
info_up = upsample(info,N); % insere 20 amostras a cada valor da info

% Passando o sinal pelo filtro
sinal_tx = filter(filtro_tx,1,info_up);
sinal_TX =  fftshift(fft(sinal_tx));

% Plotando os resultados
figure,
subplot(211),plot(t,sinal_tx);
xlim([0 20*N*1/fs]);
title('Codificacao Simples RZ no tempo');
subplot(212),plot(f,abs(sinal_TX));
title('Codificacao Simples RZ na frequencia');

%%
% Caso 3 - Codificação NRZ bipolar

clear all;
close all;
clc;

% Dados
Rs = 5e3;   % taxa de transmissao de amostras
fs = 200e3; % frequencia de amostragem
N = 100;     % fator de superamostragem
t = [0:1/fs:1-1/fs];
f = [-fs/2:fs/2-1];

% Gerando a informacao
%NO MATLAB: info = randi(1,Rs,4); % 4 niveis
%NO MATLAB: info = (info*2)-3;
%NO OCTAVE:
info = (randi(4,1,Rs)-1)*2;
info = info-3;

% Criando o filtro
filtro_format = ones(1,N);   % um pulso de tamanho N
info_up = upsample(info,N);  % superamostrando o sinal em N

% Filtrando o sinal
sinal_tx = filter(filtro_format,1,info_up);
sinal_TX = fftshift(fft(sinal_tx));

% Plotando os resultados
figure,plot(sinal_filter);
ylim([-3.5 3.5]);
title('Sinalizacao NRZ bipolar no tempo');
figure,plot(abs(SX));
title('Sinalizacao NRZ bipolar na frequencia');
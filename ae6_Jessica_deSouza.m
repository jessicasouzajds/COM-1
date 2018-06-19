% --- SISTEMAS DE COMUNICAÇÃO 1 ---
% Trabalho 6: Modulação BPSK
% DIA 18/06/2018
% Aluna: Jessica de Souza

% Projetar um sistema de comunicação digital utilizando a modulação BFSK
% com detecção não coerente e detectores de envoltória

close all;
clear all;
clc;

%%
% DESENVOLVIMENTO
    % Dados
    A = 1;          % Amplitude do sinal
    Rb = 1e3;       % Taxa de tx de bit
    Tb = 1/Rb;      % Periodo de bit
    N = 80;         % Fator de superamostragem
    SNR = 15;       % SNR do canal AWGN
    limiar = A/2;   % Limiar de decisão para reconstrução do sinal
    
    Ts = 1/(N*Rb);  % Periodo de superamostragem
    f_p = 12e3;     % Frequencia da portadora
    f_s = 1/Ts;     % Frequencia de amostragem
    t = [0:Ts:1-Ts]; 

    % Gerando a informação
    info = randi([0 1],1,Rb);   
    info = info*A;

    % Criando o filtro que irá formatar a informação
    filtro_nrz = ones(1,N);
    info_up = upsample(info,N);

    % Formatando o sinal para transmitir
    sinal_nrz = filter(filtro_nrz, 1, info_up);

    % Passando o sinal pela portadora
    f_fsk1 = (sinal_nrz*f_p)+f_p;   % O bit 0 possui fr=f_p e o bit 1, fr=2*f_p
    sinal_tx = cos(2*pi*t.*f_fsk1);

    % Sinal recebido
    sinal_rx = awgn(sinal_tx,SNR); % Ruido no receptor

    % Filtrando o sinal recebido
    % Lembrando que: O bit 0 possui fr=f_p e o bit 1, fr=2*f_p
    % Optou-se diminuir as frequencias de corte superiores e inferiores,
    % bem como a ordem do filtro para reduzir o atraso causado pelo filtro
    banda = ([f_p-300 f_p+300])/(f_s/2);
    gama1 = fir1(50,banda);    % Bit 0
    gama2 = fir1(50,banda*2);  % Bit 1

    sinal_rx_filt0 = filter(gama1,1,sinal_rx);
    sinal_rx_filt1 = filter(gama2,1,sinal_rx);

    % Após realizar a filtragem, retificar o sinal devido a detecção não coerente
    sinal_abs0 = abs(sinal_rx_filt0);
    sinal_abs1 = abs(sinal_rx_filt1);
    
    % Filtragem passa baixa final, para detectar envoltoria 
    [b,a] = butter(8,13000/(f_s/2)); % Filtro Butterworth de ordem 8
    m_t_filtrado = filter(b,a,sinal_abs1);

    % Reconstruindo o sinal NRZ no receptor
    info_hat = (m_t_filtrado > limiar);
    
%%
% PLOTANDO OS RESULTADOS
    %Informação no formato NRZ
    figure,plot(t,sinal_nrz);
    axis([0 0.01 -0.5 1.5]);
    title('Informação no formato NRZ');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)');
    
    % Informação transmitida
    figure,plot(t,sinal_tx);
    axis([0 0.01 -1.5 1.5]);
    title('Informação transmitida');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)');
    
    % Informação recebida
    figure,plot(t,sinal_rx);
    axis([0 0.01 -1.5 1.5]);
    title('Informação recebida');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)'); 
    
    % Sinal após filtro
    figure,plot(t,sinal_rx_filt1);
    axis([0 0.01 -1.5 1.5]);
    title('Informação recebida e filtrada');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)');
    
    % Sinal após retificação
    figure,plot(t,sinal_abs1);
    axis([0 0.01 -0.5 1.5]);
    title('Informação filtrada e retificada');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)');
    
    % Sinal após filtragem passa baixa
    figure,plot(t,m_t_filtrado);
    axis([0 0.01 -0.5 1.5]);
    title('Informação com filtro passa baixas');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)');
 
    % Sinal NRZ no receptor
    figure,plot(t,info_hat);
    axis([0 0.01 -0.5 1.5]);
    title('Informação reconstruída no receptor');
    xlabel('Tempo (s)');
    ylabel('Amplitude(v)');
  
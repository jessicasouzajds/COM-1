% --- SISTEMAS DE COMUNICACAO 1 ---
% AULA 24: Modulacao PCM
% DIA 08/05/2018
% Jessica de Souza

% Exemplos uteis: https://www.mathworks.com/help/daq/examples.html

% inicia a toolbox data acquisition
if (~isempty(daqfind))
    stop(daqfind)
end

% parametros do sinal gerado
som = analoginput('winsound');
addchannel(som, 1);
som.SampleRate = 8000;
som.SamplesPerTrigger = 40000;
som.TriggerType = 'Immediate';
inicia = 1
%pause(5)  %pausa para gravar 5 segundos
start(som)
[d,t] = getdata(som);  %obtem o dado e o tempo

plot(t,d);
stop(som);
delete(som);

% ouve o som original
sound(d, 8000)

% insere 1v de offset
d = d+1;
plot(t,d)
voz_q = d/0.25; % quantiza em 4 niveis de quantizacao
voz_int = round(voz_q); % arredonda para deixar os valores em decimal

min(voz_int)
max(voz_int)

% codificacao do sinal
voz_bin = de2bi(voz_int);  % transforma para binario
voz_dig = reshape(voz_bin, 1, 40000*3);  %**executar aqui para ver o tamanho do reshape 40000*3=lin*col?

size(voz_dig)
size(voz_bin)

% recebendo sinal codificado
voz_dig_rx = reshape(voz_dig, 40000, 3);
voz_int = bi2de(voz_dig_rx);

max(voz_int)
min(voz_int)

voz_int = voz_int * 0.25; % volta ao formato original
voz_int = voz_int - 1;    % remove o offset

plot(t,voz_int);  % verifica a forma de onda do sinal recebido
sound(voz_int, 8000);  % verifica se o som é semelhante
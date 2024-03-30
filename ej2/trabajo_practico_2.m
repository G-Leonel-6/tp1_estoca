clear all
clc

%ejercicio 1
% a) segmentacion del audio

[data, fs] = audioread('../Archivos/audio_02_2024a.wav');
data_norm = data / (rms(data));

data_norm = transpose(data_norm);

L = 1323;
j = 0; %necesario si queremos dividir los 0

while mod(length(data_norm), L) ~= 0
  j = j+1;
  if mod(j,2) ~= 0
    data_norm = [0 data_norm];
  else
   data_norm = [data_norm 0];
  end
end

columnas = length(data_norm) / L;

for i = 1:L
  x_m(i,:) = data_norm((i-1)*columnas+1:i*columnas);
end


% c) matriz de covarianza 

%matriz de covarianzas
Cx = cov(x_m');

%autovalores y autovectores

[avec, avas] = eig(Cx);

%Definicion de matriz Y

y_m = avec' * x_m;

Cy = cov(y_m');

%% por alguna razon, cada fila 
%tiene un numero que se repite en toda la fila

CR = 70;

K = floor((1 - (CR/100))*L); %cantidad de maximos deseados

%K = 10; %K de prueba

for i = 1:length(avas(1,:))
  avaVector(i) = avas(i,i);
end

for i = 1:K
  [avaMax(i),indMax(i)] = max(avaVector);
  avaVector(indMax(i)) = 0;
  matrizKAsoc(i,:) = avec(indMax(i),:);
  matrizK(i,i) = avaMax(i);
end
%Obtengo los indices de los K maximos con ellos armo
%la matriz diagonal K, cuyos elementos de la diagonal
%son los avas de Cx ordenados de mayor a menor y
%una matriz asociada a K, cuyos vectores columnas
%son los avec asociados a cada ava de K (en orden)
clear all
%ejercicio 1
% a) segmentacion del audio

[data, fs] = audioread('audio_01_2024a.wav');
data_norm = data / (rms(data));
data_norm = transpose(data_norm);
% adquisicion de recurso, normalizacion y
% transpone para trabajar con filas

L = 2;

while mod(length(data_norm), L) != 0
  data_norm = [0 data_norm];
endwhile

columnas = length(data_norm) / L;

% añade 0s al inicio de la señal hasta que
% sea divisible por L y se define el ancho
% de los vectores

for i = 1:L
  x_m(i,:) = data_norm((i-1)*columnas+1:i*columnas);
endfor

% toma bloques de la señal usando el tamaño que
% definimos y los ubica en las filas del vector aleatorio


% b) grafico de dispersion
tiledlayout(1,3);

nexttile
histogram(x_m(1, :), 50);

nexttile
scatter(x_m(1, :), x_m(2, :))

nexttile
histogram(x_m(2, :), 50);

% c) matriz de covarianza 

%calculo la esperanza de x_m
mu_x = mean(transpose(x_m));

%matriz de covarianzas
Cx = cov(x_m');

%autovalores y autovectores

[avec, avas] = eig(Cx);

% d) Primera parte, matriz Y_m

y_m = avec' * x_m;
Cy = cov(y_m');

% Define matriz y_m como Y = V' X
% V siendo la matriz de autovectores
% y cuyo resultado es la matriz de avas
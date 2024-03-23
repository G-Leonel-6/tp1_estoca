clear all
%ejercicio 1
% a) segmentacion del audio

[data, fs] = audioread('audio_01_2024a.wav');
data_norm = data / (rms(data));

L = 2;

columnas = length(data_norm) / L;

x_m = zeros(L, floor(columnas));


for i=1:ceil(columnas)
    for j = 1:L
        x_m(j, i) = data_norm(i+j-1);
    end
end


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

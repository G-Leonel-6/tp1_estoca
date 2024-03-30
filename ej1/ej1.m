clear all

%ejercicio 1
% a) segmentacion del audio


[data, fs] = audioread('../Archivos/audio_01_2024a.wav');
sign_norm = data / (rms(data));
L = 2;
columnas = ceil(length(sign_norm) / L);

x_m = zeros(L, columnas);


j = 1;
i = 1;
iter = 1;
while j <= columnas + 1
    while i <= 2 && iter < length(sign_norm) + 1
        x_m(i, j) = sign_norm(iter)/columnas;
        iter = iter + 1;
        i = i + 1;


% b) grafico de dispersion de x_m
figure();
tiledlayout(3,3);

nexttile([1 , 2])
hold on
grid on
xlabel('x_0');
ylabel('f_{x_0}(x_0)');
title('Histograma de X_0');
histogram(x_m(1, :), 50, 'Normalization', 'probability');
hold off

nexttile([2 2])
hold on
grid on
xlabel('x_0');
ylabel('x_1');
title('Dispersión de X_0 y X_1 ')
scatter(x_m(1, :), x_m(2, :))
hold off

nexttile(6,[2 1])
hold on
grid on
ylabel('x_1');
xlabel('f_{x_1}(x_1)');
title('Histograma de X_1')
histogram(x_m(2, :), 50, 'Normalization', 'probability', 'orientation', 'horizontal');
hold off
% c) matriz de covarianza 

%calculo la esperanza de x_m
mu_x = mean(transpose(x_m));

cx = cov(x_m');

%autovalores y autovectores

[avec, avas] = eig(cx);

%defino la matriz Y = U^T * X

y_m = avec' * x_m;

cy = cov(y_m');


% b) grafico de dispersion de y_m
figure();
tiledlayout(3,3);

nexttile([1, 2])
hold on
xlabel('y_0');
ylabel('f_{y_0}(y_0)');
title('Histograma de Y_0')
grid on
histogram(y_m(1, :), 50,  'Normalization', 'probability');
hold off

nexttile([2,2])
hold on
grid on
xlabel('y_0');
ylabel('y_1');
title('Dispersión de Y_0 e Y_1');
scatter(y_m(1, :), y_m(2, :))
hold off

nexttile(6, [2,1])
hold on
grid on
ylabel('y_1');
xlabel('f_{y_1}(y_1)');
title('Histograma de Y_1')
histogram(y_m(2, :), 50, 'Normalization', 'probability', 'orientation', 'horizontal');

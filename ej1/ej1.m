%ejercicio 1
% a) segmentacion del audio


[data, fs] = audioread('../Archivos/audio_01_2024a.wav');
data_norm = data / (rms(data)); %normalizamos los datos
L = 2; %largo de los vectores
columnas = ceil(length(data_norm) / L);

x_m = zeros(L, columnas); %vector aleatorio


j = 1;
i = 1;
iter = 1;

%ordenamos las muestras en vectores aleatorios de largo 2 
while j <= columnas
    while i <= 2 && iter < length(data_norm) + 1
        x_m(i, j) = data_norm(iter);
        iter = iter + 1;
        i = i + 1;
    end
    i = 1;
    j = j + 1;
end

% b) grafico de dispersion de x_m
figure();
tiledlayout(3,3);

%histograma de la variable aleatorioa X_0 normalizado
nexttile([1 , 2])
hold on
grid on
xlabel('x_0');
ylabel('f_{x_0}(x_0)');
title('Histograma de X_0');
histogram(x_m(1, :), 50, 'Normalization', 'pdf');
hold off

%grafico de dispersion de las variables X_0 Y X_1
nexttile([2 2])
hold on
grid on
xlabel('x_0');
ylabel('x_1');
title('Dispersión de X_0 y X_1 ')
scatter(x_m(1, :), x_m(2, :))
hold off

%histograma de la variable aleatoria X_1 normalizado
nexttile(6,[2 1])
hold on
grid on
ylabel('x_1');
xlabel('f_{x_1}(x_1)');
title('Histograma de X_1')
histogram(x_m(2, :), 50, 'Normalization', 'pdf', 'orientation', 'horizontal');
hold off

% c) matriz de covarianza 

%calculo la esperanza de x_m
mu_x = mean(transpose(x_m));

cx = cov(x_m'); %matriz de covarianza de x_m

%autovalores y autovectores

[avec, avas] = eig(cx);

%defino la matriz Y = U^T * X

y_m = avec' * x_m;

cy = cov(y_m');


% b) grafico de dispersion de y_m
figure();
tiledlayout(3,3);

%histograma de Y_0 normalizado
nexttile([1, 2])
hold on
xlabel('y_0');
ylabel('f_{y_0}(y_0)');
title('Histograma de Y_0')
grid on
histogram(y_m(1, :), 50,  'Normalization', 'pdf');
hold off

%grafico de dispersion de Y_0 e Y_1
nexttile([2,2])
hold on
grid on
xlabel('y_0');
ylabel('y_1');
title('Dispersión de Y_0 e Y_1');
scatter(y_m(1, :), y_m(2, :))
hold off

%histograma de Y_1 normalizado
nexttile(6, [2,1])
hold on
grid on
ylabel('y_1');
xlabel('f_{y_1}(y_1)');
title('Histograma de Y_1')
histogram(y_m(2, :), 50, 'Normalization', 'pdf', 'orientation', 'horizontal');

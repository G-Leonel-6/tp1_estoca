%ejercicio 1
% a) segmentacion del audio


[data, fs] = audioread('../Archivos/audio_01_2024a.wav');
sign_norm = data / (rms(data));
L = 2;
columnas = ceil(length(sign_norm) / L);

x_m = zeros(L, columnas);

for i=1:L
    for j = 1:columnas
        if((i-1)*columnas+j > length(sign_norm))
            break;
        end
        
        x_m(i, j) = sign_norm((i-1)*columnas+j);
    end
end

x_m(end, end-1)
sign_norm(end)

% b) grafico de dispersion de x_m
figure();
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

cx = cov(x_m')

%autovalores y autovectores

[avec, avas] = eig(cx);

%defino la matriz Y = U^T * X

y_m = avec' * x_m;


% b) grafico de dispersion de y_m
figure();
tiledlayout(1,3);

nexttile
histogram(y_m(1, :), 50);

nexttile
scatter(y_m(1, :), x_m(2, :))

nexttile
histogram(y_m(2, :), 50);

clear all

% a) segmentacion del audio 1

[data, fs] = audioread('../Archivos/audio_01_2024a.wav');
sign_norm = data / (rms(data));
L = 1323;
columnas = ceil(length(sign_norm) / L);

x_m = zeros(L, columnas);

for i=1:columnas
    for j = 1:L
        if((i-1)*L+j > length(sign_norm))
            break;
        end
        
        x_m(j, i) = sign_norm((i-1)*L+j);
    end
end

%calculo la matriz de covarianza con sus autovectores y autovalores

cx = cov(x_m');

%autovalores y autovectores

[avec, avas] = eig(cx);

%ordeno los avec y avas en orden ascendente

[d, ind] = sort(diag(avas), 'descend');

D = avas(ind, ind);
V = avec(:, ind);

%compression rate
CR1 = 5:5:100;
MSE1 = zeros([1 length(CR1)]);

for i=1:length(CR1)
   K = ceil((1 - CR1(i)/100) * L); %cantidad de componentes principales
   
   %defino la matriz U con K autovectores

    U = V(:, 1:K);

    %obtengo la coleccion Y_m 
    Y_m = U' * x_m;

    %b) reconstruccion del audio

    X_m = U * Y_m;

    x_r = zeros([1 L*columnas]);

    for j = 1:columnas
       x_r((j-1)*L+1:j*L) = X_m(:, j); 
    end
    
    %normalizo la señal
    x_r_norm(1:length(sign_norm)) = x_r(1:length(sign_norm)) / (rms(x_r(1:length(sign_norm))));
    
    x = (sign_norm-x_r_norm').^2;
    
    MSE1(i) = (1/length(sign_norm)) * sum(x);
    
end


% a) segmentacion del audio 2

[data, fs] = audioread('../Archivos/audio_02_2024a.wav');
sign_norm = data / (rms(data));
L = 1323;
columnas = ceil(length(sign_norm) / L);

x_m = zeros(L, columnas);

for i=1:columnas
    for j = 1:L
        if((i-1)*L+j > length(sign_norm))
            break;
        end
        
        x_m(j, i) = sign_norm((i-1)*L+j);
    end
end

%calculo la matriz de covarianza con sus autovectores y autovalores

cx = cov(x_m');

%autovalores y autovectores

[avec, avas] = eig(cx);

%ordeno los avec y avas en orden ascendente

[d, ind] = sort(diag(avas), 'descend');

D = avas(ind, ind);
V = avec(:, ind);

%compression rate
CR2 = 5:5:100;
MSE2 = zeros([1 length(CR2)]);

for i=1:length(CR2)
   K = ceil((1 - CR2(i)/100) * L); %cantidad de componentes principales
   
   %defino la matriz U con K autovectores

    U = V(:, 1:K);

    %obtengo la coleccion Y_m 
    Y_m = U' * x_m;

    %b) reconstruccion del audio

    X_m = U * Y_m;

    x_r = zeros([1 L*columnas]);

    for j = 1:columnas
       x_r((j-1)*L+1:j*L) = X_m(:, j); 
    end
    
    %normalizo la señal
    x_r_norm(1:length(sign_norm)) = x_r(1:length(sign_norm)) / (rms(x_r(1:length(sign_norm))));
    
    x = (sign_norm-x_r_norm').^2;
    
    MSE2(i) = (1/length(sign_norm)) * sum(x);
    
end

% a) segmentacion del audio 3

[data, fs] = audioread('../Archivos/audio_03_2024a.wav');
sign_norm = data / (rms(data));
L = 1323;
columnas = ceil(length(sign_norm) / L);

x_m = zeros(L, columnas);

for i=1:columnas
    for j = 1:L
        if((i-1)*L+j > length(sign_norm))
            break;
        end
        
        x_m(j, i) = sign_norm((i-1)*L+j);
    end
end

%calculo la matriz de covarianza con sus autovectores y autovalores

cx = cov(x_m');

%autovalores y autovectores

[avec, avas] = eig(cx);

%ordeno los avec y avas en orden ascendente

[d, ind] = sort(diag(avas), 'descend');

D = avas(ind, ind);
V = avec(:, ind);

%compression rate
CR3 = 5:5:100;
MSE3 = zeros([1 length(CR3)]);

for i=1:length(CR3)
   K = ceil((1 - CR3(i)/100) * L); %cantidad de componentes principales
   
   %defino la matriz U con K autovectores

    U = V(:, 1:K);

    %obtengo la coleccion Y_m 
    Y_m = U' * x_m;

    %b) reconstruccion del audio

    X_m = U * Y_m;

    x_r = zeros([1 L*columnas]);

    for j = 1:columnas
       x_r((j-1)*L+1:j*L) = X_m(:, j); 
    end
    
    %normalizo la señal
    x_r_norm = x_r / (rms(x_r));
    
    x = (sign_norm-x_r_norm(1:length(sign_norm))').^2;
    
    MSE3(i) = (1/length(sign_norm)) * sum(x);
    
end

figure
plot(CR1, MSE1, 'r-', 'LineWidth', 1, 'DisplayName', 'Audio 1')
hold on
title('CR vs MSE')
plot(CR2, MSE2, 'g-', 'LineWidth', 1, 'DisplayName', 'Audio 2')
plot(CR3, MSE3, 'b-', 'LineWidth', 1, 'DisplayName', 'Audio 3')
grid on
xlabel('CR(%)')
ylabel('MSE')
hold off
legend('Location', 'NorthWest')

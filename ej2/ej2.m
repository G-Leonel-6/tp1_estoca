clear all

% a) segmentacion del audio

[data, fs] = audioread('../Archivos/audio_01_2024a.wav');
sign_norm = data / (rms(data));
L = 1323;
columnas = ceil(length(sign_norm) / L);

CR = 70; %compression rate
K = ceil((1 - CR/100) * L); %cantidad de componentes principales

x_m = zeros(L, columnas);

for i=1:L
    for j = 1:columnas
        if((i-1)*columnas+j > length(sign_norm))
            break;
        end
        
        x_m(i, j) = sign_norm((i-1)*columnas+j);
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

%defino la matriz U con K autovectores

U = avec(:, 1:K);

%obtengo la coleccion Y_m 
Y_m = U' * x_m;

%b) reconstruccion del audio

X_m = U * Y_m;

x_r = zeros([1 L*columnas]);

for i = 1:L
   x_r((i-1)*columnas+1:i*columnas) = X_m(i, :); 
end

sound(x_r, fs);
sound(sign_norm);
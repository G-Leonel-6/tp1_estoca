clear all

% a) segmentacion del audio

[data, fs] = audioread('../Archivos/audio_02_2024a.wav');
data_norm = data / (rms(data));
L = 1323;
columnas = ceil(length(data_norm) / L);

CR = [70 90 95]; %compression rate

x_m = zeros(L, columnas);


for i=1:columnas
    for j = 1:L
        if((i-1)*L+j > length(data_norm))
            break;
        end
        
        x_m(j, i) = data_norm((i-1)*L+j);
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

x_r = zeros([3 L*columnas]); %cada fila de esta matriz corresponde al audio comprimido con los diferentes valores de CR

%defino la matriz U con K autovectores
for k = 1:length(CR)
    K = ceil((1 - CR(k)/100) * L); %cantidad de componentes principales
    U = V(:, 1:K);

    %obtengo la coleccion Y_m 
    Y_m = U' * x_m;

    %reconstruccion del audio

    X_m = U * Y_m;

    for i = 1:columnas
       x_r(k,(i-1)*L+1:i*L) = X_m(:, i); 
    end

    x_r(k,:) = x_r(k,:) / (rms(x_r(k,:))); %lo normalizo

end

audiowrite("Audios_comprimidos/audio_02_2024a_CR70.wav", x_r(1,:), fs);
audiowrite("Audios_comprimidos/audio_02_2024a_CR90.wav", x_r(2,:), fs);
audiowrite("Audios_comprimidos/audio_02_2024a_CR95.wav", x_r(3,:), fs);
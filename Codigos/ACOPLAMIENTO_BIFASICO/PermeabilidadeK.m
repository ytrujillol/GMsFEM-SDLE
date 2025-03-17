% function [K] = PermeabilidadeK(Nx, Ny, hx, hy)
%     K = ones(Nx, Ny);  % Fondo negro (permeabilidad 1)
%     canales = [
%         struct('fila_inicio', floor(Ny * 0.15), 'fila_fin', floor(Ny * 0.22), 'col_inicio', floor(Nx * 0.1), 'col_fin', floor(Nx * 0.8)),
%         struct('fila_inicio', floor(Ny * 0.35), 'fila_fin', floor(Ny * 0.42), 'col_inicio', floor(Nx * 0.3), 'col_fin', floor(Nx * 0.7)),
%         struct('fila_inicio', floor(Ny * 0.55), 'fila_fin', floor(Ny * 0.62), 'col_inicio', floor(Nx * 0.05), 'col_fin', floor(Nx * 0.5))
%     ];
%     for c = 1:length(canales)
%         fila_inicio = canales(c).fila_inicio;
%         fila_fin = canales(c).fila_fin;
%         col_inicio = canales(c).col_inicio;
%         col_fin = canales(c).col_fin;
%         K(col_inicio:col_fin, fila_inicio:fila_fin) = 5;  % Alta permeabilidad en los canales (amarillo)
%     end
% end

function [K] = PermeabilidadeK(Nx, Ny, hx, hy)
    ruta = 'C:\Users\ytruj\Downloads\permeabilidad.mat';

    % Cargar la matriz K desde el archivo
    datos = load(ruta, 'K');
    K = datos.K; % Extraer la matriz
end

% function [K] = PermeabilidadeK(Nx, Ny, hx, hy)
%     archivo = 'permeabilidad.mat'; % Nombre del archivo donde se guardará la matriz
% 
%     % Si el archivo ya existe, cargar K desde el archivo y evitar regeneración
%     if exist(archivo, 'file')
%         datos = load(archivo, 'K');
%         K = datos.K;
%         return;
%     end
% 
%     % Parámetros de permeabilidad en miliDarcy (mD)
%     K_base = 0.1; % Baja permeabilidad
%     K_media = 3; % Permeabilidad media
%     K_max = 5; % Alta permeabilidad
% 
%     num_canales = 10; % Número de canales de alta permeabilidad
% 
%     % Generar campo de permeabilidad con distribución log-normal
%     mu_log = log(K_media); % Media logarítmica
%     sigma_log = 1.2; % Desviación estándar logarítmica
% 
%     % Generar permeabilidad base con variabilidad espacial
%     Z = randn(Nx, Ny); % Asegurar que la matriz tenga tamaño (Nx, Ny)
%     K = exp(mu_log + sigma_log * Z); % Aplicar transformación log-normal
%     K = max(K_base, min(K, K_max)); % Normalizar dentro del rango permitido
% 
%     % Generar canales de alta permeabilidad (fracturas o areniscas conectadas)
%     for c = 1:num_canales
%         col_inicio = randi([1, Nx-10]);
%         col_fin = min(Nx, col_inicio + randi([10, 30]));
%         fila_inicio = randi([1, Ny-5]);
%         fila_fin = min(Ny, fila_inicio + randi([3, 10]));
% 
%         % Asignar alta permeabilidad en los canales
%         K(col_inicio:col_fin, fila_inicio:fila_fin) = K_max;
%     end
% 
%     % Guardar la matriz generada en un archivo .mat para futuras ejecuciones
%     save(archivo, 'K');
% end
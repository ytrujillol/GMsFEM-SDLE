% Implementación de MsFEM para la ecuación de la cuerda elástica
clear; clc;

% Parámetros del problema
L = 1;                  % Longitud del dominio
N = 10;                 % Número de segmentos
h = L / N;              % Tamaño de los elementos
x = linspace(0, L, N+1);% Puntos de la malla

% Coeficiente k(x) y término fuente f(x)
k = @(z) 1; % Coeficiente constante
f = @(z) 1; % Término fuente constante

% Prealocar matriz A y vector b
A = zeros(N+1, N+1);    % Matriz tri-diagonal
b = zeros(N+1, 1);      % Vector de fuerzas

% Construcción de la matriz A
for i = 2:N
    % Constantes para las bases multiescala en cada subintervalo
    c1 = 1 / (x(i) - x(i-1));
    c2 = 1 / (x(i+1) - x(i));
    
    % Elementos tri-diagonales
    A(i, i-1) = -c1;                   % a_{i, i-1}
    A(i, i) = c1 + c2;                 % a_{i, i}
    A(i, i+1) = -c2;                   % a_{i, i+1}
end

% Construcción del vector b
for i = 2:N
    b(i) = f(0) * (x(i) - x(i-1)); % Con f constante
end

% Aplicar condiciones de frontera
A(1, :) = 0; A(:, 1) = 0; A(1, 1) = 1; % u(0) = 0
A(end, :) = 0; A(:, end) = 0; A(end, end) = 1; % u(1) = 0
b(1) = 0; b(end) = 0;

% Resolución del sistema matricial Ax = b
u = A \ b;

% Graficar la solución
figure;
plot(x, u, 'LineWidth', 0.5); % Línea continua y más gruesa
xlabel('x'); % Etiqueta del eje x
ylabel('u'); % Etiqueta del eje y
title('Solución numérica de -u''''(x)=1 con MsFEM'); % Título de la gráfica
legend('u(x)', 'Location', 'northeast'); % Leyenda

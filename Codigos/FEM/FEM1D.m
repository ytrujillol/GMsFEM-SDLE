% Implementación del FEM para la ecuación de la cuerda elástica
clear; clc;

% Parámetros del problema
L = 1;                  % Longitud del dominio
N = 10;                 % Número de elementos
h = L / N;              % Tamaño de los elementos
x = linspace(0, L, N+1); % Puntos de la malla

% Coeficiente k(x) y término fuente f(x)
k = @(z) 1; % Coeficiente constante
f = @(z) 1; % Término fuente constante

% Prealocar matriz A y vector b
A = zeros(N+1, N+1);    % Matriz de rigidez
b = zeros(N+1, 1);      % Vector de fuerzas

% Ensamblaje de la matriz A y el vector b
for i = 2:N
    % Localización de los nodos
    x_i = x(i-1); % Inicio del subintervalo
    x_j = x(i);   % Fin del subintervalo
    x_k = x(i+1); % Nodo siguiente
    
    % Integrales de la matriz de rigidez (k constante)
    A(i, i-1) = -k(0) / h; % a_{i, i-1}
    A(i, i) = 2 * k(0) / h; % a_{i, i}
    A(i, i+1) = -k(0) / h; % a_{i, i+1}
    
    % Integral del vector de fuerzas (f constante)
    b(i) = f(0) * h / 2; % b_i
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
ylabel('u(x)'); % Etiqueta del eje y
title('Solución numérica de -u''''(x)=1 con FEM'); % Título de la gráfica
legend('u(x)', 'Location', 'northeast'); % Leyenda

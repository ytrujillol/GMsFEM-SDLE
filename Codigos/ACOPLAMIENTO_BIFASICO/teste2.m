x = linspace(5, 10, 80);                                % Create Data
y = linspace(1,  5, 50);                                % Create Data
[X,Y] = meshgrid(x,y);                                  % Create Data
Z = sin(X.^2) - cos(Y.^2);                              % Create Data
figure(1)
surf(X, Y, Z)                                           % Surface Plot
grid on
X_idx = find(x >= 7.5, 1, 'first');                     % Find Desired ‘X’ Value
figure(2)
plot(Y(:,X_idx), Z(:,X_idx))                            % Plot At Desired ‘X’ Value
grid
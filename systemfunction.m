n = 0:5; 
x = zeros(size(n));
x(1:3) = [1, 1, 1]; % x[n] = 1 for 0 <= n <= 2

h = zeros(size(n));
h(2:4) = 1/3; % h[n] = 1/3 for 1 <= n <= 3

y = conv(x, h);

ny = 0:(length(x) + length(h) - 2);

figure;
stem(ny, y);
title('Convolution of x[n] and h[n]');
xlabel('n');
ylabel('y[n]');
grid on;

% 6-point DFT
Y = fft(y, 6);

figure;
stem(0:5, abs(Y));
title('6-point DFT of y[n]');
xlabel('Frequency Index');
ylabel('Magnitude');
grid on;

figure;
stem(0:5, angle(Y));
title('6-point DFT of y[n] (Phase)');
xlabel('Frequency Index');
ylabel('Phase (radians)');
grid on;
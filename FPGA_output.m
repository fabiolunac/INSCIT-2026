clc
close all
clear

Gy = 2^15;
Gx = 2^32;

% Coeficientes reais
Hz = load("Hz.mat");
Hz = Hz.Hz;

% Dados FPGA
data = load("shaper_tb.txt");
data = data/Gx;


N = length(data);
M = length(Hz);
X = zeros(N, M);

% Saída do shaper ideal
for i=1:M
    Zn = Hz{1,i}.Numerator;
    Zd = Hz{1,i}.Denominator;

    [X_temp, B] = impz(Zn, Zd, N);

    X(:,i) = X_temp;
end

h = sum(X,2);

% Calcular erro
err = h - data;
eRMS = sqrt(mean((h - data).^2));

fprintf('RMS Error: %.4f%%\n', eRMS*100);

% Figura de comparação
figure;
stem(h)
hold on
stem(data);
xlim([0 100]);

grid on;
title('Pulse Shaper')
ylabel('Amplitude');
xlabel('Samples');
legend('Original Signal', 'FPGA Output')

figure;
stem(err)

figure;
stem(data)
ylim([-0.001 0.001])
xlim([0 200])
title('Long Negative Tail - FPGA Output')
ylabel('Amplitude');
xlabel('Samples');
grid on
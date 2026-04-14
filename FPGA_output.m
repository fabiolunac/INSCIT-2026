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
data = data / Gx;

N = length(data);
M = length(Hz);
X = zeros(N, M);

% Saída do shaper ideal
for i = 1:M
    Zn = Hz{1,i}.Numerator;
    Zd = Hz{1,i}.Denominator;

    [X_temp, ~] = impz(Zn, Zd, N);

    X(:,i) = X_temp;
end

h = sum(X, 2);

% Calcular erro
err = h - data;
eRMS = sqrt(mean(err.^2));
eMAX = max(abs(err));

fprintf('RMS Error:     %.6f  (%.4f%%)\n', eRMS, eRMS*100);
fprintf('Max Abs Error: %.6f\n', eMAX);

%% ---------- Figura 1: Comparação do pulso principal ----------
figure('DefaultAxesFontSize', 18, 'Position', [100 400 900 500]);
stem(h, 'k', 'filled', 'MarkerSize', 4, 'DisplayName', 'Ideal Response');
hold on;
stem(data, 'r', 'MarkerSize', 4, 'DisplayName', 'FPGA Output');
xlim([0 100]);
grid on;
title('Pulse Shaper — Impulse Response');
ylabel('Normalized Amplitude');
xlabel('Samples');
legend('Location', 'northeast');

%% ---------- Figura 2: Erro de quantização ----------
figure('DefaultAxesFontSize', 18, 'Position', [100 400 900 500]);
stem(err, 'b', 'MarkerSize', 3, 'DisplayName', 'Quantization Error');
hold on;
yline( eRMS, '--r', sprintf('RMS = %.2e', eRMS), ...
    'LineWidth', 1.2, 'LabelHorizontalAlignment', 'left', ...
    'HandleVisibility', 'off');
yline(-eRMS, '--r', '', 'LineWidth', 1.2, 'HandleVisibility', 'off');
xlim([0 200]);
grid on;
title('Quantization Error  (Ideal Response - FPGA)');
ylabel('Error');
xlabel('Samples');
legend('Location', 'northeast');

%% ---------- Figura 3: Cauda negativa (zoom) ----------
figure('DefaultAxesFontSize', 18, 'Position', [100 400 900 500]);

% subplot(2,1,1);
stem(h, 'k', 'filled', 'MarkerSize', 3, 'DisplayName', 'MATLAB (ideal)');
hold on;
stem(data, 'r', 'MarkerSize', 3, 'DisplayName', 'FPGA Output');
ylim([-0.001 0.001]);
xlim([0 200]);
grid on;
title('Long Negative Tail — Comparison');
ylabel('Normalized Amplitude');
legend('Location', 'northeast');

% subplot(2,1,2);
% stem(err(1:min(200,N)), 'm', 'MarkerSize', 3);
% xlim([0 200]);
% grid on;
% title('Tail Region — Error');
% ylabel('Error');
% xlabel('Samples');
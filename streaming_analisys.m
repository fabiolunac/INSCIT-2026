clear all
close all

shaper_out = load("shaper_electronics_streaming_tb.txt");
amp_truth = load("amp_truth.txt");

shaper_out = shaper_out(5:10e4) / (2^15);

% Eixo temporal em amostras
n = 1:length(amp_truth);

%% ---------- Figura 1: Comparacao Shaper vs Truth ----------
figure('DefaultAxesFontSize', 18, 'Position', [100 400 1100 500]);
plot(n, amp_truth, 'DisplayName', 'Truth Amplitude');
hold on;
plot(shaper_out, 'DisplayName', 'Shaper Output');
hold off;
grid on;
title('Streaming Analysis — Shaper Output vs Truth');
ylabel('Normalized Amplitude');
xlabel('Samples');
legend('Location', 'best');
xlim([1 length(amp_truth)]);
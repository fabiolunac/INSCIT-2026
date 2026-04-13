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

% Figura de comparação
figure;
stem(h)
hold on
stem(data/(Gx));

function [y, Zn_q, Zd_q] = iir_generico(Zn, Zd, N, Gx, Gy)
    % Quantização dos coeficientes: multiplica por Gy e arredonda
    Zn_q = round(Zn * Gy);
    Zd_q = round(Zd * Gy);

    % Vetores de entrada (impulso) e saída
    x = zeros(N, 1);
    y = zeros(N, 1);
    x(1) = Gx;

    len_n = length(Zn_q);
    len_d = length(Zd_q);

    for n = 1:N
        acc = 0;

        % Numerador: soma de Zn_q(k) * x[n-k+1]
        for k = 1:len_n
            idx = n - k + 1;
            if idx >= 1
                acc = acc + Zn_q(k) * x(idx);
            end
        end

        % Denominador (feedback): subtrai Zd_q(k) * y[n-k+1], k >= 2
        for k = 2:len_d
            idx = n - k + 1;
            if idx >= 1
                acc = acc - Zd_q(k) * y(idx);
            end
        end

        % Divisão por Gy para manter a escala (shift right de 15 bits)
        y(n) = floor(acc / Gy);
    end
end

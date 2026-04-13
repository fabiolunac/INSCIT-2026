function [y, Zn_q, Zd_q] = iir_generico(Zn, Zd, N, Gx, Gy)
    % Quantização dos coeficientes: multiplica por Gy e arredonda
    Zn_q = round(Zn * Gy);   % numerador quantizado
    Zd_q = round(Zd * Gy);   % denominador quantizado

    % Implementação do filtro IIR em ponto fixo
    x = zeros(N, 1);
    y = zeros(N, 1);
    x(1) = Gx;  % impulso escalado

    % Para um filtro de 2a ordem: y[n] = Zn_q(1)*x[n] + Zn_q(2)*x[n-1] - Zd_q(2)*y[n-1] - Zd_q(3)*y[n-2]
    % (tudo em aritmética inteira, dividindo por Gy onde necessário)
    
    for n = 1:N
        % Acumulador do numerador
        acc = 0;
        for k = 1:length(Zn_q)
            if (n-k+1) >= 1
                acc = acc + Zn_q(k) * x(n-k+1);
            end
        end
        % Acumulador do denominador (feedback)
        for k = 2:length(Zd_q)
            if (n-k+1) >= 1
                acc = acc - Zd_q(k) * y(n-k+1);
            end
        end
        % Divisão por Gy para manter a escala (shift right de 15 bits)
        y(n) = floor(acc / Gy);
    end
end
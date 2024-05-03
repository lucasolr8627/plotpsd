%% plotpsd - plot da densidade de potência espectral

% descrição dos parâmetros
% X: vetor real
% fa: frequência de amostragem
%
% retorno: n/a

function plotpsd(X, fa)
    % numero de amostras
    N = length(X);
    % usar N como potencia de 2 melhora a performance da fft
    % calculamos a potência de 2 mais próxima, pouco alterando a faixa de
    % frequência analisada
    N = pow2(nextpow2(N));
    % calcula a fft do sinal passando N como segundo parâmetro
    X_fft = fft(X, N);
    % calcula o módulo da fft pois estamos interessados na correlação de
    % senos (im) e cossenos (real) de cada frequência com os harmônicos do
    % sinal
    % eleva ao quadrado e divide por fa * N pois estamos interessados na densidade
    % de potência espectral (potencia/frequencia) i.e. multiplicamos a potência fft^2/N^2
    % por N/fa
    % dividimos por N para obter a amplitude
    A_X1 = abs(X_fft).^2 / (fa * N);
    % separa a primeira metade (frequências positivas) pois o módulo da fft
    % é espelhado e só nos interessa uma das metades
    A_X2 = A_X1(1:floor(N/2));
    % concentra o espectro, multiplicando por 2 todas as amplitudes exceto
    % 0Hz e a frequência de Nyquist (fa/2)
    A_X2(2:end-1) = 2*A_X2(2:end-1);
    % faixa de frequência dos harmônicos vai de 0Hz até a frequência de
    % Nyquist (length(A_X2) = floor(N/2), assim o último elemento de s é
    % (N/2) * (fa/N) = fa/2)
    s = (0:length(A_X2) - 1) * (fa/N);
    % plot
    stem(s, A_X2, 'k');
    xlabel('frequência (Hz)');
    ylabel('densidade de potência (dB)/Hz');
    title('Densidade Espectral de Potência');
    grid;
end

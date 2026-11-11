%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. Calculation of Lyapunov spectrum %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initial states
X = X_init;

%% Benettin algorithm
[Q, ~] = qr(randn(N, LSdim), 0);

cum_sum = zeros(LSdim, 1);
lambda_history = zeros(LSdim, n_steps_test);

W_net = W + W_in * W_out;
I_n = eye(N);
dt_lp = 0.001 * ds;


%% main
for i = 1:n_steps_test
    % Jacobian J
    act = W_net * X + b;
    sech2_val = 1 - tanh(act).^2;

    J = (1 - a) * I_n + a * (sech2_val .* W_net);

    % QR decomposition
    Z = J * Q;
    [Q, R] = qr(Z, 0);

    % cumulative expansion rate
    r_diag = abs(diag(R));
    cum_sum = cum_sum + log(r_diag);

    % convergence history
    lambda_history(:, i) = cum_sum / (i * dt_lp);

    % update reservoir state
    X = (1 - a) * X + a * tanh(act);
end

% Lyapunov spectrum
lyap_exp = lambda_history(:, end);

fprintf('1st Lyapunov exponent = %.2f\n', lyap_exp(1));
fprintf('2rd Lyapunov exponent = %.2f\n', lyap_exp(2));
fprintf('3rd Lyapunov exponent = %.2f\n', lyap_exp(3));
fprintf('4rd Lyapunov exponent = %.2f\n', lyap_exp(4));

% KY dimension
cumsum_lambda = cumsum(lyap_exp);
k = find(cumsum_lambda >= 0, 1, 'last');
if ~isempty(k) && k < length(lyap_exp)
    D_ky = k + cumsum_lambda(k) / abs(lyap_exp(k+1));
else
    D_ky = NaN;
end

fprintf('KY dimension = %.2f\n', D_ky);
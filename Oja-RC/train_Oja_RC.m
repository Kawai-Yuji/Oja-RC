%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. plasticity and training %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_Oja_history = zeros(N, n_steps_Oja);
X_RLS_history = zeros(N, n_steps_RLS);

%% main loops
% initial conditions
X = 2 * rand(N, 1) - 1;
X_mean = zeros(N, 1);

for i = 1:n_steps-1

    X_pre = X;
    X_mean_pre = X_mean;

    X = (1 - a) * X + a * tanh(W * X + W_in * target(:, i) + b);

    X_mean = (1 - a_c) * X_mean + a_c * X;
    X_center = X - X_mean;
    X_pre_center = X_pre - X_mean_pre;

    %% update RNN units
    if i <= n_steps_Oja

        X_Oja_history(:, i) = X_center;

        %% Oja's rule
        W = W + eta * (X_center * X_pre_center' - diag(X_center.^2) * W);

        spectral_radius(i+1) = abs(eigs(W, 1, 'lm', opts));

    elseif i > n_steps_Oja

        X_RLS_history(:, i-n_steps_Oja) = X_center;
        Out = W_out * X;

        % update error
        error = target(:, i+1) - Out;

        % RLS
        PX = P * X;
        k = PX / (1 + X' * PX);
        W_out = W_out + error * k';
        P = P - k * PX';
    end
end

X_init = X;

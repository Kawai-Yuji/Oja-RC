%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. test for evaluating error %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Out_test_history_error = zeros(K, n_steps_test_error);

% initial conditions
X = X_init;
Out = target(:, 1);

Out_test = zeros(K, Period);
Out_test_history_error(:, 1) = Out;

for i = 1:n_steps_test_error-1

    % update RNN units
    X = (1 - a) * X + a * tanh(W * X + W_in * (Out + sigma * randn(K, 1)) + b);

    % output
    Out = W_out * X;
    Out_test_history_error(:, i+1) = Out;
end

rmse = sqrt(mean((target(:, 1:Period*2) - Out_test_history_error).^2, 'all'));
fprintf('RMSE = %.5f\n', rmse);
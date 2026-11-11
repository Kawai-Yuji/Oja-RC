%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. test for evaluating distance %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Out_test_history_dist = zeros(K, n_steps_test_dist+1);

% initial conditions
X = 2 * rand(N, 1) - 1;
Out = initial_Pos(:, m);
Out_test_history_dist(:, 1) = Out;

for i = 1:n_steps_test_dist

    % update RNN units
    X = (1 - a) * X + a * tanh(W * X + W_in * (Out + sigma * randn(K, 1)) + b);
    
    % output through readout
    Out = W_out * X;
    Out_test_history_dist(:, i+1) = Out;
end
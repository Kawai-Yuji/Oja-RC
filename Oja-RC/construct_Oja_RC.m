%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. construct recurrent neural network %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% input connections W_in
W_in = g_in / sqrt(K) * randn(N, K);

% bias input
b = g_b * randn(N, 1);

% readout
P = eye(N) ./ alpha;
W_out = zeros(K, N);

%% recurrent connections W
W = randn(N) * g / sqrt(N);
W_init = W;
spectral_radius = zeros(1, n_steps_Oja+1);
spectral_radius(1) = abs(eigs(W_init, 1, 'lm', opts));

% leaky rate
a = 1/tau;
a_c = 1/tau_c;
%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. analyses of weight matrix %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% weight distributions

W_init_vec = [];
for i = 1:N
    Wrow = W_init(i, :);
    Wrow(Wrow==0) = [];
    W_init_vec = [W_init_vec Wrow];
end

Wvec = [];
for i = 1:N
    Wrow = W(i, :);
    Wrow(Wrow==0) = [];
    Wvec = [Wvec Wrow];
end

figure(1)
histogram(W_init_vec, 'BinWidth', 0.02, 'BinLimits', [-1.0 1.0]);
hold on
histogram(Wvec, 'BinWidth', 0.02, 'BinLimits', [-1.0 1.0], 'FaceAlpha', 0.4);

xlim([-0.4 0.4])
xlabel('Weight')
ylabel('Count')
hold off


%% spectral radius
figure(2)
plot(0:1:n_steps_Oja, spectral_radius, 'LineWidth', lwidth);

xlabel('Time step')
ylabel('Spectral radius')


%% eigen plot for weights
eigen_init = eig(W_init);
eigen = eig(W);

figure(3)
scatter(real(eigen_init), imag(eigen_init), 'filled')
hold on
scatter(real(eigen), imag(eigen), 'filled')

xlabel('Real')
ylabel('Imaginary')
hold off


%% correlation matrix of weights
% Correlation matrix of state matrix
CX_init = W_init * W_init';
CX = W * W';
[V_init, D_eigen_init] = eig(CX_init, 'vector');
[V, D_eigen] = eig(CX, 'vector');

[D_eigen_sort_init, sort_idx] = sort(D_eigen_init, 'descend');
V_init = V_init(:, sort_idx);
[D_eigen_sort, sort_idx] = sort(D_eigen, 'descend');
V = V(:, sort_idx);

figure(4)
histogram(D_eigen_init, 'BinWidth', 0.1)
hold on
histogram(D_eigen, 'BinWidth', 0.1)

xlabel('Eigenvalue')
ylabel('Count')
hold off


%% cosine similarity
% PC vectors of X
[CX_eigen_vec, CX_eigen_val] = eig(X_Oja_history * X_Oja_history', 'vector');
[lambda, sort_idx] = sort(CX_eigen_val, 'descend');
CX_eigen_vec = CX_eigen_vec(:, sort_idx);

% eigen vectors of W
[W_eigen_vec_init, W_eigen_val_init] = eig(W_init, 'vector');
[W_eigen_vec, W_eigen_val] = eig(W, 'vector');
[W_eigen_sort_init, sort_idx] = sort(W_eigen_val_init, 'descend');
W_eigen_vec_init = W_eigen_vec_init(:, sort_idx);
[W_eigen_sort, sort_idx] = sort(W_eigen_val, 'descend');
W_eigen_vec = W_eigen_vec(:, sort_idx);

cs_init = cosine_sim(CX_eigen_vec, W_eigen_vec_init, CSdim);
fprintf('\nInitial cosine similarity\n');
disp(cs_init)

cs = cosine_sim(CX_eigen_vec, W_eigen_vec, CSdim);
fprintf('\nFinal cosine similarity\n');
disp(cs)


%% Jacobian matrix
J = W + W_in * W_out;

eigen_J = eig(J);

figure(5)
scatter(real(eigen_J), imag(eigen_J), 'filled')
xlabel('Real')
ylabel('Imaginary')

CX_J = J' * J;
[V_J, D_J_eigen] = eig(CX_J, 'vector');
figure(6)
histogram(D_J_eigen, 'BinWidth', 0.1)
xlabel('Eigenvalue')
ylabel('Count')
%% FORCE learning with Oja's plasticity

[W_eigen_vec, W_eigen_val] = eig(W, 'vector');
[W_eigen_sort, sort_idx] = sort(W_eigen_val, 'descend');
W_eigen_vec = W_eigen_vec(:, sort_idx);

if strcmp(taskname, '2d') || strcmp(taskname, '3d')

    projected_state = W_eigen_vec' * X_Oja_history(:, n_steps_Oja-Period+1:n_steps_Oja);
    c = linspace(1, 10, Period);

elseif strcmp(taskname, 'lorenz')

    projected_state = W_eigen_vec' * X_RLS_history;
    c = linspace(1, 10, n_steps_RLS);

end

if K == 2
    figure(9)
    scatter(projected_state(1, :), projected_state(2, :), 25, c, 'filled')
    xlabel('State projection onto 1st eigenmode')
    ylabel('State projection onto 2nd eigenmode')
    colorbar

elseif K == 3
    figure(11)
    scatter(projected_state(1, :), projected_state(2, :), 25, c, 'filled')
    xlabel('State projection onto 1st eigenmode')
    ylabel('State projection onto 2nd eigenmode')
    colorbar

    figure(12)
    scatter(projected_state(2, :), projected_state(3, :), 25, c, 'filled')
    xlabel('State projection onto 2nd eigenmode')
    ylabel('State projection onto 3rd eigenmode')
    colorbar
end

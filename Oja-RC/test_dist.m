%% FORCE learning with Oja's plasticity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. test for evaluating distance %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = 0;

L = 5^K;
Out_test_m = zeros(K, n_steps_test_dist+1, L);
D_m = zeros(n_steps_test_dist+1, L);
conv_num_m = zeros(1, L);
distance_tran_m = zeros(1, L);
distance_conv_m = zeros(1, L);
fixed_point_m = zeros(1, L);

if strcmp(taskname, '2d')
    for ini1 = -1:0.5:1
        for ini2 = -1:0.5:1
            m = m + 1;
            initial_Pos(:, m) = [ini1; ini2];

            test_initial_pos;

            Out_test_m(:, :, m) = Out_test_history_dist;

            [D_m(:, m), conv_num_m(m), distance_tran_m(m), distance_conv_m(m), fixed_point_m(m)] = distance_curve(target, Out_test_m(:, :, m));
        end
    end

elseif strcmp(taskname, '3d')
    for ini1 = -1:0.5:1
        for ini2 = -1:0.5:1
            for ini3 = -1:0.5:1
                m = m + 1;
                initial_Pos(:, m) = [ini1; ini2; ini3];
                init_Out = [ini1; ini2; ini3];

                test_initial_pos;

                Out_test_m(:, :, m) = Out_test_history_dist;

                [D_m(:, m), conv_num_m(m), distance_tran_m(m), distance_conv_m(m), fixed_point_m(m)] = distance_curve(target, Out_test_m(:, :, m));
            end
        end
    end
end

mean_distance = mean(D_m, 2)';
mean_conv_num = mean(conv_num_m);
mean_distance_tran = mean(distance_tran_m);
mean_distance_conv = mean(distance_conv_m);
sum_fixed_point = sum(fixed_point_m);

fprintf('Convergence steps = %2.1f\n', mean_conv_num);
fprintf('Distance during transient period = %.4f\n', mean_distance_tran);
fprintf('Distance after convergence = %.5f\n', mean_distance_conv);
fprintf('Total number of convergence into a fixed point = %.2f\n', sum_fixed_point);
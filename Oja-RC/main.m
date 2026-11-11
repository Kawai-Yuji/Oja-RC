%% FORCE learning with Oja's plasticity
% Written by Yuji Kawai

% Y. Kawai, H. Atsuta, and M. Asada,
% "Embedding dynamical attractors in reservoir computing via Oja's plasticity for robust pattern generation"
% 2026.


clear;
close all;

%% task
taskname = '2d'; % 2d, 3d, or lorenz

PLOT = 1;


% parameter setting
param_Oja_RC;

% construct RNN
construct_Oja_RC;

% plasticity and training
train_Oja_RC;

% analyzing weights
weight_analysis;


if strcmp(taskname, '2d') || strcmp(taskname, '3d')

    % evaluating error
    test_error;

    % evaluating distance
    test_dist

    % plot
    if PLOT == 1
        plot_distance
        plot_trajectory
        plot_projected_state
    end

elseif strcmp(taskname, 'lorenz')

    % Lyapunov spectrum analysis
    lyapunov_spectrum;

    % plot
    if PLOT == 1
        plot_projected_state
    end

end
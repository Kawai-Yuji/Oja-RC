%% FORCE learning with Oja's plasticity
%% parameters and IO functions

%%%%% recurrent neural network %%%%%%
N = 500; %1000				        % network size of reservoir
tau = 1; %10                        % time constant
tau_c = 200;                        % centering time constant

g = 1.5;						    % gain of reservoir weights
g_in = 3.0;                         % input weight gain 
g_b = 0.2;                          % bias gain

eta = 7.9 * 10^-6; % 3.2 * 10^-6    % learning rate of Oja's rule
alpha = 0.01;                       % regularization parameter for RLS
sigma = 0.0;                        % feedback noise amplitude  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% params for calculating spectral radius
opts.disp= 0;
opts.tol = 1e-3;

% evaluation
CSdim = 5;                          % dimensions for cosine similarity
LSdim = 10;                         % top dimensions for Lyapunov spectrum calculation

% task intervals
if strcmp(taskname, '2d') || strcmp(taskname, '3d')

    Period = 300;                   % period of target
    interval_Oja = 5 * Period;
    interval_RLS = 3 * Period;
    interval_test_dist = Period;
    interval_test_error = 2 * Period;

elseif strcmp(taskname, 'lorenz')

    interval_Oja = 10000;
    interval_RLS = 10000;
    interval_test = 10000;

end

% numerics
dt = 1;					            % numerical integration time step
n_steps_Oja = fix(interval_Oja / dt);
n_steps_RLS = fix(interval_RLS / dt);
n_steps = n_steps_Oja + n_steps_RLS;

% target
if strcmp(taskname, '2d') || strcmp(taskname, '3d')

    n_steps_test_dist = fix(interval_test_dist / dt);
    n_steps_test_error = fix(interval_test_error / dt);

    numT = Period / dt;
    thetas = linspace(0, 2 * pi, numT);
    R = 0.75;

    if strcmp(taskname, '2d')

        K = 2;                      % output dimension

        xout = zeros(1, numT);
        yout = zeros(1, numT);
        for i = 1:length(thetas)
            xout(i) = R * cos(thetas(i));
            yout(i) = R * sin(thetas(i));
        end

        target = ones(K, n_steps);
        target(1, :) = repmat(xout, 1, n_steps/numT);
        target(2, :) = repmat(yout, 1, n_steps/numT);

    elseif strcmp(taskname, '3d')

        K = 3;                      % output dimension

        xout = zeros(1, numT);
        yout = zeros(1, numT);
        zout = zeros(1, numT);
        for i = 1:length(thetas)
            xout(i) = R * cos(thetas(i));
            yout(i) = R * sin(thetas(i));
            zout(i) = R * sin(thetas(i) * 2);
        end

        target = ones(K, n_steps);
        target(1, :) = repmat(xout, 1, n_steps/numT);
        target(2, :) = repmat(yout, 1, n_steps/numT);
        target(3, :) = repmat(zout, 1, n_steps/numT);
    end

elseif strcmp(taskname, 'lorenz')

        n_steps_test = fix(interval_test / dt);

        K = 3;                      % output dimension
        ds = 5;                     % coefficient of down sampling
        R = 1;
        discard = 3000;

        if n_steps_test > n_steps
            target_Out = zeros(K, n_steps_test);
            n_lorenz = n_steps_test + discard;
        else
            target_Out = zeros(K, n_steps);
            n_lorenz = n_steps + discard;
        end

        lorenz_raw = lorenz(n_lorenz, ds);

        [min_x, max_x] = bounds(lorenz_raw(1, (discard+1):n_lorenz));
        [min_y, max_y] = bounds(lorenz_raw(2, (discard+1):n_lorenz));
        [min_z, max_z] = bounds(lorenz_raw(3, (discard+1):n_lorenz));

        target(1, :) = ((lorenz_raw(1, (discard+1):n_lorenz) - min_x) / (max_x - min_x) - 0.5) * 2 * R;
        target(2, :) = ((lorenz_raw(2, (discard+1):n_lorenz) - min_y) / (max_y - min_y) - 0.5) * 2 * R;
        target(3, :) = ((lorenz_raw(3, (discard+1):n_lorenz) - min_z) / (max_z - min_z) - 0.5) * 2 * R;
end


% drawing
lwidth = 2;
lwidth2 = 1.5;
markersize = 15;
fsize = 10;
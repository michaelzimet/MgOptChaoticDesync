%% EBC for population level with multiple noise realizations
% Run multiple realizations of noise with the same intensity to generate error bars
addpath('./functions');
addpath('./functions/model_specific');

% Time parameters
Tend = 10.34;
Dt = t(2) - t(1); % constant time step was setted for optimal u computation
Tsim = 350 / Dt;  % number of simulation time steps
R = 1;
dt = Dt / R;      % time step for Brownian path
N = round(Tsim / dt); % number of discrete Brownian values

% Number of different noise realizations to run
num_realizations = 100; % Adjust as needed

% Prepare arrays to store results
u_squared_integrals = zeros(num_realizations, 1);
control_durations = zeros(num_realizations, 1);

% Setup simulation parameters (same for all realizations)
sim_data = struct(...
    'N', N, ...
    'M', 1, ...                     % Number of simulation paths
    'nNeurons', 100, ...            % Number of neurons in the population
    'Tsim', Tsim, ...               % Total simulation time steps
    'Dt', Dt, ...                   % Time step size
    'R', 1, ...                     % Ratio of simulation time step to control time step
    'D_noise', 0.7, ...             % Noise intensity (same for all realizations)
    'D_HJB', 0.7, ...               % Noise intensity for HJB (same as D_noise)
    'Vth', -30, ...                 % Voltage threshold for control application
    'Tth', 0, ...                   % Time threshold for control application
    'alpha', 0.04, ...              % Coupling strength (homogeneous)
    'Ibvec', 10 * ones(100, 1), ... % Bias current vector (baseline current)
    'umax', M ...                  % Maximum control input amplitude
);

% Define initial conditions
vspike = 44.8;       
nspike = 0.459;
IC = [vspike, nspike];  % Spike point initial condition

% Generate Alpha coupling matrix (same for all realizations)
alpha = sim_data.alpha;  % Homogeneous coupling strength from sim_data
Alpha = generate_alpha_matrix(1, alpha, 0, sim_data.nNeurons);
sim_data.alpha = Alpha;

% Select control signals (same for all realizations)
uu = uopt;
tt = t;

% Run simulations with different noise realizations
for i = 1:num_realizations
    fprintf('Running realization %d of %d...\n', i, num_realizations);
    % Run the no-plot version with the current realization seed
    [u_integral_result, control_duration] = EBC_p_no_plot(sim_data, IC, uu, tt, i);
    
    % Store the final U^2 value
    u_squared_integrals(i) = u_integral_result(2, end);
    control_durations(i) = control_duration;
end

% Calculate statistics
mean_u_squared = mean(u_squared_integrals);
std_u_squared = std(u_squared_integrals);
mean_control_duration = mean(control_durations);
std_control_duration = std(control_durations);

% Display results
fprintf('\nResults after %d realizations:\n', num_realizations);
fprintf('Mean U^2 integral: %.4f ± %.4f\n', mean_u_squared, std_u_squared);
fprintf('Mean control duration: %.4f ± %.4f ms\n', mean_control_duration, std_control_duration);

% Create figure with error bars
figure;
errorbar(1, mean_u_squared, std_u_squared, 'ko-', 'MarkerSize', 8, 'LineWidth', 1.5);
hold on;
% If you want to plot individual points
plot(ones(num_realizations, 1), u_squared_integrals, 'r.', 'MarkerSize', 12);
ylabel('U^2 Integral');
title(sprintf('U^2 Integral Across %d Noise Realizations (D = %.1f)', num_realizations, sim_data.D_noise));
set(gca, 'FontName', 'Times', 'FontSize', 16, 'FontWeight', 'Bold', 'XTick', []);
xlim([0.5, 1.5]);

% Save results to a file
results = struct(...
    'u_squared_integrals', u_squared_integrals, ...
    'control_durations', control_durations, ...
    'mean_u_squared', mean_u_squared, ...
    'std_u_squared', std_u_squared, ...
    'mean_control_duration', mean_control_duration, ...
    'std_control_duration', std_control_duration, ...
    'D_noise', sim_data.D_noise, ...
    'num_realizations', num_realizations ...
);

% Function to generate Alpha matrix based on the specified case
function Alpha = generate_alpha_matrix(alpha_case, alpha_mean, realization_seed, nNeurons)
    switch alpha_case
        case 1 % Symmetric matrix with all values the same
            Alpha = alpha_mean * ones(nNeurons);
            Alpha = Alpha - diag(diag(Alpha)); % Set diagonal to zero
            
        % case 2 % Normal distribution
        %     alpha_std = 0.2 * alpha_mean;
        %     randn('state', 150 * (realization_seed));
        %     temp = alpha_mean + alpha_std * randn(nNeurons*(nNeurons-1)/2, 1);
        %     if min(temp) < 0
        %         temp = temp - min(temp); % Avoiding negative alphas
        %     end
        %     Alpha = triu(ones(nNeurons), 1);
        %     Alpha(Alpha == 1) = temp;
        %     Alpha = Alpha + Alpha'; % Making Alpha symmetric
        % 
        % case 3 % Normal distribution with 20% zeros
        %     alpha_std = 0.2 * alpha_mean;
        %     randn('state', 150 * hrealization_seed);  % Changed to use realization_seed
        %     temp = alpha_mean + alpha_std * randn(nNeurons*(nNeurons-1)/2, 1);
        %     if min(temp) < 0
        %         temp = temp - min(temp); % Avoiding negative alphas
        %     end
        %     % Randomly set 20% of values to zero using the same seed
        %     rand('state', 150 * realization_seed);  % Use same seed for reproducibility
        %     zero_indices = randperm(length(temp), round(0.2*length(temp)));
        %     temp(zero_indices) = 0;
        %     Alpha = triu(ones(nNeurons), 1);
        %     Alpha(Alpha == 1) = temp;
        %     Alpha = Alpha + Alpha'; % Making Alpha symmetric
        % 
        % otherwise
        %     error('Invalid alpha case specified');
    end
end

save('noise_realizations_results.mat', 'results');
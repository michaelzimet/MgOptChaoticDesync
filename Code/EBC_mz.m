%% EBC for population level
% Simulates population dynamics with event-based control for the specific case
% of D = 0.7 and alpha_ij as a scalar value across all neurons. Outputs match
% the EBC_P function results as described in the paper.
% Relevant simulation parameters for EBC_p
addpath('/Users/michaelzimet/Library/CloudStorage/GoogleDrive-michaelzimet@ucsb.edu/My Drive/Grad School/Optimal Control/functions');
addpath('/Users/michaelzimet/Library/CloudStorage/GoogleDrive-michaelzimet@ucsb.edu/My Drive/Grad School/Optimal Control/functions/model_specific');

% Time parameters
Tend = 11.85;
% tInitial = 0;
% tPlotEnd = 802;
Dt = t(2) - t(1); % constant time step was setted for optimal u computation
Tsim = 350 / Dt;        % number of simulation time steps
% Dt = Tend / (tPlotEnd - 1);  % forward integration time step
R = 1;
dt = Dt / R;             % time step for Brownian path
N = round(Tsim / dt);    % number of discrete Brownian values
M_paths = 1;                   % number of paths sampled

sim_data = struct(...
    'N', N, ...
    'M', M_paths, ...                    % Number of simulation paths
    'nNeurons', 100, ...           % Number of neurons in the population
    'Tsim', Tsim, ...          % Total simulation time steps
    'Dt', Dt, ...       % Time step size
    'R', 1, ...                    % Ratio of simulation time step to control time step
    'D_noise', 0.7, ...            % Noise intensity (updated based on email)
    'Vth', -30, ...                % Voltage threshold for control application
    'Tth', 0, ...                  % Time threshold for control application
    'alpha', 0.04, ...             % Coupling strength (homogeneous)
    'Ibvec', 10 * ones(100, 1), ...% Bias current vector (baseline current)
    'umax', M ...                 % Maximum control input amplitude
);

%  vth_lower
%vth_upper 

vspike = 44.8;       
nspike = 0.459;

% Define initial conditions
IC = [vspike, nspike];  % Spike point initial condition

% Generate Alpha coupling matrix
alpha = sim_data.alpha;  % Homogeneous coupling strength from sim_data
Alpha = generate_alpha_matrix(1, alpha, 0, sim_data.nNeurons);

% Clear previous run data and close plots
close all;
clear uu tt param.D_HJB param.D_noise Vp_wcwn np_wcwn

% Set simulation parameters
sim_data.alpha = Alpha;
sim_data.D_noise = 0.7;  % Noise intensity for ODE (updated based on email)
sim_data.D_HJB = 0.7;    % Noise intensity for HJB (same as D_noise)

% Select control signals
% Using precomputed optimal input stored in uopt
uu = uopt;
tt = t;

% Run population simulation
[Vp_wcwn, np_wcwn, u_integral_plot] = EBC_p(sim_data, IC, uu, tt);

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

u2 = u_integral_plot(2, end);
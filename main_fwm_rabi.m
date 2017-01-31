% Prelim investigation to FWM in stim binary collision
% DKS 31/01/17

clear all; close all;

%%% USER INPUTS
% Path to configuration file
path_config='C:\Users\HE BEC\Documents\lab\stim_halo\FWM\mag_insensitive_pop_scan\config\config_310117.m';
% Path to log file with Bragg amplitude
path_log='C:\Users\HE BEC\Documents\lab\stim_halo\FWM\mag_insensitive_pop_scan\log_params.txt';

%%%%%%%%%%%%%%%%%%%%%%%%%% Override params here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
verbose=2;
% for ii=1:3  % no crop
%     configs.window{ii}=[];
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Main
% load configuration file
run(path_config);

% Load TXY data and crop to region of interest
[TXY,files_out]=loadExpData(configs,verbose);
nShot=size(TXY,1);

% Prepare Bragg amplitude params
% Load Bragg amplitude params from log file (experiment)
exp_config=load_logfile(path_log);

%% Capture coherently scattered orders
% Prepare box capture range
box_cent={...
    [2.791,2.693e-3,4.247e-3],...
    [2.804,2.748e-3,4.592e-3],...
    [2.817,2.913e-3,5.398e-3],...
    [2.831,2.968e-3,5.282e-3]...
    };      % centre of box - approx location scattered modes
box_hwidth={...
    [15e-4, 2e-3,   6e-3],...
    [4e-3,  4e-3,   12e-3],...
    [4e-3,  4e-3,   12e-3],...
    [15e-4, 2e-3,   6e-3]...
    };      % half widths for box around scattered modes

% create box edges
box_edge=cell(1,4);
for i=1:4
    for j=1:3
        box_edge{i}{j}=box_cent{i}(j)+box_hwidth{i}(j)*[-1,1];  % edges from centre and hw
    end
end

% Capture counts in each scat order
txy_scat_mode=cell(nShot,4);
for i_shot=1:nShot
    for i_ord=1:4
        txy_scat_mode{i_shot,i_ord}=boxcull(TXY{i_shot},box_edge{i_ord});
    end
end

%% Plot captured counts
colors='rgbk';
h_scat_modes=figure();
hold on;
for i=1:4
    plot_zxy(txy_scat_mode(:,i),10,colors(i));
end
title('Captured scattered modes');
xlabel('X [m]'); ylabel('Y [m]'); zlabel('T [s]');

% save plot
fname_str='scat_modes';
saveas(h_scat_modes,[configs.files.dirout,fname_str,'.fig']);
saveas(h_scat_modes,[configs.files.dirout,fname_str,'.png']);

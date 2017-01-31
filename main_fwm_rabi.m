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

%% Prepare Bragg amplitude params
% Load Bragg amplitude params from log file (experiment)
exp_config=load_logfile(path_log);

% FWM in stimulated collision
% DKS 30/01/17

clear all; close all;

%%% USER INPUTS
% Path to configuration file
path_config='C:\Users\David\Documents\hebec\fwm\mag_insensitive_pop_scan\config\config_300117.m';

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
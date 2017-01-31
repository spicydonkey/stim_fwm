% Config file for FWM in stimulated binary collision regime

%%% GENERAL
verbose=2;

%%% Raw data handling
% files -  data file
configs.files.path='C:\Users\HE BEC\Documents\lab\stim_halo\FWM\mag_insensitive_pop_scan\d';    % path to unindexed data file (e.g. 'a\b\datadir\$DATA_FNAME_TOKEN$')
configs.files.id=1:31;          % file id numbers to use for analysis
configs.files.minCount=100;     % min counts to use for analysis


% XY plane rotation to align to trap geometry
configs.rot_angle=0.61;     % angle in rad (exp default should be 0.61)

% TXY window - region of interest ( [] --> no crop )
%   XY window is applied after rotation
configs.window{1}=[2.78 2.835];      % T [s]
configs.window{2}=[-3e-3,8e-3];    % X [m]
configs.window{3}=[-8e-3,15e-3];    % Y [m]

%%% ALGORITHM CONFIGS
% DO NOT ADJUST
configs.files.saveddata=[configs.files.path,'_data.mat'];     % path to store saved data
configs.files.archive=[configs.files.path,'_archive'];   % dir to archive folder
configs.files.dirout=[configs.files.path,'_output\'];      % output directory

% create dir if necessary
if ~exist(configs.files.archive,'dir')
    warning('Archive directory %s does not exist. Creating directory...',configs.files.archive);
    mkdir(configs.files.archive);
end
if ~exist(configs.files.dirout,'dir')
    warning('Output directory %s does not exist. Creating directory...',configs.files.dirout);
    mkdir(configs.files.dirout);
end
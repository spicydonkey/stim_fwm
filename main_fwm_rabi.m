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

% vars to save to output
vars_save={'path_config','path_log',...
    'exp_config',...
    'TXY','files_out',...
    'box_cent','box_hwidth','box_edge',...
    'txy_scat_mode','pop_scat_mode',...
    'exp_id','bragg_amp'...
    };

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
pop_scat_mode=zeros(nShot,4);
for i_shot=1:nShot
    for i_ord=1:4
        % capture counts in set box
        txy_scat_mode{i_shot,i_ord}=boxcull(TXY{i_shot},box_edge{i_ord});
        
        % evaluate population in each mode
        pop_scat_mode(i_shot,i_ord)=size(txy_scat_mode{i_shot,i_ord},1);
    end
end

%%% Plot captured counts
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

%% Match shots with Bragg amplitude
% exp_config.id/bragg_amp <==> files_out.id_ok
% Create ordered file# to log index table
exp_id=zeros(max(exp_config.id),1);
counter=1;
for i=1:length(exp_config.id)
    exp_id(exp_config.id(i))=counter;
    counter=counter+1;
end

% Create matching ordered list of Bragg amplitudes
bragg_amp=zeros(size(nShot,1));
for i=1:nShot
    file_id=files_out.id_ok(i);     % file ID for this shot
    ind_log=exp_id(file_id);
    if ind_log==0   % check if Bragg amplitude was recorded for this shot
        warning('Bragg amplitude for file #%d is missing. Setting to NaN.',file_id);
        bragg_amp(i)=NaN;
    else
        bragg_amp(i)=exp_config.bragg_amp(ind_log);
    end
end



%% Save data
for i = 1:length(vars_save)
    if ~exist(vars_save{i},'var')
        warning(['Variable "',vars_save{i},'" does not exist.']);
        continue;
    end
    save(configs.files.saveddata,vars_save{i},'-v6','-append');     % -v6 version much faster (but no compression)?
end
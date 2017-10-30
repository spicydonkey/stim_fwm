%% Load data from a log-file
% 30/01/2017 DK Shin 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Log file format
%-------------------------------
% RAW_DLD_FILENAME.TXT, DATE_TIME, PARAM (line repeated)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT
% filedata: a struct with fields: id, date, bragg_amp
%
%-------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TODO
% 1. load multiple params
% 2. generalise output as a cell array

function filedata = load_logfile(path_to_log)
% check file exists
if exist(path_to_log,'file')~=2
    error('File %s does not exist.\nEnter a valid path to log file.',path_to_log);
end

% Read files
fid=fopen(path_to_log,'r');

data_cell=textscan(fid,'d%d%*s %s %f','Delimiter',',');

fclose(fid);    % close file

% structure output
filedata.id=data_cell{1};
filedata.date=data_cell{2};
filedata.bragg_amp=data_cell{3};
end
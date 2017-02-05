% Crop N X M-dim array to a box
% 
% DKS 31/01/17
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   * array_in      - N by M array (usage: N x data vectors of dim M)
%   * box_lim       - 1xM cell array of box limits for each dim
% OUTPUT
%   * array_out     - array of vectors within box
%   * ind_out       - indices of vectors (rows) in box
%   * n_out         - number of points captured
%   * cpos          - centre position (mean): [xc,yc,zc,...]
%   * se_cpos       - standard error of mean position
%   * sd_pos        - rms width of captured counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [array_out,ind_out,n_out,cpos,se_cpos,sd_pos] = boxcull(array_in,box_lim)
nvects=size(array_in,1);
ind_out=1:nvects;

array_out=array_in;         % initialise output

ndim=size(array_in,2);
for i=1:ndim
    if isempty(box_lim{i})  % pass crop if empty
        continue;
    end
    in_window=((array_out(:,i)>box_lim{i}(1))&(array_out(:,i)<box_lim{i}(2)));
    array_out=array_out(in_window,:);       % crop all remaining to this component
    ind_out=ind_out(in_window);             % update remaining data's parent indices
end

% evaluate number of captured counts
n_out=size(array_out,1);

% evaluate mean position of captured counts
cpos=mean(array_out,1);

% spread/width
sd_pos=std(array_out,1);        % rms width in each dim
se_cpos=sd_pos/sqrt(n_out);     % se

end
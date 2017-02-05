% Crop N X M array to hyper-ellipsoid
%
% DKS 5/2/17
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   * array_in      - N by M array (usage: N x data vectors of dim M)
%   * ellip_cent    - ellipsoid centre
%   * ellip_rad     - semi-princial axes params
% OUTPUT
%   * array_out     - array of vectors within box
%   * ind_out       - indices of vectors (rows) in box
%   * n_out         - number of points captured
%   * cpos          - centre position (mean): [xc,yc,zc,...]
%   * se_cpos       - standard error of mean position
%   * sd_pos        - rms width of captured counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [array_out,ind_out,n_out,cpos,se_cpos,sd_pos]=ellipsoidcull(array_in,ellip_cent,ellip_rad)
nvects=size(array_in,1);
ind_out=1:nvects;

% Capture ellipsoid
vects_0=array_in-repmat(ellip_cent,[nvects,1]);     % centre shifted vectors
meas_ellip=sum((vects_0.^2)./repmat(ellip_rad.^2,[nvects,1]),2);    % measure of ellipsoidal radius from ellipsoid equation
in_window=(meas_ellip<1);
array_out=array_in(in_window,:);
ind_out=ind_out(in_window);

% evaluate number of captured counts
n_out=size(array_out,1);

% evaluate mean position of captured counts
cpos=mean(array_out,1);

% spread/width
sd_pos=std(array_out,1);        % rms width in each dim
se_cpos=sd_pos/sqrt(n_out);     % se
    
end
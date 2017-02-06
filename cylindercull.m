% Crop N X M array to cylinder
%
% DKS 6/2/17
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   * array_in      - N by M array (usage: N x data vectors of length M)
%   * cyl_cent      - centre of cylinder
%   * cyl_dim       - [cyl_rad,cyl_hgt]
%   * cyl_orient    - longitudinal DIM: {1,...,M}
% OUTPUT
%   * array_out     - array of vectors within box
%   * ind_out       - indices of vectors (rows) in box
%   * n_out         - number of points captured
%   * cpos          - centre position (mean): [xc,yc,zc,...]
%   * se_cpos       - standard error of mean position
%   * sd_pos        - rms width of captured counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [array_out,ind_out]=cylindercull(array_in,cyl_cent,cyl_dim,cyl_orient)
[nvects,ndim]=size(array_in);
ind_out=1:nvects;

% capture cylinder
% get cylinder dims
cyl_rad=cyl_dim(1);
cyl_hgt=cyl_dim(2);

vects_0=array_in-repmat(cyl_cent,[nvects,1]);     % centre shifted vectors

% capture height
in_window=abs(vects_0(:,cyl_orient))<cyl_hgt/2;
vects_0=vects_0(in_window,:);       % update captured cyl centered vects
ind_out=ind_out(in_window);         % update capt'd indices
array_out=array_in(in_window,:);    % get counts capt'd by height

% capture radially (perpendicular to cylinder long-axis)
r_meas=sqrt(sum(vects_0(:,[1:cyl_orient-1,cyl_orient+1:end]).^2,2));
in_window=r_meas<cyl_rad;


end
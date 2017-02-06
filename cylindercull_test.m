% cylindercull test
% DKS 06/02/2017

XYZ=rand(10000,3);


% cylinder capture properties
cyl_rad=0.25;
cyl_hgt=0.5;
cyl_dim=[cyl_rad,cyl_hgt];  % build cylinder dimensions

cyl_orient=3;

cyl_cent=[0,0,0];


% call cylindercull
[XYZ_culled,ind_out]=cylindercull(XYZ,cyl_cent,cyl_dim,cyl_orient);


% Plot
figure();
% plot original point cloud
scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'b.');
hold on;

% capt'd counts
scatter3(XYZ_culled(:,1),XYZ_culled(:,2),XYZ_culled(:,3),'ro');
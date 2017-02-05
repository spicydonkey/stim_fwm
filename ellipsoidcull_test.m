% ellipsoidcull test
% DKS 5/2/17

XYZ=rand(1000,3);
ellip_cent=[0.5,0.5,0.5];
ellip_rad=[0.2,0.2,0.2];

[XYZ_culled,ind_out,n_out,cpos,se_cpos,sd_pos]=ellipsoidcull(XYZ,ellip_cent,ellip_rad);


figure();
scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'b.');
hold on;
scatter3(XYZ_culled(:,1),XYZ_culled(:,2),XYZ_culled(:,3),'ro');
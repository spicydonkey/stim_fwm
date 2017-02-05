% boxcull test
% DKS 31/01/17


XYZ=rand(10000,3);
boxlim={[0.33,0.66],[0.33,0.66],[0.1,0.9]};
[XYZ_culled,ind_out,n_out]=boxcull(XYZ,boxlim);

figure();
scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'b.');
hold on;
scatter3(XYZ_culled(:,1),XYZ_culled(:,2),XYZ_culled(:,3),'ro');
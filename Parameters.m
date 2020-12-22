set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

%----data params----
DataParams=struct;
DataParams.NumberOfDatapoints=5e2;  % Number of images to load
DataParams.start_at=100010;         % First image to load
DataParams.start_at=100001;         % First image to load
DataParams.sample_rate = 1;         % Frames subsampling 
DataParams.ResizeFac=0.5;           % Images resize factor
DataParams.DownloadLink='https://technionmail-my.sharepoint.com/:u:/g/personal/orikats_campus_technion_ac_il/EUcgi9yJrbVAmuLYUjfvioMBzMGEpS1Xt6KIUtauvjmS_A?e=dquKT4&download=1';

%----kernels construnction params----
NormFac=1;
% 0<NormFac<1 - global scale factor that eqauls to NormFac*(median of the pairwise distances)
% NormFac>1 - local scale factor thar equals to the median of the distances of the NormFac nearest neighbours
UseMutualScaleFac='None';
% UseMutualScaleFac='Mean' - use the same scale factor for each kernel, the mutual scale factor is set to be their mean 
% UseMutualScaleFac='Min' - use the same scale factor for each kernel, the mutual scale factor is set to be the lower scale factor
% UseMutualScaleFac='None' - use different scale factor for each kernel 
KernelsParams=v2struct(NormFac,UseMutualScaleFac);

%----eigenvalues flow diagram params---- 
NumberOfEigenVals=20; %Number of eigenvalues calculated at each point on the geodesic
NumberOfPointAlongTheGeodesicPath=200;% Number of points on the geodesic grid
TolFac=0;% Tolerance factor for fixed rank approximation
ShowLoadingBar=true;

Interpolator='Geodesic';
% Interpolator='Linear' - linear interpolation: (1-t)*K1+t*K2
% Interpolator='Geodesic' - geodesic interpolation: K1^(-1/2)*(K1^(1/2)*K2^(-1)*K1^(1/2))^t
% Interpolator='Harmonic' - Harmonic interpolation: K1^(1-t)*K2^t
EvfdParams=v2struct(NumberOfEigenVals,NumberOfPointAlongTheGeodesicPath,ShowLoadingBar);
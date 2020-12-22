clc;
clear all;
addpath('Utils\')

%% Load parameters
Parameters;

%% Donwnload, unzip and load data
if ~exist(fullfile(pwd,'Images'),'dir')
    disp('Downloading imaged folder')
    if ~exist('Images.zip','file')
        outfilename = websave('Images.zip',DataParams.DownloadLink)
        disp(sprintf('Finished downloading images to: %s',fullfile(pwd,'Images.zip')))
    end
    disp('Unzipping images folder')
    unzip('Images.zip')
    disp(sprintf('Finished downloading images to: %s',fullfile(pwd,'Images\')))
end

disp('Loading images from folder')
LoadImages;
disp(sprintf('Finished loading images from: %s',fullfile(pwd,'Images\')))

%% Generate datapoints and calculate kernels
v2struct(DataParams);
[D1,D2,A1,A2,K1,K2,Scale1,Scale2] = GetKernels(s1,s2,KernelsParams);

%% Calculate the eigenvales flow diagram
v2struct(EvfdParams);

switch Interpolator
    case 'Geodesic'
        [Dim] = EstimateKernelsDim(K1,K2,TolFac);
        Interpulator = @ (t) FixedGeodesic(K1,K2,t,Dim);
    case 'Linear'
        Interpulator = @ (t) (1-t)*K1+t*K2;
    case 'Harmonic'
        Interpulator = @ (t) K1^(1-t)*K2^t;
end

[EigenValuesMat,ColorsMat,tVec]=GetEvfd(EvfdParams,Interpulator);
figure();
ShowEvfd(EigenValuesMat,ColorsMat,tVec);
caxis([0,1]);
ylabel('$t$','FontSize',15);xlabel('$\log(\mu^t_i)$','FontSize',15);title('Eigenvalues flow diagram','FontSize',15);
xlim([log(min(EigenValuesMat(:))),log(max(EigenValuesMat(:)))]);set(gcf, 'Position', get(0, 'Screensize'));


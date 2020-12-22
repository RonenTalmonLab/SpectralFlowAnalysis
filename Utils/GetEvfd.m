function [EigenValuesMat,ColorsMat,tVec]=GetEvfd(EvfdParams,Interpulator,ColorVariable)
if nargin==2
    ColorVariable=1;
v2struct(EvfdParams);
tVec=linspace(0,1,NumberOfPointAlongTheGeodesicPath);
EigenValuesMat=[];
% ColorsMat=[];
if ShowLoadingBar
    f=waitbar(0,sprintf('Calculating eigenvalues flow diagram'));
else
    tmp=fprintf(sprintf('Calculating eigenvalues flow diagram'));
end
for t_ind=1:length(tVec)
    
    
    K=Interpulator(tVec(t_ind));
    
    [V,D]=eigs(K,NumberOfEigenVals);
    EigenVals=real(diag(D));[~,i]=sort(EigenVals,'descend');
    EigenVals=EigenVals(i)';V=real(V(:,i));
    
    EigenValuesMat=[EigenValuesMat;EigenVals(2:NumberOfEigenVals)];
%     ColorsMat=[ColorsMat;abs(corr(ColorVariable',V(:,2:NumberOfEigenVals)))];
    
    if ShowLoadingBar
        waitbar(t_ind/length(tVec),f,sprintf('Calculating eigenvalues flow diagram'));
    else
        fprintf(repmat('\b',1,(tmp)));
        tmp=fprintf(sprintf('Calculating eigenvalues flow diagram (%g%%)',100*t_ind/length(tVec)));
    end
end
if ShowLoadingBar
    close(f)
else
    fprintf(repmat('\b',1,(tmp)));
end
EigenValuesMat=EigenValuesMat';
ColorsMat=0*ones(size(EigenValuesMat));

end


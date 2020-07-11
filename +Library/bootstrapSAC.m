function [TimeBins,ymean,yall] = bootstrapSAC(inputdata,nStrap,percentData,deltaT,D,MaxLag,RemoveOnset,Fs)
% this function will bootstrap the Shuffled autocorrelograms (SACs) by
% sampling with replacement.

nTrials = size(inputdata,2);
nTrial2use = ceil(percentData/100*nTrials);

yall = {};
for iBoot = 1:nStrap
    trials2pick = randperm(nTrials,nTrial2use);
    tempSpikes = inputdata(trials2pick);
    [~,yall{iBoot}]=Library.SAC(tempSpikes,nTrial2use,deltaT,D,MaxLag,RemoveOnset,Fs); 
end
yall  = cell2mat(yall');
ymean = mean(yall);

dt = 1/Fs;
t = -MaxLag:dt:0:dt:MaxLag;         % make a time vector
Bins = round(deltaT*Fs);            % number of psth bins per psth bin
TimeBins = t(1:Bins:end);           % time vector for psth
TimeBins= TimeBins(1:end-1);      % Final time array
return

function [TimeBins,ymean,yall] = bootstrapSCC(inputdata,nStrap,percentData,deltaT,D,MaxLag,RemoveOnset,Fs)
% this function will bootstrap the Shuffled autocorrelograms (SACs) by
% sampling with replacement.

input1 = inputdata{1};
input2 = inputdata{2};
nTrials = size(input1,2);
nTrial2use = ceil(percentData/100*nTrials);

% Trials2pick
trials2pick1 = []; trials2pick2=[];
for i = 1:nStrap
    trials2pick1 = [trials2pick1; randperm(nTrials,nTrial2use)];
    trials2pick2 = [trials2pick2; randperm(nTrials,nTrial2use)];
end

y_all = {};
for iBoot = 1:nStrap
    tempSpikes1 = input1(trials2pick1(iBoot,:));
    tempSpikes2 = input2(trials2pick2(iBoot,:));
    
    [~,yall{iBoot}]=Library.SCC(tempSpikes1,tempSpikes2,nTrial2use,deltaT,D,MaxLag,RemoveOnset,Fs);
end
yall  = cell2mat(yall');
ymean = mean(yall);

dt = 1/Fs;
t = -MaxLag:dt:0:dt:MaxLag;         % make a time vector
Bins = round(deltaT*Fs);            % number of psth bins per psth bin
TimeBins = t(1:Bins:end);           % time vector for psth
TimeBins= TimeBins(1:end-1);      % Final time array
return
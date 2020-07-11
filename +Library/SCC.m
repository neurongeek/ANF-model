function [TimeBins,Height]=SCC(SpTrain1,SpTrain2,nTrials,deltaT,D,MaxLag,RemoveOnset,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function will calculate the shuffled autocorrelation, which is a
% all-order shuffled autocorrelogram. This is calculated using a same
% stimuli and multiple repetitions.
%
% Input:
% SpTrain1      Spike Train is a cell array with spike times in each cell for
%               each of the repitition of signal A.
% SpTrain2      Spike Train is a cell array with spike times in each cell for
%               each of the repitition of signal B.
% nTrials       Number of trials, this is equal to the number of cells in
%               the SpTrain input.
% delatT        time bin-width (in seconds) for calculating the histogram.
% D             Duration of the response (in seconds).
% MaxLag        Maxlimum delay to calculate the histogram for (in seconds).
% RemoveOnset   Time duration (in seconds) of the onset during which spikes
%               should be removed. This is done to remove the onset response
%               from calculating the shuffled autocorrelogram. It can be set
%               to zero if the onset spikes are also to be included.
% Fs            Sampling frequency used in the model.
%
% Output:
% TimeBins      Time interval bins for which the histogram is calculated.
% Height        Normalized frequency or the height for corresonding time
%               interval in the TimeBins output.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suyash N Joshi
% suyash@suyash-joshi.com
% Copenhagen, Denmark
% 11th August 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%

dt = 1/Fs;
if size(SpTrain1,2) ~= size(SpTrain2,2)
    error('Number of cells in SpTrain1 must be equal to Number of cells in SpTrain2.')
end

if size(SpTrain1,2) ~= nTrials
    error('Number of cells in SpTrain must equal to nTrials.')
end

% Make time vectors for histograms
t = -MaxLag:dt:0:dt:MaxLag; % make a time vector
Bins = round(deltaT*Fs);  % number of psth bins per psth bin
psthtimes = t(1:Bins:end); % time vector for psth

% Calculate the Shuffled autocorrelogram for SpTrain1 as standard
r = zeros(size(SpTrain1,2),length(psthtimes));
parfor iStandard = 1:size(SpTrain1,2)
    % Standard spike train
    tempStandardTrain =  SpTrain1{iStandard};
    % Remove onset spikes
    tempStandardTrain = tempStandardTrain(tempStandardTrain>RemoveOnset);
    
    %Comparison spike train
    CompTrain = cell2mat(SpTrain2);
    
    % Remove onset spikes from each response
    CompTrain = CompTrain(CompTrain>RemoveOnset);
    
    % Shuffle and calculate the histogram
    for iRefSpike = 1:size(tempStandardTrain,2)
        r(iStandard,:) =  r(iStandard,:) + histc(CompTrain - tempStandardTrain(iRefSpike),psthtimes);
    end
end

averageRate1 = cellfun(@length,SpTrain1);
averageRate1 = mean(averageRate1)/D;
nTrials1 = size(SpTrain1,2);

averageRate2 = cellfun(@length,SpTrain2);
averageRate2 = mean(averageRate2)/D;
nTrials2 = size(SpTrain2,2);

norm = nTrials1 * nTrials2 * averageRate1 * averageRate2 * deltaT * D;
r = sum(r,1)/norm;

TimeBins= psthtimes(1:end-1);
Height= r(1:end-1);
return
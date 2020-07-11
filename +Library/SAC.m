function [TimeBins,Height]=SAC(SpTrain,nTrials,deltaT,D,MaxLag,RemoveOnset,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function will calculate the shuffled autocorrelation, which is a
% all-order shuffled autocorrelogram. This is calculated using a same
% stimuli and multiple repetitions.
%
% Input:
% SpTrain       SpTrain is a cell array with spike times in each cell for
%               each of the repitition.
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
if size(SpTrain,2) ~= nTrials
    error('Number of cells in SpTrain must equal to nTrials.')
end

% Make time vectors for histograms
t = -MaxLag:dt:0:dt:MaxLag; % make a time vector
Bins = round(deltaT*Fs);  % number of psth bins per psth bin
psthtimes = t(1:Bins:end); % time vector for psth

% Calculate the Shuffled autocorrelogram
averageRate = [];
r = zeros(size(SpTrain,2),length(psthtimes));
parfor iStandard = 1:size(SpTrain,2)
    % Standard spike train
    tempStandardTrain =  SpTrain{iStandard};
    % Remove onset spikes
    tempStandardTrain = tempStandardTrain(tempStandardTrain>RemoveOnset);
    averageRate = [averageRate; size(tempStandardTrain,2)];
    
    %Comparison spike train
    CompTrain = SpTrain;
    CompTrain{1,iStandard} = []; % remove the standard pulse train
    CompTrain = cell2mat(CompTrain);
    
    % Remove onset spikes from each response
    CompTrain = CompTrain(CompTrain>RemoveOnset);

    % Shuffle and calculate the histogram
    for iRefSpike = 1:size(tempStandardTrain,2)
        r(iStandard,:) =  r(iStandard,:) + histc(CompTrain - tempStandardTrain(iRefSpike),psthtimes);
    end
end
averageRate = mean(averageRate)/D;
norm = nTrials * (nTrials-1) * averageRate^2 * deltaT * D;
r = sum(r,1)/norm;

TimeBins= psthtimes(1:end-1);
Height= r(1:end-1);
return
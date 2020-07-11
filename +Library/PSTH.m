function [x,y] = PSTH(Duration,SpTimes,Fs,BinWidth,nRuns)
% This function calculated x and y for plotting a peristimulus time
% histogram (PSTH) for a given data and time window.
%
% Duration       Stimulus duration in seconds
% SpTimes        Concatenated array of spike times for all the trials.
% Fs             Sampling frequency
% BinWidth       PSTH Bin width in second
%
% -------------------------------------------------------------------------
% Suyash N Joshi,
% Denmark
% 4th July 2015
% -------------------------------------------------------------------------
dt = 1/Fs;

%T = Duration*Fs; % Duration of stimulus
t = 0:dt:Duration-dt; % time vector

% Calculate PSTH
Bins = round(BinWidth*Fs);  % number of psth bins per psth bin
psthtimes = t(1:Bins:end); % time vector for psth
r = histc(SpTimes,psthtimes)./ (nRuns*BinWidth);
x= [psthtimes(1:end)];
y= [r(1:end)];
end

function [x,y] = aPSTH(Duration,SpTimes,Fs,PSTHtimes,nRuns)
% This function calculated x and y for plotting an adaptive peristimulus
% time histogram (PSTH) as described in Zhu et al (2007) JARO for a given
% data and time window.
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
% Bins = round(BinWidth*Fs);  % number of psth bins per psth bin
% psthtimes = t(1:Bins:end); % time vector for psth
psthtimes = PSTHtimes;
BinWidth = diff(psthtimes); BinWidth = [BinWidth, 0];

r = histc(SpTimes,psthtimes)./ (nRuns.*BinWidth)'; 
r(end-1) = r(end-2);
x = [0.5 * (psthtimes(1:end-1) + psthtimes(2:end))];
y= [r(1:end-1)];
end
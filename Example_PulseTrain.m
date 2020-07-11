clear; clc; close
% this is an example code to find out a threshold for a pulse train

%%%%%%%%%%%% Model params %%%%%%%%%%%%
Fs = 1e6;
NoiseAlpha = 0.8;

%%%%%%%%%%% Stimulus params %%%%%%%%%%%%
stim_rate = [100];
stim_duration = 1;
stim_PPD = 40e-6;
stim_IPG = 8e-6;
stim_leadingPol =-1;
stim_laggingPol =1;

% Threshold for a single pulse
SinglePulse = [0, stim_leadingPol*ones(1,stim_PPD*Fs),...
    zeros(1,stim_IPG*Fs),...
    stim_laggingPol*ones(1,stim_PPD*Fs), 0]; % make a single sample pulse

% Find out threshold for a single pulse
[Level,Probability]=Library.FindThreshold([SinglePulse, zeros(1,2000)],Fs,NoiseAlpha,0.0001e-6,@Model_SinglePulse,1000);
[muSingle,sigmaSingle]=Library.FitNeuronDynamicRange(Level',Probability);

% Make a pulse train and adjust level
Istim=Experiment.stim_PulseTrain(SinglePulse,stim_rate,100,0,stim_duration,Fs);
input = Istim * muSingle;

% make memebrane noise waveforms
p_noise = Library.oneonfnoise(length(input),NoiseAlpha);
c_noise = Library.oneonfnoise(length(input),NoiseAlpha);

% Run the model
[nspikes,SpTimes,pSpikes,cSpikes] = Model_PulseTrain(input,p_noise,c_noise,Fs);

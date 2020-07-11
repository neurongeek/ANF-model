function Istim=stim_PulseTrain(SinglePulse,Rate,ModFreqz,ModDepth,Duration,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function 'makePulseTrain' makes an array of the pulse train
% Input-
% SinglePulse           Array containing a single pulse
% Rate                      Pulse rate
% ModFreqz             Modulation frequency in Hz
% ModDepth            Modulation Depth
% Duration               Duration of the pulse train
% Fs                          Sampling frequency
%
% Output-
% Istim                     Istim is a pulse train array 
%
% Example:-
% SinglePulse = [0, -ones(1,40), ones(1,40), 0];
% Rate = 200;
% ModFreqz = 20;             
% ModDepth = 1;           
% Duration = 0.1;
% Fs = 1e6;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suyash Joshi,
% 26th July 2016
% Copenhagen, Denmark
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make a longer stimulus to avoid running into not enough samples
Duration = Duration + 0.01; 

% Total number of samples whos amplitude is zero
ZeroSamples = Fs - length(SinglePulse)*Rate ;
% Inter-pulse-interval
IPI = round(ZeroSamples/Rate);
% Make the pulse train 
SinglePulse = [SinglePulse, zeros(1,IPI)] ;
nrep = ceil((Duration*Fs)/length(SinglePulse));
Istim = repmat(SinglePulse,1,nrep);
Istim = Istim(1,1:ceil(Duration*Fs));
% make a modulator wave
dt = 0:1/Fs:Duration-1/Fs;
ModWave = 1- ModDepth*cos(2*pi*ModFreqz*dt);
% Make final stim
Istim = ModWave .* Istim;
Istim = Istim(1,1:ceil((Duration-0.01)*Fs));
end



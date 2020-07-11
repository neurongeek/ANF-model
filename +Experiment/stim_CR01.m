function Istim=stim_CR01(SinglePulse,Rate,percentNoise,ModFreqz,ModDepth,Duration,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function 'makeNoisyPulseTrain' makes an array of biphasic pulse train where
% the pulse trains which has randomly jittered amplitude from each pulse to
% the next. The pulse train is also modulated with a frequency, ModFreqz at
% modulation depth, ModDepth.
%
% Input-
% SinglePulse           Array containing a three values -
%                                   First is the pulse phase duration
%                                   Second is the inter-phase gap duration
%                                   Third is leading polarity (+1 or -1)
%                                   Fourth is lagging polarity (+1 or -1)
%                                   e.g. [100e-6, 10e-6, -1, +1];
% Rate                      Pulse rate
% percentNoise        Percent noise is the value r'described in Chatterjee
%                               and Robert, (2001).
%                               E.g. percentNoise = 0.05 means 5% noise,
%                               with range of -5 to +5 and mean 0. The
%                               level jitter has a uniform distribution.
% ModFreqz             Modulation frequency in Hz
% ModDepth            Modulation Depth
% Duration               Duration of the pulse train
% Fs                          Sampling frequency
%
% Output-
% Istim                     Istim is a pulse train array
%
% Example: -
% SinglePulse = [100e-6, 10e-6, -1, +1];
% Rate = 1000;
% ModFreqz = 20;
% ModDepth = 1;
% percentNoise = 5;
% Duration = 0.1;
% Fs = 1e6;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suyash Joshi,
% 26th July 2016
% Copenhagen, Denmark
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PPD = SinglePulse(1);
IPG = SinglePulse(2);

% make a longer stimulus to avoid running into not enough samples
Duration = Duration + 0.01;
one_pulse_duration = (PPD*Fs*2) + (IPG*Fs);

% Total number of samples whos amplitude is zero
ZeroSamples = Fs - (one_pulse_duration*Rate);
% Inter-pulse-interval
IPI = round(ZeroSamples/Rate);

% Number of pulses
nPulses=floor((Duration*Fs)/((PPD*Fs*2)+IPI+IPG*Fs));
PulseNumber = [1:1:nPulses];

% make noise
percentNoise = percentNoise/100;
NoiseRange = [1-percentNoise, 1+percentNoise];
noise = NoiseRange(1) + (NoiseRange(2)-NoiseRange(1)).*rand(nPulses,1);

% make modulation wave
ModWave=PPD*Fs*(1+ModDepth*cos(2*pi*ModFreqz*PulseNumber/Rate));
ModWave = round(ModWave);

Istim = [0];
for iNPulse = 1:nPulses
    temp_stamp = length(Istim) + 2*ModWave(iNPulse);
    Istim=[Istim,...
        ones(1,ModWave(iNPulse))*noise(iNPulse)*SinglePulse(3),...
        zeros(1,IPG*Fs),...
        ones(1,ModWave(iNPulse))*noise(iNPulse)*SinglePulse(4),...
        zeros(1,IPI)];
end
Istim = Istim(1,1:ceil((Duration-0.01)*Fs));
end



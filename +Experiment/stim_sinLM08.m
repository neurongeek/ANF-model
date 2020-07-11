function Istim = stim_sinLM08(SinglePulse,Rate,Jitter_k,ModFreqz,ModDepth,Duration,Fs)
% Input-
% SinglePulse           Array containing a three values -
%                                   First is the pulse phase duration
%                                   Second is the inter-phase gap duration
%                                   Third is leading polarity (+1 or -1)
%                                   Fourth is lagging polarity (+1 or -1)
%                                   e.g. [100, -1, +1];
% Rate                      Pulse rate
% Jitter_k                 Jitter_k is a inter pulse interval jitter
%                               scaling factor described in Majdak and
%                               Laback, 2008. The value of k can be 0 to 1.                        
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
% Jitter_k = 1;
% Duration = 0.2;
% Fs = 1e6;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suyash Joshi,
% 26th July 2016
% Copenhagen, Denmark
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Stimulus details %%
PPD = SinglePulse(1); % pulse phase duration
IPG = SinglePulse(2); % interphase gap duration

% make a longer stimulus to avoid running into not enough samples
Duration = Duration + 0.02; 

% Duration of a second pulse
one_pulse_duration = (PPD*Fs*2) + (IPG*Fs);
one_pulse = [0, SinglePulse(3)*ones(1,PPD*Fs),... % first phase
                    zeros(1,IPG*Fs),...
                    SinglePulse(4)*ones(1,PPD*Fs), 0];  % second phase
 
ZeroSamples = Fs - (one_pulse_duration*Rate); % Total number of samples whos amplitude is zero
IPI = round(ZeroSamples/Rate); % Inter-pulse-interval

nPulses=floor((Duration*Fs)/((PPD*Fs*2)+IPI+IPG*Fs));

jitter_range_low = fix(IPI*(1-Jitter_k));
jitter_range_high = fix(IPI*(1+Jitter_k));
% fix the jitter lower to 0 if negative
if jitter_range_low < 0
    jitter_range_low = 0;
end

% Make a modulator 
dt = 0:1/Fs:Duration;
ModWave = 1+ ModDepth*cos(2*pi*ModFreqz*dt);

Istim = [];
for iPulse = 1:nPulses
    idx_modulator = length(Istim) + ceil(one_pulse_duration/2); % index for modulator amplitude
    
    if idx_modulator > Duration*Fs
        idx_modulator = length(ModWave);
    end
    
    now_pulse = one_pulse * ModWave(idx_modulator); % Modulated pulse
    now_IPI= zeros(1,randi([jitter_range_low,jitter_range_high],1,1)); % jittered IPI
    
    Istim = [Istim, now_pulse, now_IPI]; % Build a pulse train
end
if length(Istim)<round(Duration*Fs)
    nlength_zeropad = round((Duration-0.02)*Fs) - length(Istim);
    Istim = [Istim, zeros(1,nlength_zeropad)];
end
Istim = Istim(1,1:round((Duration-0.02)*Fs));
end
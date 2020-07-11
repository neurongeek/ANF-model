function [Level,Probability,Latency,Jitter] = FindThreshold_Dynes1(Pulse,StimDetails,Fs,NoiseAlpha,StartLevel,fNeuron,nRuns)
delay = StimDetails(1);
FirstLevel = StimDetails(2);

MaxLevel = 0.1;
nConform = 4;
Lev = StartLevel;

%% 1st sweep
Yes = 0;
No = 0;
% Up sweep

while (Yes < nConform/2 && Lev < MaxLevel)
    Istim = [FirstLevel*Pulse zeros(1,delay) Lev*Pulse zeros(1,1000)]; % Stimulus waveform
    p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha);
    c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha);
    [Spike] = fNeuron(Istim,p_noise',c_noise',Fs); % run model
    if Spike == 1
        Yes = Yes + 1;
    end
    Lev = Lev + 50e-6;
end
Imax = Lev;
% Down sweep
while No < nConform
    Istim = [FirstLevel*Pulse zeros(1,delay) Lev*Pulse zeros(1,1000)]; % Stimulus waveform
    p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha);
    c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha);
    [Spike] = fNeuron(Istim,p_noise',c_noise',Fs); % run model
    if Spike == 0
        No = No + 1;
    end
    Lev = Lev - Lev/10;
    if Lev < 0
        error('Level reached to zero')
    end
end
Imin = Lev;

if Lev > MaxLevel;
    Level=[NaN];
    Probability=[NaN];
    Latency=[NaN];
    Jitter=[NaN];
    disp('****************************Highest level reached****************************')
    return
else
    %% Constant Stimuli
    range = Imax - Imin;
    StepSize = range/9;
    Levels = [Imin-StepSize:StepSize:Imax+StepSize];
    Prb = [];
    n = 50;
    for i = 1:length(Levels)
        input = [FirstLevel*Pulse zeros(1,delay) Levels(i)*Pulse zeros(1,1000)]; % Make stimulus
        temp1=zeros(1,n);
        for iRun = 1:n
            p_noise = Library.oneonfnoise(length(input),NoiseAlpha);
            c_noise = Library.oneonfnoise(length(input),NoiseAlpha);
            [temp1(iRun)] = fNeuron(input,p_noise',c_noise',Fs); % run model
        end
        Prb = [Prb, sum(temp1)/n];
    end
    Imax = max(Levels(find(Prb == 1,1,'first')));
    Imin = min(Levels(find(Prb == 0,1,'last')));
    if isempty(Imin)
        Imin = min(Levels);
    end
    
    if isempty(Imax)
        Imax = max(Levels);
    end
    %% fit psychometric function to model
    [mu,sigma,xtemp,ytemp]=Library.FitNeuronDynamicRange(Levels,Prb);
    Probs = [0.05, 0.15, 0.35, 0.5, 0.65, 0.80, 0.95];
    Levels = [];
    for id = 1:length(Probs)
        [index]= Library.FindClosetValue(Probs(id),ytemp);
        Levels = [Levels, xtemp(index)];
    end
    
    %%
    Prb = []; Lat =[];Jit =[];
    n = nRuns;
    for i = 1:length(Levels)
        % Make stimulus
        input = [FirstLevel*Pulse zeros(1,delay) Levels(i)*Pulse zeros(1,1000)];
        temp1 = nan(n,1); temp2 = nan(1,n);
        for iRun = 1:n
            p_noise = Library.oneonfnoise(length(input),NoiseAlpha);
            c_noise = Library.oneonfnoise(length(input),NoiseAlpha);
            [temp1(iRun), temp2(iRun)] = fNeuron(input,p_noise',c_noise',Fs); % run model
        end
        Prb = [Prb; sum(temp1)/n];
        Lat = [Lat; nanmean(temp2)];
        Jit = [Jit; nanstd(temp2)];
%                idx = (temp1(:,1)== 1);
%                 SpTimes = cell2mat({temp2{1,idx}}');
%                 if SpTimes
%                     Prb = [Prb; nansum(temp1)/n];
%                     Lat = [Lat; mean(SpTimes(:,1))];
%                     Jit = [Jit; std(SpTimes(:,1))];
%                 end
    end
    ZeroOut = Prb(:) == 0;
    [Level] = Levels(~ZeroOut);
    [Probability] = Prb(~ZeroOut); [Probability] = round(Probability,4);
    [Latency] = Lat(~ZeroOut);
    [Jitter] = Jit(~ZeroOut);
end

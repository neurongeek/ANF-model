function [Level,Probability,Latency,Jitter] = FindThreshold(Istim,Fs,NoiseAlpha,StartLevel,fNeuron,nRuns,dT)

MaxLevel = 1;
MinLevel = 0.001e-6;
nConform = 4;
Lev = StartLevel;

%% 1st sweep
Yes = 0;
No = 0;
%Up sweep
while (Yes < nConform/2 && Lev < MaxLevel)
    p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
    c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
    [Spike] = fNeuron(Istim*Lev,p_noise',c_noise',Fs); % run model
    if Spike > 0
        Yes = Yes + 1;
    end
    Lev = Lev + 50e-6;
end
Imax = Lev;
% Down sweep

while No < nConform
    p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
    c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
    [Spike] = fNeuron(Istim*Lev,p_noise',c_noise',Fs); % run model
    if Spike == 0
        No = No + 1;
    end
    Lev = Lev - Lev/10;
    if Lev < MinLevel
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
Levels = [Imin:StepSize:Imax+StepSize];
Prb = [];
n = 50;
for i = 1:length(Levels)
    input = Istim * Levels(i);
    temp1=zeros(1,n);
    %gpuArray(temp1); gpuArray(temp2);
    parfor iRun = 1:n
        p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
        c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
        temp1(iRun) = fNeuron(input,p_noise',c_noise',Fs); % run model
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
%% Constant Stimuli
range = Imax - Imin;
StepSize = range/5;
Levels = [Imin:StepSize:Imax+StepSize];
Prb = [];
n = 100;
for i = 1:length(Levels)
    input = Istim * Levels(i);
    temp1=zeros(1,n); 
    %gpuArray(temp1); gpuArray(temp2);
    for iRun = 1:n
        p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
        c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
        [temp1(iRun)] = fNeuron(input,p_noise',c_noise',Fs); % run model
    end
    Prb = [Prb, sum(temp1)/n];
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
    input = Istim * Levels(i);
    temp1=zeros(1,n); temp2=zeros(1,n); 
    %gpuArray(temp1); gpuArray(temp2);
    for iRun = 1:n
        p_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
        c_noise = Library.oneonfnoise(length(Istim),NoiseAlpha,1);
        [temp1(iRun), temp2(iRun)] = fNeuron(input,p_noise',c_noise',Fs); % run model
    end
    Prb = [Prb; sum(temp1)/n];
    Lat = [Lat; nanmean(temp2)];
    Jit = [Jit; nanstd(temp2)];
end
ZeroOut = Prb(:) == 0;

[Level] = Levels(~ZeroOut);
[Probability] = Prb(~ZeroOut);
[Latency] = Lat(~ZeroOut);
[Jitter] = Jit(~ZeroOut);
end


clear; clc; close
% this is an example code to find out a threshold for a single pulse. The
% function "Library.FindThreshold" takes the stimulus input along with
% other inputs such as the lowest stimulus level to test and number of
% trials for each stimulus level. The code will adaptively find out at what
% stimulus levels neurons is not responding and starts to respond and
% frame-in to the stimulus levels to build a firing efficiency curve. 

%% Model Parameters %%
Fs = 1e6; % Sampling frequency 
NoiseAlpha =0.8; 

%% Cathodic pulse %%
PPD = 40   ; % Pulse phase duration in microseconds
 
Istim = [0, -ones(1,PPD), zeros(1,1000)]; % Make a pulse with silence after it
[Level,Probability,Latency1,Jitter]=Library.FindThreshold(Istim,Fs,NoiseAlpha,0.0001e-6,@Model_SinglePulse,1000);

subplot(3,1,1)
plot(Level,Probability,'ko','MarkerFaceColor','Blue'); hold on
[muCathode,sigma,xtemp,ytemp]=Library.FitNeuronDynamicRange(Level',Probability);
plot(xtemp,ytemp,'b-')

subplot(3,1,2)
plot(Level,Latency1,'bo-','MarkerFaceColor','Blue','MarkerEdgeColor','k'); hold on

subplot(3,1,3)
plot(Level,Jitter,'bo-','MarkerFaceColor','Blue','MarkerEdgeColor','k'); hold on

%% Anodic pulse %%
pause(0.001)
[Level,Probability,Latency2,Jitter]=Library.FindThreshold(-Istim,Fs,NoiseAlpha,0.0001e-6,@Model_SinglePulse,1000);

subplot(3,1,1)
plot(Level,Probability,'ko','MarkerFaceColor','Green'); 
[muAnode,sigma,xtemp,ytemp]=Library.FitNeuronDynamicRange(Level',Probability);
plot(xtemp,ytemp,'g-')
set(gca,'xlim',[400e-6,900e-6])
title('Firing efficiency (FE) curve')
ylabel('p(firing)')

subplot(3,1,2)
plot(Level,Latency2,'go-','MarkerFaceColor','Green','MarkerEdgeColor','k'); 
set(gca,'xlim',[400e-6,900e-6])
title('Spike latency')
ylabel('seconds')

subplot(3,1,3)
plot(Level,Jitter,'go-','MarkerFaceColor','Green','MarkerEdgeColor','k')
set(gca,'xlim',[400e-6,900e-6])
title('Spike jitter')
ylabel('seconds')
xlabel('Stimulus level (Amps)')
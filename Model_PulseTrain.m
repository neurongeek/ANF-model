function [Spike, SpTimes, p_sptimes, c_sptimes, p_v, c_v] = Model_PulseTrain(Istim,p_Noise,c_Noise,Fs)
%% Two point neuron model function
% The point neurons are defined as a ordinary differential equation. The
% model includes exponential spiking initiation mechanisms as descibed in
% the exponential integrate-and-fire neuron.
%
%
% Suyash N. Joshi
% suyash@suyash-joshi.com
% Copenhagen, Denmark

%% Parameters %%
%%%%%%%%%%%%%%%%%%% Common parameters %%%%%%%%%%%%%%%%%%%
El = -0.0800;
Vt = -0.0700;
Vr = -0.0840;
vPeak = 0.024;
AbsRef = 5.0000e-04;
a1 = 0.0026;
a2 = 0.005;
b = 90e-06;
InhibitAlpha =  0.75;
%%%%%%%%%%%%%%%%%%% Peripheran node %%%%%%%%%%%%%%%%%%%
p_Cm = 856.96e-09;
p_gL = 0.0011;
p_Dt = 0.010;
p_tauw1 =400e-06;
p_tauw2 = 4500e-06;
p_RS = 0.062; 
p_Threshold = 543e-6;
p_Sigma = p_RS*p_Threshold;
%%%%%%%%%%%%%%%%%%% Central node %%%%%%%%%%%%%%%%%%%
c_Cm = 1772.4e-09;
c_gL = 0.0027;
c_Dt = 0.0030;
c_tauw1 = 250e-06;
c_tauw2 = 3000e-06;
c_RS = 0.075;
c_Threshold = 731e-6;
c_Sigma = c_RS*c_Threshold;
%% Model Computations %%
dt = 1/Fs;
Spike = 0;
SpTimes = [];
nt = length(Istim);
% Peripheral node
p_I = Istim * -1 ;
p_I(p_I<0) = InhibitAlpha * p_I(p_I<0);
p_t = 0:dt:length(p_I)/Fs;
p_v = zeros(1,length(p_t)); p_v(:) = El;  % membrane potential vector
p_sptimes=[];
p_Noise = p_Sigma*p_Noise;

% Central node
c_I = Istim;
c_I(c_I<0) = InhibitAlpha * c_I(c_I<0);
c_t = 0:dt:length(c_I)/Fs;
c_v = zeros(1,length(c_t)); c_v(:) = El;  % membrane potential vector
c_sptimes=[];
c_Noise = c_Sigma*c_Noise;

TimeSinceSpike = 1000;
SpikingNow=0;
ip = 0;

p_w1 = zeros(1,length(p_t)); p_w2 = zeros(1,length(p_t));
c_w1 = zeros(1,length(c_t)); c_w2 = zeros(1,length(p_t)); 

for idt = 2:nt
   
    % Calculate adaptation triggered adaptive current
    p_w1(idt) = p_w1(idt-1) + dt/p_tauw1*(a1*(p_v(idt-1)-El) - p_w1(idt-1));
    p_w2(idt) = p_w2(idt-1) + dt/p_tauw2*(a2*(p_v(idt-1)-El) - p_w2(idt-1));
    c_w1(idt) = c_w1(idt-1) + dt/c_tauw1*(a1*(c_v(idt-1)-El) - c_w1(idt-1));
    c_w2(idt) = c_w2(idt-1) + dt/c_tauw2*(a2*(c_v(idt-1)-El) - c_w2(idt-1));
    
    TimeSinceSpike = TimeSinceSpike+dt;
    if TimeSinceSpike < AbsRef %% If the neuron is in the absoulte refractory period
        p_v(idt) = (p_v(idt-1) + ...
            dt/p_Cm*(p_gL*(El-p_v(idt-1))  + ...
            p_gL*p_Dt*exp((p_v(idt-1)-Vt)/p_Dt) - ...
            p_w1(idt-1) - p_w2(idt-1) + p_Noise(idt)));
        
        c_v(idt) = (c_v(idt-1) + ...
            dt/c_Cm*(c_gL*(El-c_v(idt-1))  + ...
            c_gL*c_Dt*exp((c_v(idt-1)-Vt)/c_Dt) - ...
            c_w1(idt-1) - c_w2(idt-1) + c_Noise(idt)));
        
    else %% If neuron is not in the absolute refractory period
        p_v(idt) = (p_v(idt-1) + ...
            dt/p_Cm*(p_gL*(El-p_v(idt-1))  + ...
            p_gL*p_Dt*exp((p_v(idt-1)-Vt)/p_Dt) - ...
            p_w1(idt-1) - p_w2(idt-1) + ...
            p_I(idt-1) + p_Noise(idt)));
        
        c_v(idt) = (c_v(idt-1) + ...
            dt/c_Cm*(c_gL*(El-c_v(idt-1))  + ...
            c_gL*c_Dt*exp((c_v(idt-1)-Vt)/c_Dt) - ...
            c_w1(idt-1) - c_w2(idt-1) + ...
            c_I(idt-1) + c_Noise(idt)));
        
        if p_v(idt) > vPeak % if spike
            SpikingNow = 1;
            ip = idt-1 + (vPeak-p_v(idt-1))/(p_v(idt)-p_v(idt-1));   % estimate spike time
            p_sptimes =[p_sptimes, ip*dt];
        elseif c_v(idt) > vPeak % if spike
            SpikingNow = 1;
            ip = idt-1 + (vPeak-c_v(idt-1))/(c_v(idt)-c_v(idt-1));   % estimate spike time
            c_sptimes =[c_sptimes, ip*dt];
        else
            SpikingNow = 0;
        end
        
        if SpikingNow % if spike
            TimeSinceSpike = 0;
            SpTimes = [SpTimes, ip*dt];
            Spike = Spike + 1;
            
            % reset the membrane voltage
            p_v(idt) = Vr;
            c_v(idt) = Vr;
            
            %Update adptation parameters
            p_w1(idt) = p_w1(idt-1) + (ip-idt+1)*dt/p_tauw1*(a1*(p_v(idt-1)-El) - p_w1(idt-1));
            p_w2(idt) = p_w2(idt-1) + (ip-idt+1)*dt/p_tauw2*(a2*(p_v(idt-1)-El) - p_w2(idt-1))+ b;            
            c_w1(idt) = c_w1(idt-1) + (ip-idt+1)*dt/c_tauw1*(a1*(c_v(idt-1)-El) - c_w1(idt-1));
            c_w2(idt) = c_w2(idt-1) + (ip-idt+1)*dt/c_tauw2*(a2*(c_v(idt-1)-El) - c_w2(idt-1))+ b;

            SpikingNow = 0;
        end
    end
end
return


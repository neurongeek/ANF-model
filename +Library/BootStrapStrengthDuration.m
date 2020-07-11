function [A,C]=BootStrapStrengthDuration(nRuns,PercentData)
nRuns = 1000;
PercentData = 80;

%%%%%%%% Import data %%%%%%%%
[C39, A39] = Data.Miller1999(4,1);
[C26, A26] = Data.Miller1999(4,2);

%%%%%%%% Convert to amps %%%%%%%%
C39 = 1000*10.^(C39/20);%*1e-6;
A39 = 1000*10.^(A39/20);%*1e-6;
C26 = 1000*10.^(C26/20);%*1e-6;
A26 = 1000*10.^(A26/20);%*1e-6;

nPoints39 = ceil(length(C39) * PercentData * 0.01);
nPoints26 = ceil(length(C26) * PercentData * 0.01);
nPoints39 = nPoints26;

C.Rheo = [];
C.Chr = [];
A.Rheo = [];
A.Chr = [];
figure;
hold on
for iRun = 1:nRuns
    %% Cathodic
    tempX39 = 39*ones(1,nPoints39).*normrnd(1,0.00,1,nPoints39);
    tempY39 = C39(randperm(length(C39)));
    tempY39 = tempY39(1:nPoints39);
    tempX26 = 26*ones(1,nPoints26).*normrnd(1,0.00,1,nPoints26);
    tempY26 = C26(randperm(length(C26)));
    tempY26 = tempY26(1:nPoints26);
    tempX = [tempX39, tempX26];
    tempY = [tempY39, tempY26];
    tempX = [39 26];
    tempY = [mean(tempY39) mean(tempY26)];    
    [P] = polyfit(1./tempX,tempY,1); %P(1) = slope; P(2) = intercept;
    Chr= abs(P(1)/P(2));
    Rheo = abs(P(2));
%   
    
     if P(1) > 0 %&& P(1) > 0 && P(1)/P(2) > 100
         if Chr < 2000;
             C.Rheo = [C.Rheo, Rheo];
             C.Chr = [C.Chr, Chr];
%              plot(P(1)/P(2),P(2),'ko','MarkerFaceColor','r')
%              plot(normrnd(1,1),Chr,'kx'); 
         end
     end
    
    %% Anodic
    tempX39 = 39*ones(1,nPoints39).*normrnd(1,0.00,1,nPoints39);
    tempY39 = A39(randperm(length(A39)));
    tempY39 = tempY39(1:nPoints39);
    tempX26 = 26*ones(1,nPoints26).*normrnd(1,0.00,1,nPoints26);
    tempY26 = A26(randperm(length(A26)));
    tempY26 = tempY26(1:nPoints26);
    tempX = [tempX39, tempX26];
    tempY = [tempY39, tempY26];
    tempX = [39 26];
    tempY = [mean(tempY39) mean(tempY26)];   
    [P] = polyfit(1./tempX,tempY,1); %P(1) = slope; P(2) = intercept;
    Chr= abs(P(1)/P(2));
    Rheo = abs(P(2));
    
     
    
     if P(2) > 0 %&& P(1) > 0 && P(1)/P(2) > 100
         if Chr < 2000;
             A.Rheo = [A.Rheo, Rheo];
             A.Chr = [A.Chr, Chr];
             %plot(P(1)/P(2),P(2),'ko','MarkerFaceColor','b')
             %plot(normrnd(2,1),Chr,'ro');
         end
     end
     pause(0.000001)
end
figure('color','w')
x_values = [0:10:2000];
tempCChr = C.Chr(C.Chr<2000);
tempAChr = A.Chr(A.Chr<2000);

%% Cathodic chronaxie
C.plot.chr = subplot(2,2,1); hold on
set(C.plot.chr,'box','on',...
    'xlim',[0,1500],...
    'ylim',[0,50])
title('Cathodic Chronaxie')

N = histc(C.Chr,x_values);
bar(x_values,N,0.8,'r','EdgeColor','none')
pd = fitdist(tempCChr','lognormal');
y = pdf(pd,x_values);
plot(x_values,y*10000,'k','LineWidth',2)
[C.chronaxie,V] = lognstat(pd.mu,pd.sigma);


%% Anodic chronaxie
A.plot.chr = subplot(2,2,3); hold on
set(A.plot.chr,'box','on',...
    'xlim',[0,1500],...
    'ylim',[0,50])
title('Anodic Chronaxie')

N = histc(A.Chr,x_values);
bar(x_values,N,0.8,'r','EdgeColor','none')
pd = fitdist(tempAChr','lognormal');
y = pdf(pd,x_values);
plot(x_values,y*10000,'k','LineWidth',2)
[A.chronaxie,V] = lognstat(pd.mu,pd.sigma);

%% Cathodic Rheobase
C.plot.rheo = subplot(2,2,2); hold on
set(C.plot.rheo,'box','on',...
    'xlim',[0,500],...
    'ylim',[0,200])
title('Cathodic Rheobase')

N = histc(C.Rheo,x_values);
bar(x_values,N,0.6,'r','EdgeColor','none')
pd = fitdist(C.Rheo','lognormal');
y = pdf(pd,x_values);
plot(x_values,y*10000,'k','LineWidth',2)
[C.rheobase,V] = lognstat(pd.mu,pd.sigma);


%% Anodic Rheobase
A.plot.rheo = subplot(2,2,4); hold on
set(A.plot.rheo,'box','on',...
    'xlim',[0,500],...
    'ylim',[0,200])
title('Anodic Rheobase')

N = histc(A.Rheo,x_values);
bar(x_values,N,0.6,'r','EdgeColor','none')
pd = fitdist(A.Rheo','lognormal');
y = pdf(pd,x_values);
plot(x_values,y*10000,'k','LineWidth',2)
[A.rheobase,V] = lognstat(pd.mu,pd.sigma);

C
A

end
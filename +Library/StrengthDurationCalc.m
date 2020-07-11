function StrengthDurationCalc

% First column is pulse duration in micro seconds
% Second column is pulse strength in microamps
VS84_normal =      [24.69,      1430.76;
                    49.56,      817.94;
                    99.68,      463.19;
                    196.594,    285.56;
                    411.990,    137.85;
                    1000.67,    101.04;
                    2071.195,   97.41;
                    4965.02,    93.65];
            
VS84_impaired =    [24.63,      225.034;
                    48.80,      124.72;
                    98.1,       76.73;
                    194.81,     52.083;
                    490.54,     35.96;
                    994.1,      31.12;
                    1963.9,     33.343];

M99_cathodic =     [39.00,      542.63;
                    26.00,      903.62];
M99_anodic =       [39.00,      731.14;
                    26.00,      1122];
                
xtemp = [0:.001:0.1];

figure;

%% Cathodic
subplot(1,2,1); box on; hold on
cathodic = gca;
set(cathodic,'xlim',[0, 0.05],'ylim',[0, 1600])

% Van Den Honert and Stypulkowski, 1984 - normal cats
plot(1./VS84_normal(:,1),VS84_normal(:,2),'Ko',...
     'MarkerFaceColor','r')
p = polyfit(1./VS84_normal(:,1),VS84_normal(:,2),1);
ytemp = polyval(p,xtemp);
plot(xtemp,ytemp,'r-');
VS84_normal_rheobase = p(2)
VS84_normal_chronaxie = p(1)/p(2)

% Van Den Honert and Stypulkowski, 1984 - impaired cats
plot(1./VS84_impaired(:,1),VS84_impaired(:,2),'Kd',...
     'MarkerFaceColor','w') 
p = polyfit(1./VS84_impaired(:,1),VS84_impaired(:,2),1);
ytemp = polyval(p,xtemp);
plot(xtemp,ytemp,'k-');
VS84_impaired_rheobase = p(2)
VS84_impaired_chronaxie = p(1)/p(2)

% Miller et al, 1999 - cathodic
plot(1./M99_cathodic(:,1),M99_cathodic(:,2),'Ko',...
     'MarkerFaceColor','b') 
p = polyfit(1./M99_cathodic(:,1),M99_cathodic(:,2),1);
ytemp = polyval(p,xtemp);
plot(xtemp,ytemp,'k-');
M99_cathodic_rheobase = p(2)
M99_cathodic_chronaxie = p(1)/abs(p(2))

%set(cathodic,'Xscale','log')

%% Anodic
subplot(1,2,2); box on; hold on
anodic = gca;
set(anodic,'xlim',[0, 0.05],'ylim',[0, 1600])

% Miller et al, 1999 - anodic
plot(1./M99_anodic(:,1),M99_anodic(:,2),'Ko',...
     'MarkerFaceColor','b') 
p = polyfit(1./M99_anodic(:,1),M99_anodic(:,2),1);
ytemp = polyval(p,xtemp);
plot(xtemp,ytemp,'k-');
M99_anodic_rheobase = p(2)
M99_anodic_chronaxie = p(1)/abs(p(2))
return

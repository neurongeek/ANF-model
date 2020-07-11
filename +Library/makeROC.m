function [pFA,pHit,AUC] = makeROC(x,y)
% This function constructs a ROC curve for two distributions
% Suyash N Joshi
% suyash@suyash-joshi.com
% Copenhagen, Denmark


temp = [x; y];

CritRange = max(temp) - min(temp);   %list of criterion values

critList = min(temp):CritRange/100:max(temp);

pHit = zeros(length(critList),1);
pFA =  zeros(length(critList),1);

nTrials = length(x);

for critNum = 1:length(critList)
    criterion = critList(critNum);
    pHit(critNum) = sum(y>criterion)/nTrials;
    pFA(critNum) = sum(x>criterion)/nTrials;
end
AUC = -trapz(pFA,pHit); 

%plot(pFA,pHit,'.-');
return

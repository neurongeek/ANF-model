
function [mu,sigma,xtemp,ytemp]=FitNeuronDynamicRange(xdata,ydata)

x0 = [mean(xdata) std(xdata)];

f = inline('sum( (Library.PsyFcn(xdata,x(1),x(2)) - ydata).^2)','x','xdata','ydata');
[x, fval, exitflag] = fminsearch(f,x0,[],xdata,ydata); % find the minimum
mu = x(1);                            % return mu
sigma = x(2);

xtemp = [0.5*min(xdata):range(xdata)/100:1.5*max(xdata)];
ytemp = erfc(-(xtemp-mu)./(sqrt(2)*sigma))/2;
return
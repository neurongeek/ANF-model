function [X, Y, xunit, yunit] = Smith1997(FigNo,SubFigNo)

% This function provides the digitized data from publication of van den
% Honert and Mortimer, 1979. Output provides x and y data points digitized
% from the publication.
%
% FigNo         Figure number in the publication.
% SubFigNo      Sub figure number of that figure, In case sub figure doesn't
%               exist, a default value is 1. In case the publication lists
%               subfigures as a, b, c please use corresponding numerical
%               value, e.g. 1, 2, 3.
%
% Reference:
% van den Honert, C., & Mortimer, J. T. (1979). The response of
% the myelinated nerve fiber to short duration biphasic stimulating
% currents. Annals of biomedical engineering, 7(2), 117-125.
%
% Figures available -
% Fig 2 a, b, c     Anodic abolition thresholds
%
% -------------------------------------------------------------------------
% Suyash N Joshi,
% Denmark
% 19th January 2015
% -------------------------------------------------------------------------


% Check input arguments
InCount=nargin();
if InCount == 0
    error('Not enough input arguement. Please specify the figure number');
elseif InCount == 1
    if isnumeric(FigNo)
    else
        error('Input arguement "FigNo" must be numeric')
    end
    SubFigNo = 1;
elseif InCount == 2
    if isnumeric(SubFigNo)
    else
        error('Input arguement "SubFigNo" must be numeric')
    end
else
    error('Check the number of input arguements');
end

% Data
if FigNo == 4
    switch SubFigNo
        case 1 % IPG = 0 seconds
            X = [25	50	100	200	400	800	1600	2500	5000	7500	10000];
            Y = [44.893538	21.661359	10.451715	5.437046	2.899808...
                 1.36471	0.6923	0.486735	0.341884	0.279374	0.272136];

    end
    xunit = 'Phase duration (micro sec)';
    yunit = 'Threshold (microA)';

else
    error('Only figure 4(a) is digitized')
end

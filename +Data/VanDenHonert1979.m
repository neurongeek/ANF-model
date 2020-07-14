function [X, Y, xunit, yunit] = VanDenHonert1979(FigNo,SubFigNo)

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
if FigNo == 2
    switch SubFigNo
        case 1 % IPG = 0 seconds
            X = [100 100 100 100 100 102.867925 103.924528 106.037736 106.792453 110.113208...
                109.207547 109.207547 117.056604 113.433962 115.698113 110.264151 125.358491...
                114.188679 116.150943 118.113208 122.037736 133.207547 127.924528 140.90566...
                134.113208 148 140];
            Y = [2.831461 0.808989 5.258427 8.089888 12.94382 6.067416 21.842697 11.730337...
                26.292135 18.606742 31.146067 35.191011 27.910112 38.831461 41.662921 50.157303...
                50.561798 64.314607 68.764045 72.404494 105.97753 90.606742 132.26966 136.314607...
                169.88764 171.505618 190.11236];
            
        case 2 % IPG = 10e-6 seconds
            X = [100 100 100 100 107.191011 111.086142 113.333333 118.277154 118.876404...
                124.719101 124.419476];
            Y = [1.621622 4.864865 9.72973 17.432432 30.405405 33.648649 66.891892...
                66.486486 112.702703 152.837838 156.081081];
            
        case 3 % IPG = 20e-6 seconds
            X = [96.755409 100 100 103.831388 106.11558 111.224008 105.618095...
                106.97541 112.702454 117.88212 113.137084 118.482536 118.704894];
            Y = [24.34712 15.437234 8.124941 41.89139 37.444913 54.156527 54.09958 56.551376...
                68.393259 57.47484 76.118032 118.431138 149.721165];
    end
    xunit = 'Cathodic amplitude (% monophasic threshold)';
    yunit = 'Abolition threshold (% monophasic threshold)';

else
    error('Only figure 2 is digitized')
end

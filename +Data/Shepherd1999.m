function [X, Y, xunit, yunit] = Shepherd1999(FigNo,SubFigNo)

% This function provides the digitized data from publication of
% Shepherd and Javel, 1999. Output provides x and y data points digitized
% from the publication.
%
% FigNo         Figure number in the publication.
% SubFigNo      Sub figure number of that figure, In case sub figure doesn't
%               exist, a default value is 1. In case the publication lists
%               subfigures as a, b, c please use corresponding numerical
%               value, e.g. 1, 2, 3.
%
% Reference: 
% Shepherd, R. K., & Javel, E. (1999). Electrical stimulation of the 
% auditory nerve: II. Effect of stimulus waveshape on single fibre
% response properties. Hearing research, 130(1), 171-188.
%
% Figures available -
% Fig 9         Effect of second (anodic) phase duration on a threshold of
%               cathodic phase. Threshold is normalized with reference to
%               fiber's threshold for 40 microsecond symmetric biphasic
%               stimuli.
% 
% -------------------------------------------------------------------------
% Suyash N Joshi,
% Denmark
% 2nd February 2015
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
if FigNo == 5
    switch SubFigNo
        case 1 % 
            X = [50 60 80 100 120 140 160 180];
            Y = [0, -1.69401399999999, -3.69470199999999, -5.47637399999999, ...
                -7.24344199999999, -7.31649699999999, -7.79845199999999, ...
                -8.01754300000000];
            xunit = 'Duration of the inter-phase gap (IPG; micro second)';
            yunit = 'Normalized Threshold (dB)';
            
    end

elseif FigNo == 6    
    switch SubFigNo
        case 1 % 
            X = [0, 10, 20, 40, 80, 120, 160, 200];
            Y = [0, -0.443397977113607, -0.629123626728345, -0.874177612459495,...
                -1.17817857887129, -1.27142009008797, -1.43092635120963,...
                -1.46027422354449];
            xunit = 'Duration of the inter-phase gap (IPG; micro second)';
            yunit = 'Normalized Threshold (dB)';
            
    end
else
    error('Only figure 5 and 6 is digitized')
end
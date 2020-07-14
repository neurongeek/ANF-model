function [X, Y, xunit, yunit, Ymin, Ymax] = VanDenHonert1984(FigNo,SubFigNo)

% This function provides the digitized data from publication of
% van den Honert and Stypulkowski, 1984. Output provides x and y data points digitized
% from the publication.
%
% FigNo         Figure number in the publication.
% SubFigNo      Sub figure number of that figure, In case sub figure doesn't
%               exist, a default value is 1. In case the publication lists
%               subfigures as a, b, c please use corresponding numerical
%               value, e.g. 1, 2, 3.
%
% Reference: 
% 
%
% Figures available -
% Fig 9         
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
            X = [20 25 50 100 200 400 600 1000 2000];
            Y = [];
            Ymax = [1490.343397, 1287.6469, 690.00166, 452.313596,308.421545,...
                    281.301086, 227.64953, 199.97836, 152.30741];
            Ymin = [648.6688, 394.35292, 189.988, 102.33698, 81.72852, ...
                    68.01854, 51.00424, 29.98033, 22.29926];
            
            xunit = 'Duration of the signal(micro second)';
            yunit = 'Threshold (microA)';
            
    end

else
    error('Only figure 5 is digitized')
end
function [X, Y, xunit, yunit, Ymax, Ymin] = Miller2001(FigNo,SubFigNo)

% This function provides the digitized data from publication of
% Miller et al., 2001. Output provides x and y data points digitized
% from the publication.
%
% FigNo         Figure number in the publication.
% SubFigNo      Sub figure number of that figure, In case sub figure doesn't
%               exist, a default value is 1. In case the publication lists
%               subfigures as a, b, c please use corresponding numerical
%               value, e.g. 1, 2, 3.
%
% Reference:
% Miller, C. A., Robinson, B. K., Rubinstein, J. T., Abbas, P. J., &
% Runge-Samuelson, C. L. (2001). Auditory nerve responses to monophasic
% and biphasic electric stimuli. Hearing research, 151(1), 79-94.
%
% Figures available -
%
% Fig 9         Effect of second (anodic) phase duration on a threshold of
%               cathodic phase. Threshold is normalized with reference to
%               fiber's threshold for 40 microsecond symmetric biphasic
%               stimuli.
%
% -------------------------------------------------------------------------
% Suyash N Joshi,
% Denmark
% 20th January 2015
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
if FigNo == 9
    switch SubFigNo
        case 1 % Effect of duration of second anodic phase on threshold
            X = [0, 40, 100, 200, 500, 750, 1000, 2000, 4000];
            Y = [-4.515358, 0, -1.679181, -2.610922, -3.634812, -3.890785,...
                -4.064846, -4.249147, -4.453925];
            Ymin = [0, 0, -0.90971, -1.706985, -2.269165, -2.391823,...
                -2.432709, -2.565588, -2.678024];
            Ymax = [0, 0, -1.870528, -3.219761, -4.67121, -5.202726,...
                -5.335605, -5.744463, -6.081772];
            xunit = 'Duration of second phase (micro second)';
            yunit = 'Normalized Threshold (dB)';
            
    end
    
elseif FigNo == 7
    switch SubFigNo
        case 1 % Single fiber responses - 24 fibres (outliers excluded)
            X = [0.360964, 0.37133, 0.431454, 0.419014, 0.394135, 0.406575,...
                0.379623, 0.49365, 0.474991, 0.472918, 0.501943, 0.539261,...
                0.528895, 0.55792, 0.603531, 0.593165, 0.605605, 0.611824,...
                0.568287, 0.63463, 0.661582, 0.76317, 0.775609, 0.862685];
            Y = [0.626667, 0.664704, 0.678536, 0.75461, 0.7719, 0.809937,...
                0.8376, 0.733863, 0.657789, 0.841058, 0.899842, 0.851432,...
                0.834142, 1.017411, 1.010495, 1.020869, 1.045074, 1.062364,...
                1.128064, 1.131522, 1.242175, 1.038159, 1.256007, 1.062364];
            xunit = 'Monophasic thresholds (mA)';
            yunit = 'Biphasic thresholds (mA)';
            
        case 2 % Single fiber responses - 24 fibres (outliers excluded)
            X = [0.46, 0.47186, 0.477442, 0.51093, 0.52907, 0.531163, 0.520698,...
                0.517209, 0.548605, 0.566744, 0.569535, 0.590465, 0.569535,...
                0.565349, 0.58907, 0.620465, 0.638605, 0.64, 0.66093, 0.65814,...
                0.682558, 0.7, 0.726512, 0.74814];
            Y = [0.481356, 0.426695, 0.43178, 0.445763, 0.472458, 0.488983,...
                0.51822, 0.530932, 0.478814, 0.439407, 0.426695, 0.462288,...
                0.495339, 0.511864, 0.51822, 0.505508, 0.627542, 0.594492,...
                0.595763, 0.584322, 0.561441, 0.616102, 0.598305, 0.609746];
            xunit = 'Monophasic latency (ms)';
            yunit = 'Biphasic latency (ms)';
            
        case 3 % Single fiber responses - 24 fibres (outliers excluded)
            X = [49.261978, 46.859944, 38.151677, 50.626128, 54.298434, 55.007964,...
                66.808282, 80.577629, 70.80482, 57.818875, 56.645559, 61.101266,...
                89.632169, 96.233393, 79.915808, 93.66207, 105.77277, 109.176247,...
                83.380845, 106.583873, 143.652709, 140.418026];
            Y = [25.278435, 41.424735, 81.799806, 64.722217, 60.675049, 52.603594,...
                53.907738, 56.101649, 72.721643, 83.973379, 100.115442, 109.51392,...
                116.587989, 106.703105, 78.069565, 73.539381, 93.670141, 82.899727,...
                85.230068, 115.1847, 103.849919, 92.205839];
            xunit = 'Monophasic jitter (mu s)';
            yunit = 'Biphasic jitter (mu s)';
            
        case 4 % Single fiber responses - 24 fibres (outliers excluded)
            X = [2.177839, 2.868744, 3.139776, 2.902435, 3.768497, 3.808724,...
                3.835375, 4.223234, 4.645454, 4.598187, 4.601204, 4.527286,...
                5.389326, 5.55342, 6.547372, 5.650133, 5.692372, 6.679284,...
                6.319752, 7.477463, 7.405724, 14.930258, 4.823628, 5.076725];
            Y = [2.71512, 2.844297, 2.842275, 4.05305, 11.1215, 3.32984,...
                3.598308, 2.744633, 3.189261, 3.458282, 3.861261, 3.861812,...
                3.810601, 2.689928, 3.801958, 5.734106, 4.793454, 4.965,...
                6.311221, 6.257804, 3.258217, 7.769411, 3.949156, 4.842826];
            xunit = 'Monophasic RS (%)';
            yunit = 'Biphasic RS (%)';
    end
    
elseif FigNo == 8
    switch SubFigNo
        case 1
            X = [40, 100, 200, 500, 750, 1000, 2000, 4000];
            Y = [0, -1.804347, -3.195652, -4.673913, -5.173913, -5.413043, -5.73913, -6.065217;
                0, -1.869565, -3.043478, -3.956522, -4.282609, -4.434783, -4.32609, -4.608696;
                0, -1.565218, -2.217391, -3.021739, -3.152174, -3.304348, -3.45652, -3.456522;
                0, -1.608695, -2.695652, -3.369565, -3.608695, -3.760869, -3.847826, -3.934782;
                0, -0.891304, -1.739130, -2.260869, -2.413043, -2.434782, -2.586956, -2.717391;
                0, -1.673913, -2.782609, -4.239131, -4.195652, -4.391305, -4.869565, -4.956522;
                0, -1.913044, -3.108696, -4.239131, -4.739131, -4.956522, -4.978261, -4.891304;
                0, -1.586956, -2.826087, -3.760869, -4.086956, -4.260869, -4.586956, -5.130434;
                0, -1.521739, -2.500000, -3.369565, -3.456521, -3.673913, -3.869565, -4.000000;
                0, -1.239130, -2.108695, -2.826086, -2.913043, -2.978260, -3.086956, -3.217391];
            xunit = 'Anodic phase duration (mu s)';
            yunit = 'Normalized threshold (dB re apw = 40 mu s)';
    end
    
else
    error('Only figure 2 is digitized')
end
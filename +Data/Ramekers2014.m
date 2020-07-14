function [X, Y, xunit, yunit] = Ramekers2014(FigNo,SubFigNo)

% This function provides the digitized data from publication of
% Ramekers et al., 2014. Output provides x and y data points digitized
% from the publication.
%
% FigNo         Figure number in the publication.
% SubFigNo      Sub figure number of that figure, In case sub figure doesn't
%               exist, a default value is 1. In case the publication lists
%               subfigures as a, b, c please use corresponding numerical
%               value, e.g. 1, 2, 3.
%
% Reference:
% Ramekers, D., Versnel, H., Strahl, S. B., Smeets, E. M., Klis,
% S. F., & Grolman, W. (2014). Auditory-nerve responses to varied
% inter-phase gap and phase duration of the electric pulse stimulus as
% predictors for neuronal degeneration. Journal of the Association for
% Research in Otolaryngology, 15(2), 187-202.
%
% Figures available - Fig 9
% Effect of second (anodic) phase duration on a threshold of
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
        case 5 % Effect of IPG on threshold for 20 micro s PPD
            X = [2.1	10	20	30];
            Y = [22.176286	20.07053	19.153641	18.655213];
            xunit = 'Interphase gap (micro second) ';
            yunit = 'Normalized Threshold Charge (dB re 1 nC)';
            
        case 6 % Effect of IPG on threshold for 50 micro s PPD
            X = [2.1	10	20	30];
            Y = [20.447761	19.61194	19.134328	18.955224];
            xunit = 'Interphase gap (micro second) ';
            yunit = 'Normalized Threshold Charge (dB re 1 nC)';
            
        case 7 % Effect of IPG on dynamic range for 20 micro s PPD
            X = [2.1	10	20	30];
            Y = [26.637363	25.153846	24.956044	25.054945];
            xunit = 'Interphase gap (micro second) ';
            yunit = 'Dynamic range (dB)';
            
        case 8 % Effect of IPG on dynamic range for 50 micro s PPD
            X = [2.1	10	20	30];
            Y = [4.912519	5.092868	5.33161	5.406593];
            xunit = 'Interphase gap (micro second) ';
            yunit = 'Dynamic range (dB)';
            
        case 11 % Effect of IPG on latency for 20 micro s PPD
            X = [2.1	10	20	30];
            Y = [375	366.089109	363.861386	362.376238];
            xunit = 'Interphase gap (micro second) ';
            yunit = 'Latency (micro s)';
            
        case 12 % Effect of IPG on latency for 50 micro s PPD
            X = [2.1	10	20	30];
            Y = [392.537313	394.776119	395.522388	400.746269];
            xunit = 'Interphase gap (micro second) ';
            yunit = 'Latency (micro s)';            
    end
    
elseif FigNo == 6
    switch SubFigNo
        case 5 % 
            X = [20	25	30	35	40	45	50];
            Y = [22.059701	21.701493	21.104478	20.686567	20.567164	20.507463	20.507463];
            xunit = 'Pulse phase duration (micro second) ';
            yunit = 'Normalized Threshold Charge (dB re 1 nC)';
            
        case 6 % 
            X = [20	25	30	35	40	45	50];
            Y = [18.716418	18.716418	18.716418	18.776119	18.776119	18.776119	19.014925];
            xunit = 'Pulse phase duration (micro second) ';
            yunit = 'Normalized Threshold Charge (dB re 1 nC)';
            
        case 7 % 
            X = [20	25	30	35	40	45	50];
            Y = [4.119565	4.5	4.717391	4.934783	4.826087	4.934783	5.043478];
            xunit = 'Pulse phase duration (micro second) ';
            yunit = 'Dynamic range (dB)';
            
        case 8 % 
            X = [20	25	30	35	40	45	50];
            Y = [4.972973	5.351351	5.135135	5.189189	5.081081	5.351351	5.351351];
            xunit = 'Pulse phase duration (micro second) ';
            yunit = 'Dynamic range (dB)';
            
        case 11 %
            X = [20	25	30	35	40	45	50];
            Y = [373.869347	373.869347	377.638191	382.160804	385.929648	391.20603	392.713568];
            xunit = 'Pulse phase duration (micro second) ';
            yunit = 'Latency (micro s)';
            
        case 12 % 
            X = [20	25	30	35	40	45	50];
            Y = [361.49877	369.124618	373.747525	379.123418	387.49625	393.622128	399.748005];
            xunit = 'Pulse phase duration (micro second) ';
            yunit = 'Latency (micro s)';            
    end

else
    error('Only figure 5 and 6 is digitized')
end
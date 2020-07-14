function [X, Y, xunit, yunit, Ymin, Ymax] = Dynes1996(FigNo,SubFigNo)

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
% Reference: Dynes 1996
% 
%
% Figures available -
% Fig 9         
% 
% -------------------------------------------------------------------------
% Suyash N Joshi,
% Denmark
% 11th June 2015
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
if FigNo == 3.3
    switch SubFigNo
        case 1 % -2dB
            X = [88.049954	114.319758	163.790749	196.426773	242.072795	294.515256	357.044821	426.18347	498.557272	587.280311	699.433525	814.780258	949.92649	1104.927733	1282.928933	1484.145198	1714.970505	1988.636901	2305.192961	2658.057354	3070.348	3538.621577	];
            Y = [-8.008742	-7.558908	-7.586664	-6.209383	-4.10133	-2.808219	-2.301924	-1.851789	-1.148703	0.116559	-0.023168	0.258673	0.484447	0.42933	0.711612	0.460098	0.489822	0.632261	0.690691	0.608861	0.246417	0.193501	];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';
             
        case 2 % -0.9 dB
            X = [78.795533	273.263933	355.384826	417.081708	495.634376	594.486152	683.195313	794.918308	939.874082	1091.716502	1269.613616	1487.470558	1982.083329	2295.36954	2658.092049	3063.697281	3525.292382	];
            Y = [-10.594292	-10.227585	-8.934266	-5.055606	-2.666291	-2.356462	-1.034994	0.567668	1.130748	0.513547	1.217374	0.347709	0.463596	0.409591	0.468345	0.471195	0.755469	];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';      
        case 3 % -0.4 dB
            X = [92.117789	299.790481	355.544424	424.77328	492.21187	587.717469	692.768928	943.130051	1101.498288	1276.22964	1483.943967	1707.965896	1985.04092	2301.708004	2648.233933	3067.008762	3535.254583	];
            Y = [-11.128157	-10.817564	-9.580636	-9.49584	-2.160459	-1.653933	0.257816	1.299389	0.963265	1.133111	1.275086	2.147856	1.840668	1.44945	0.327761	0.415012	0.474508	];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';
             
        case 4 % -0.2 dB
            X = [92.221874	131.619641	200.910949	236.94866	358.016284	427.078604	505.249625	580.969604	682.806727	1101.248484	1276.014531	1483.930088	1714.699883	1985.033981	2298.403461	2651.240098	3063.551561	3538.52443	];
            Y = [-11.549703	-10.846848	-11.01498	-10.059222	-6.236351	-5.477082	-1.5421	-1.035712	0.538777	1.974974	2.004305	1.331292	1.585841	1.868771	1.47753	1.508112	1.061359	0.586944	];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';             
           
    end

elseif FigNo == 3.7
    switch SubFigNo
        case 1 % -1.1 dB
            X = [1945.243706	2172.72009	2447.498333	2749.102476	3070.151831	3467.769392	3913.007132	4416.231875];
            Y = [3.496302	3.391447	3.223721	2.301793	1.596336	1.198107	0.883653	1.058];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';
        case 2 % +0.1 dB
            X = [1934.088663	2171.022387	2426.309944	2738.341542	3061.073442	3496.459732	3893.425497	4357.820447	4916.561429	5514.026098	6235.512414	6976.004358	7905.749216	8834.933225	9916.541218	11160.10633	12489.03003	14091.76185];
            Y = [2.72815	2.609325	2.204178	1.715206	1.784888	1.302842	0.604333	0.37367	-0.101451	-0.220444	-0.025249	0.183903	0.162521	-0.117241	-0.110762	0.202905	0.502566	0.187574];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';
            
        case 3 % +2.8 dB
            X = [1927.711	2162.493	2426.33	2749.302	3094.21	3913.69	4369.274	4946.498	5549.58	6231.387	6988.12	7879.366	8844.42	9942.539	11124.142	12505.75	14049.235];
            Y = [2.702973	2.284925	2.020054	2.298308	1.086279	0.194147	0.500133	0.485669	-0.113781	-0.016921	-0.101189	0.280994	0.224388	0.29997	-0.0145	-0.036674	0.170808];
            
            xunit = 'Inter pulse interval (micro seconds)';
            yunit = 'Threshold (dB re single pulse)';    
    end
else
    error('Only figure 5 is digitized')
end
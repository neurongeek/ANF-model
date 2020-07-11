function sigma = NoiseAlpha2Sigma(NoiseAlpha)
a =       5.073; %  (4.705, 5.442)
b =       -2.61; %  (-2.91, -2.31)
c =      0.3265; %  (-0.03942, 0.6925)
d =    -0.00834; %  (-0.6009, 0.5842)
sigma = a*exp(b*NoiseAlpha) + c*exp(d*NoiseAlpha);
end

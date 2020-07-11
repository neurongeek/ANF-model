function [index]= FindClosetValue(Value,data)
% This function finds closest value to 'Value' in an array 'data'. The
% output gives an index for the data array identifing the level closest to
% 'Value'. C is the difference betwee

[c index] = min(abs(data-Value));
end

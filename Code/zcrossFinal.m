function [d,gamma_estimated,t] = zcrossFinal(x,y)
% Estimates warping using zero crossing method
% Inputs:
% x: input signal
% y: output signal
%
% Outputs:
%d: warping rate
%gamma_estimated: estimated warping function

%% find zero crossings
t = 1:length(y);
z2= crossing_tanweer(x);
z1= crossing_tanweer(y);

%% calculate warping function
d = zeros(1,numel(x));
for j=1:round(z1(1))
        d(j)=(z2(2)-z2(1))/(z1(2)-z1(1));
end
for i=2:min(numel(z1),numel(z2))
    for j=round(z1(i-1)):round(z1(i))
        d(j)=(z2(i)-z2(i-1))/(z1(i)-z1(i-1));
    end
end

gamma_estimated = cumsum(d);
end

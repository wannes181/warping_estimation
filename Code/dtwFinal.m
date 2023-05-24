function [gamma_estimated,t] = dtw_methodFinal(x,y,Fs,DownSampling,segments)
% Estimates warping using dynamic time warping
%Inputs:
% x: input signal
% y: output signal
% Fs: sampling frequency of output and input signal
% DownSampling: downsampling factor to reduce the load
% segments: amount of segments the signal wil be divided
%
% Outputs:
%gamma_estimated estimated warping function

Fs=Fs/DownSampling;

y=downsample(y,DownSampling);
x=downsample(x,DownSampling);
t=1:length(y); 
segment_length = round(min(numel(x),numel(y))/segments);

%% truncate signals
y=y(1:min(numel(x),numel(y)));
x=x(1:min(numel(x),numel(y)));

y=y(1:segment_length*floor(length(y)/segment_length));
x=x(1:segment_length*floor(length(x)/segment_length));

x_segmented = reshape(x,segment_length,[]).';
y_segmented = reshape(y,segment_length,[]).';

[~,i1,i2] = dtw(y_segmented(1,:),x_segmented(1,:));
for i=2:size(x_segmented,1)
    [~,i1_temp,i2_temp] = dtw(y_segmented(i,:),x_segmented(i,:));
    i1=[i1;i1(end)+i1_temp];
    i2=[i2;i2(end)+i2_temp];
end

% extract function
gamma_estimated = zeros(1,length(y));

for i = 1:length(y)
    gamma_estimated(i) = mean(i2(find(i1==i)));
end
end
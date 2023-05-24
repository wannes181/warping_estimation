[x,fs]=audioread('ConstanF800.wav');
x=x(12*fs:17*fs-1);
[y,fs]=audioread('setup2_800HzTrack2.wav');
y=y(12*fs:17*fs-1);

Fs = fs;
[d,gamma_estimated,t] = zcrossFinal(x,y);

figure;
plot(d);

figure;
plot(t/fs,t/fs-gamma_estimated/fs)
xlabel('Time (s)');
ylabel('$\gamma_0-\hat{\gamma}$');
title('relative warping');
close all;
clear;
clc;

% Import the file
load('ecgsignal.mat');

ecgsignal = mat;

[p,s,mu] = polyfit((1:numel(ecgsignal))',ecgsignal,6);
f_y = polyval(p,(1:numel(ecgsignal))',[],mu);

ecgsignal = ecgsignal - f_y;        % Detrend data

samples = 0:length(ecgsignal)-1;   % Sample Indices Vector
Fs = 500;                          % Sampling Frequency (Hz)
t = samples/Fs;                    % Time Vector (seconds)


% Filter Out Signal to remove noise
smoothECG = sgolayfilt(ecgsignal,7,21);

%% QRS Complex using findpeaks
[~,locs_Rwave] = findpeaks(smoothECG,'MinPeakHeight',0.2,'MinPeakDistance',100);
[~,locs_Swave] = findpeaks(-smoothECG,'MinPeakHeight',0.08,'MinPeakDistance',100);
[~,locs_Qwave] = findpeaks(-smoothECG,'MinPeakDistance',40);
locs_Qwave = locs_Qwave(smoothECG(locs_Qwave)>-0.066 & smoothECG(locs_Qwave)<1);

figure(1);
hold on;

title('ECG Signal')
xlabel('Samples')
ylabel('Voltage(mV)')

plot(smoothECG);   
plot(locs_Qwave,smoothECG(locs_Qwave),'rs','MarkerFaceColor','g')
plot(locs_Rwave,smoothECG(locs_Rwave),'rv','MarkerFaceColor','r')
plot(locs_Swave,smoothECG(locs_Swave),'rs','MarkerFaceColor','b')
legend('Smooth ECG signal','Q wave','R wave','S wave')

Fs = 500;



%% Computing Interbeat Interval in Seconds
InterBeatInterval = diff(locs_Rwave)/Fs;
InterBeatInterval = mean(InterBeatInterval)

%% Computing Heart Rate Based on Peak Interval of R Wave (Heart Rate per Minute)

heartRate = 60/InterBeatInterval

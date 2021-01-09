close all;
clear;
clc;

load('signal.mat')

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal 
t = (0:L-1)*T;        % Time vector 
t = t*1000;           % Time vector in milliseconds

%% Part 3.1 BandPass
bandpass_Signal = bandpass(Signal,[20 40],Fs);
figure(1)

hold on;

plot(t,Signal,'Color', uint8([17 17 17]));
plot(t,bandpass_Signal,'r');
ylabel({'Amplitude'});
xlabel({'Time(ms)'});
title('Bandpass vs Original Signal');
legend('Original Signal', 'Bandpass Signal');

hold off;

%% Part 3.2 Wavelet
[cfs,frq] = cwt(Signal,Fs);
tms = (0:numel(Signal)-1)/Fs;

figure(2)
subplot(2,1,1)
plot(tms,Signal)
axis tight
title('Signal and Scalogram')
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)
surface(tms,frq,abs(cfs))
axis tight
shading flat
xlabel('Time (s)')
ylabel('Frequency (Hz)')
set(gca,'yscale','log')


%% Part 3.3

load('signals.mat')

fs=500;
minF = 2;
maxF = 150;
generated_points = 99;

lfp1 = lfp1(1:5000);

stepSize = (maxF-minF)/generated_points;
coeffs1 = morlet_wavelet(lfp1,fs,[minF:stepSize:maxF]);

tms1 = (0:numel(lfp1)-1)/fs;

figure(3)
subplot(2,1,1)
plot(tms1,lfp1)
axis tight
title('LFP1 Signal and Scalogram')
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)
surface(tms1,[minF:stepSize:maxF],abs(coeffs1))
axis tight
shading flat
xlabel('Time (s)')
ylabel('Frequency (Hz)')
set(gca,'yscale','log')
colorbar;


%% Part 3.4

part4=sacc_end;
part4(:,:,2)=0;
part4(:,:,3)=0;

% for n = 1:legnth(sacc_end)
%     sampleStart = (sacc_end(n)*Fs*1000 - 200);
%     sampleStop = (sacc_end(n)*Fs*1000 + 300);
%     
%     snippet = Signal(sampleStart:sampleStop);
%     
%     [cfs1,frq1] = cwt(snippet,Fs*1000);
%     %tms1 = (0:numel(snippet)-1)/(Fs*1000);
%     
%     part4(n,1,2) = frq1;
%     part4(n,1,3)=
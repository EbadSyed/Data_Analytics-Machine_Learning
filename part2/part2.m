close all;
clear;
clc;

%% Part 2.1
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal 
t = (0:L-1)*T;        % Time vector 
n = 1024;

% 3*sin(2*pi*f1*t) f1=60Hz and t=[0:10]

Y1 = 3*sin(2*pi*60*t); 

% 5*sin(2*pi*f2*t+theta2) f2=25z ,t=[2:6], theta2 = 0.5pi
Y2 = 5*sin(2*pi*25*t+0.5*pi); 

for i = 1:length(t)
    if i < 2000 || i > 6000
        Y2(i)=0;
    end
end

% 4*sin(2*pi*f3*t+theta3)*sin(2*pi*f4*t+theta4) f3=100Hz,theta3 = pi,f4=250Hz,theta3 = pi/3, t=[5:8]

Y3 = 4*(sin(2*pi*100*t+pi)).*(sin(2*pi*250*t+(pi/3))); 

for i = 1:length(t)
    if i < 5000 || i > 8000
        Y3(i)=0;
    end
end

% Gaussian White Noise
mu=0;sigma=1;
noise = sigma*randn(1,L)+mu;

% Combined Signal
Signal = Y1+Y2+Y3+noise;

% Plot Signal in Time Domain
hold on;
figure(1);
sgtitle('Signals in Time Domain');
subplot(5,1,1)
plot(t,Y1)
title(['Signal 1'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

subplot(5,1,2)
plot(t,Y2)
title(['Signal 2'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

subplot(5,1,3)
plot(t,Y3)
title(['Signal 3'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

subplot(5,1,4)
plot(t,noise)
title(['Noise'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

subplot(5,1,5)
plot(t,Signal)
title(['Combined Signal'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});
hold off;

%% Part 2.2
% Compute the Fourier transform of the signals.
Y = fft(Signal,n);

% Calculate the double-sided spectrum
P2 = abs(Y/L);

% Calculate the single-sided spectrum
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);

% Single-sided amplitude spectrum plot
figure(2);
plot(0:(Fs/n):(Fs/2-Fs/n),P1(1:n/2))
title(['Single-sided Amplitude Spectrum'])
xlabel('f (Hz)')
ylabel('|P1(f)|')

%% part 2.3 

% Resample at 100Hz

Resample100 = resample(Signal,1,10);
Resample500 = resample(Signal,1,2);

figure(3);
sgtitle('Resampled Signals');
subplot(3,1,1)
plot(t,Signal)
title(['Original Signal'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

t2 = (0:(length(Resample100)-1))*10/(1*Fs);
subplot(3,1,2)
plot(t2,Resample100)
title(['Resample 100 Hz'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

t3 = (0:(length(Resample500)-1))*2/(1*Fs);
subplot(3,1,3)
plot(t3,Resample500)
title(['Resample 500 Hz'])
ylabel({'Amplitude'});
xlabel({'Time(s)'});

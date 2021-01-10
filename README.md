# Data Analytics and Machine Learning

This project has been done to satisfy the Bioelectronic Data Analytics and 
Machine Learning module for Special Topics Course : Bioengineering at New
York Tech.

# Matlab Coding Basics 

## Data Extraction

Extracting complete rows from tabular data using keyword search in columns

```
%Bikes Data Extraction
Bikes = {};

n = 1;

% Iterate through Cell Array to Extract Bike Data
for c = 1:row
    if strcmp(example{c,3},'Bike')
        Bikes(n,:) = example(c,:);
        n=n+1;
    end
end

[row, column] = size(Bikes);
```
## Alphabetic Sort
```
sortrows
```

## Mean and Standard Deviation
![mean](part1/mean.png)

# Signal Processing

## Signal Generation
![signals](part2/signals.png)

## Power Spectrum

```
% Compute the Fourier transform of the signals.
Y = fft(Signal,n);

% Calculate the double-sided spectrum
P2 = abs(Y/L);

% Calculate the single-sided spectrum
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
```
![image](part2/power.png)

## Resampling
![image](part2/resample.png)

# ECG Signal Processing

## Filtering
```
smoothECG = sgolayfilt(ecgsignal,7,21);
```

## QRS Detection
```
[~,locs_Rwave] = findpeaks(smoothECG,'MinPeakHeight',0.2,'MinPeakDistance',100);
[~,locs_Swave] = findpeaks(-smoothECG,'MinPeakHeight',0.08,'MinPeakDistance',100);
[~,locs_Qwave] = findpeaks(-smoothECG,'MinPeakDistance',40);
locs_Qwave = locs_Qwave(smoothECG(locs_Qwave)>-0.066 & smoothECG(locs_Qwave)<1);
```
![image](part2/QRS.png)

# Wavelet Analysis

## Bandpass Filter
![image](part3/bandpass.png)

## Wavelet
```
[cfs,frq] = cwt(Signal,Fs);
tms = (0:numel(Signal)-1)/Fs;
```

### Scalogram Plot for Wavelet Analysis
![image](part3/scalogram.png)

### Morlet Wavelet Analysis for Local Field Potential
![image](part3/lfp.png)

# Machine Learning

## Linear Regression
```
% independent variable
x = linspace(0, 3, 101)';
% dependent variable with noise (training data)
y = x.^2 -2*x + randn(101, 1);
```
![image](part4/linear.png)

## SVM Classifier

```
% Data
X3 = [mvnrnd([-1; -1], 0.5*eye(2, 2), 25); mvnrnd([0; 0], 0.5*eye(2, 2), 25); mvnrnd([1; 1],0.5*eye(2, 2), 25)];
X3test = [mvnrnd([-1; -1], 0.5*eye(2, 2), 25); mvnrnd([0; 0], 0.5*eye(2, 2), 25); mvnrnd([1; 1],0.5*eye(2, 2), 25)];

y3 = [-ones(25, 1); ones(25, 1); -ones(25, 1)];
y3test = y3;


%Train the SVM Classifier
c3 = fitcsvm(X3,y3,'KernelFunction','rbf',...
    'BoxConstraint',Inf,'ClassNames',[-1,1]);

% Predict scores over the grid
d = 0.01;
[x1Grid,x2Grid] = meshgrid(min(X3(:,1)):d:max(X3(:,1)),...
    min(X3(:,2)):d:max(X3(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(c3,xGrid);

% Predict scores over the grid on X3Test
d = 0.01;
[x11Grid,x22Grid] = meshgrid(min(X3test(:,1)):d:max(X3test(:,1)),...
    min(X3test(:,2)):d:max(X3test(:,2)));
xxGrid = [x11Grid(:),x22Grid(:)];
[~,scoresTest] = predict(c3,xxGrid);

```
#### Data 1
![image](part4/svm1.png)

#### Data 2
![image](part4/svm2.png)

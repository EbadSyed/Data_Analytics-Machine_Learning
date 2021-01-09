close all;
clear;
clc;

%% Part 4.1 Create a regression model for the following data set:

% independent variable
x = linspace(0, 3, 101)';
% dependent variable with noise (training data)
y = x.^2 -2*x + randn(101, 1);

b1 = x\y;
yCalc1 = b1*x;

figure(1);
hold on;
ax = gca;
scatter(x, y);
plot(x,yCalc1);
hold off;


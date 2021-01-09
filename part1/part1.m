close all;
clear;
clc;

%% Part 1.1 

% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 6);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A1:F46";

% Specify column names and types
opts.VariableNames = ["Region", "Salesperson", "Product", "Brand", "RegPrice", "Discount"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "char"];

% Specify variable properties
opts = setvaropts(opts, ["Region", "Salesperson", "Product", "Brand", "RegPrice", "Discount"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Region", "Salesperson", "Product", "Brand", "RegPrice", "Discount"], "EmptyFieldRule", "auto");

% Import the data
example = readtable("example.xlsx", opts, "UseExcel", false);

%% Convert to output type
example = table2cell(example);
numIdx = cellfun(@(x) ~isnan(str2double(x)), example);
example(numIdx) = cellfun(@(x) {str2double(x)}, example(numIdx));

%% Clear temporary variables
clear opts

[row , ~] = size(example);

%% Bikes Data Extraction
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

%% Part 1.2
n = 1;
for c = 1:row
    if strcmp(Bikes{c},'East') || strcmp(Bikes{c},'West')
        Bikes_East_West(n,:) = Bikes(c,:);
        n=n+1;
    end
end

%% Part 1.3

Bikes_Sorted = sortrows(Bikes,4);
        
%% Part 1.4
n = 1;
for c = 1:row
    if strcmp(Bikes{c},'East') || strcmp(Bikes{c},'Northeast') || strcmp(example{c},'Southeast')
        Bikes_East(n,:) = Bikes(c,:);
        n=n+1;
    end
end

n = 1;
for c = 1:row
    if strcmp(Bikes{c},'West') || strcmp(Bikes{c},'Northwest') || strcmp(example{c},'Southwest')
        Bikes_West(n,:) = Bikes(c,:);
        n=n+1;
    end
end

% Convert to Numerical Values
Bikes_EastArray = cell2mat(Bikes_East(:,5));
Bikes_WestArray = cell2mat(Bikes_West(:,5));

% Mean Calculation
Bikes_Mean(1) = mean(Bikes_EastArray);
Bikes_Mean(2) = mean(Bikes_WestArray);

% Standard Deviation Calculation
Bikes_STD(1) = std(Bikes_EastArray);
Bikes_STD(2) = std(Bikes_WestArray);

%% Part 1.5 

X = categorical({'East/NE/SE', 'West/NW/SW'});
bar(X,Bikes_Mean)

hold on
% Create ylabel
ylabel({'Mean Price $'});

% Create xlabel
xlabel({'Region'});

% Create title
title({'Mean Price and Standard Deviation'});

% Add Error Bar
er = errorbar(Bikes_Mean,Bikes_STD);   
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

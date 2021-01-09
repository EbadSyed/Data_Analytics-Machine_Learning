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

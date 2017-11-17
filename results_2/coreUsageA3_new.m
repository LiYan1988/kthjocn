close all;
clc;
clear;

load coreUsage
histCell = [];
for i=1:22
    histCell = [histCell; coreUsage{i}]; 
end
a = sum(histCell, 2);
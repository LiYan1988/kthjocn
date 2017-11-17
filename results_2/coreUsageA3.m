close all;
clc;
clear;

load coreUsage
histCell = cell(1,22);
edgeCell = cell(1, 22);
binsCell = cell(1, 22);
for i=1:22
    [k, edges, bins] = histcounts(coreUsage{i}, 'normalization', 'probability');
    histCell{i} = k;
    edgeCell{i} = edges;
    binsCell{i} = bins;
end
hist = zeros(2, 22);
for i=1:22
    hist(:, i) = histCell{i}';
end
hist = hist';
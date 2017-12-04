function [mouseConnection, mouseThroughput, elephantConnection, elephantThrought, beta] = extractClassData(filePath, flowAverage, numberTrafficMatrix)
% Take average over all traffic matrices

mouseConnection = cell(1, numberTrafficMatrix); 
mouseThroughput = cell(1, numberTrafficMatrix);
elephantConnection = cell(1, numberTrafficMatrix);
elephantThrought = cell(1, numberTrafficMatrix);

for n=1:numberTrafficMatrix
    [mouseConnection{n}, mouseThroughput{n}, ...
        elephantConnection{n}, elephantThrought{n}, beta] = extractClassDataPerBeta(filePath, flowAverage, n-1);
end

% assume all the arrays have the same number of rows, the number of beta is
% the same for all simulations
mouseConnection = mean(cell2mat(mouseConnection), 2);
mouseThroughput = mean(cell2mat(mouseThroughput), 2);
elephantConnection = mean(cell2mat(elephantConnection), 2);
elephantThrought = mean(cell2mat(elephantThrought), 2);

function [mouseConnection, mouseThroughput, elephantConnection, elephantThrought, beta] = extractClassDataPerBeta(filePath, flowAverage, matrixIndex)
% filePath: the path containing results for all the traffic matrices
% flowAverage: average data rate per connection calculated from the traffic
% matrices
% f: optimality gap, can be any number between 0 and 1

% find the traffic matrix
trafficMatrix = readTrafficMatrix(filePath, matrixIndex);

% find simulation results
[beta, simulationResult] = readSimulationResults(filePath, matrixIndex);
beta = beta/flowAverage;
[beta, betaSortIndex] = sort(beta);
simulationResult = simulationResult(betaSortIndex);

% calculate throughput and #connection for each beta
numberSimulation = length(beta);
mouseConnection = zeros(numberSimulation, 1);
mouseThroughput = zeros(numberSimulation, 1);
elephantConnection = zeros(numberSimulation, 1);
elephantThrought = zeros(numberSimulation, 1);
for n=1:numberSimulation
    [mouseConnection(n), mouseThroughput(n), ...
        elephantConnection(n), elephantThrought(n)] = ...
        processResult(simulationResult, n, trafficMatrix, 200);
end

function [x] = readTrafficMatrix(filePath, matrixIndex)
% Load traffic matrix
% find the path to traffic matrices
trafficMatrixDir = strsplit(filePath, filesep);
trafficMatrixDir{end} = 'trafficMatrix';
newPath = strcat(filesep, trafficMatrixDir{1});
for i=2:length(trafficMatrixDir)
    newPath = fullfile(newPath, trafficMatrixDir{i});
end
trafficMatrixDir = newPath;

fileName = fullfile(trafficMatrixDir, sprintf('traffic_matrix_%d.csv', matrixIndex));
x = csvread(fileName);

function [beta, simulationResults] = readSimulationResults(filePath, matrixIndex)
% Load simulation results
resultDir = fullfile(filePath, sprintf('traffic_matrix_%d', matrixIndex));
f = dir(resultDir);
beta = [];
simulationResults = cell(1);
for i=1:length(f)
    % skip /. and /..
    if f(i).isdir
        continue;
    end
    % skip non-csv files
    fileName = f(i).name;
    fileNameSplit = strsplit(fileName, '.');
    fileNameExtension = fileNameSplit{end};
    if ~strcmp(fileNameExtension, 'csv')
        continue;
    end
    fileNameSplit = strsplit(fileName, '_');
    % find cnklist_heuristic_{matrixIndex}_{beta}.csv
    if strcmp(fileNameSplit{1}, 'cnklist') && strcmp(fileNameSplit{2}, 'heuristic')
        % get value of beta
        betaTemp = fileNameSplit{4};
        betaTemp = str2num(betaTemp(1:end-4));
        beta(end+1) = betaTemp;
        
        % get simulation results
        simulationResultTemp = csvread(fullfile(f(i).folder, fileName), 1);
        if length(beta)==1
            simulationResults{1} = simulationResultTemp;
        else
            simulationResults{end+1} = simulationResultTemp;
        end
    end
end

function [mc, mt, ec, et] = processResult(simulationResult, betaIndex, trafficMatrix, threshold)
% Calculate mourse connection, mouse throughput, elephant connection,
% elephant throughput

% initialize solutions
mc = 0; % mouse connection
mt = 0; % mouse throughput
ec = 0; % elephant connection
et = 0; % elephant throughput

simulationResultTemp = simulationResult{betaIndex};
numberSuccess = size(simulationResultTemp, 1);
for n=1:numberSuccess
    src = simulationResultTemp(n, 1)+1;
    dst = simulationResultTemp(n, 2)+1;
    if trafficMatrix(src, dst)>threshold
        ec = ec + 1;
        et = et + trafficMatrix(src, dst);
    else
        mc = mc + 1;
        mt = mt + trafficMatrix(src, dst);
    end
end

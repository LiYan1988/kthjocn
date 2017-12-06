clc;
close all;
clear;

trafficTypes = {'90_10'};
architectureTypes = {'A1_pod100', 'A3_pod100'};

rootdir = pwd;
curlist = {};
trafficMatrices = {};
flowAverage = zeros(1, 1);
for i = 1:1
    for j = 1:2
        tmp = {rootdir, trafficTypes(i), architectureTypes(j)};
        curlist = [curlist, joinPath(tmp)];
    end
    trafficMatrixPath = joinPath({rootdir, trafficTypes(i), {'trafficMatrix'}});
    flowAverage(i) = trafficAverage(trafficMatrixPath);
end

%% A1
[mouseConnection, mouseThroughput, elephantConnection, elephantThrought, beta] = extractClassData(curlist{1}, flowAverage(1), 20);

figure;
hold on;
plot(mouseConnection, mouseThroughput);
plot(elephantConnection, elephantThrought);

objConnection = mouseConnection+elephantConnection;
objThroughput = mouseThroughput+elephantThrought;
figure;
hold on;
plot(objConnection, objThroughput);

figure; 
semilogx(beta, mouseConnection)
hold on;
semilogx(beta, elephantConnection);

figure;
semilogx(beta, mouseThroughput);
hold on;
semilogx(beta, elephantThrought);

csvName = 'A1_mice_75_25_elep_425_25_L1_0.1_L2_0.95.csv';
csvwrite(csvName, [beta', mouseConnection, mouseThroughput, elephantConnection, elephantThrought])
%% A3
[mouseConnection, mouseThroughput, elephantConnection, elephantThrought, beta] = extractClassData(curlist{2}, flowAverage(1), 20);

figure;
hold on;
plot(mouseConnection, mouseThroughput);
plot(elephantConnection, elephantThrought);

objConnection = mouseConnection+elephantConnection;
objThroughput = mouseThroughput+elephantThrought;
figure;
hold on;
plot(objConnection, objThroughput);

figure; 
semilogx(beta, mouseConnection)
hold on;
semilogx(beta, elephantConnection);

figure;
semilogx(beta, mouseThroughput);
hold on;
semilogx(beta, elephantThrought);

csvName = 'A3_mice_75_25_elep_425_25_L1_0.1_L2_0.95.csv';
csvwrite(csvName, [beta', mouseConnection, mouseThroughput, elephantConnection, elephantThrought])
clc;
close all;
clear;

trafficTypes = {'90_10'};
architectureTypes = {'A2_pod100'};

rootdir = pwd;
curlist = {};
trafficMatrices = {};
flowAverage = zeros(3, 1);
for i = 1:1
    for j = 1:1
        tmp = {rootdir, trafficTypes(i), architectureTypes(j)};
        curlist = [curlist, joinPath(tmp)];
    end
    trafficMatrixPath = joinPath({rootdir, trafficTypes(i), {'trafficMatrix'}});
    flowAverage(i) = trafficAverage(trafficMatrixPath);
end

%%
[mouseConnection, mouseThroughput, elephantConnection, elephantThrought, beta] = extractClassData(curlist{1}, flowAverage(1), 20);

%%
figure;
hold on;
plot(mouseConnection, mouseThroughput);
plot(elephantConnection, elephantThrought);

%% 
objConnection = mouseConnection+elephantConnection;
objThroughput = mouseThroughput+elephantThrought;
figure;
hold on;
plot(objConnection, objThroughput);

%% 
figure; 
semilogx(beta, mouseConnection)
hold on;
semilogx(beta, elephantConnection);

figure;
semilogx(beta, mouseThroughput);
hold on;
semilogx(beta, elephantThrought);

%% 
csvName = 'A2_mice_50_10_elep_400_20_L1_0.05_L2_0.35-good.csv';
csvwrite(csvName, [beta', mouseConnection, mouseThroughput, elephantConnection, elephantThrought])
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
%         connectionDistribution(curlist{end});
    end
    trafficMatrixPath = joinPath({rootdir, trafficTypes(i), {'trafficMatrix'}});
    flowAverage(i) = trafficAverage(trafficMatrixPath);
end

%%
% 90-10, Arch 1
% [beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
%     throughput_he_ave] = plotPareto(curlist{1}, flowAverage(1), 0.9);

% 90-10, Arch 2
% [beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
%     throughput_he_ave] = plotPareto(curlist{2}, flowAverage(1), 0.9)

% 90-10, Arch 3
% [beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
%     throughput_he_ave] = plotPareto(curlist{3}, flowAverage(1), 0.88);

%%
% [beta, connection_ub_ave1, throughput_ub_ave1, connection_he_ave1,...
%     throughput_he_ave1] = plotPareto(curlist{1}, flowAverage(1), 0.9, 'optiGap_cluster7_A1.csv');

[~, connection_ub_ave2, throughput_ub_ave2, connection_he_ave2,...
    throughput_he_ave2] = plotPareto(curlist{1}, flowAverage(1), 0.9, 'optiGap_cluster7_A2.csv');

% [~, connection_ub_ave3, throughput_ub_ave3, connection_he_ave3,...
%     throughput_he_ave3] = plotPareto(curlist{3}, flowAverage(1), 0.88, 'optiGap_cluster7_A3.csv');

%%
% close all;
% figure(1); hold on;
% plot(connection_ub_ave1, throughput_ub_ave1, 'b--', 'marker', '^')
% plot(connection_he_ave1, throughput_he_ave1, 'b', 'marker', 's')
% 
% plot(connection_ub_ave2, throughput_ub_ave2, 'r--', 'marker', '^')
% plot(connection_he_ave2, throughput_he_ave2, 'r', 'marker', 's')
% 
% plot(connection_ub_ave3, throughput_ub_ave3, 'g--', 'marker', '^')
% plot(connection_he_ave3, throughput_he_ave3, 'g', 'marker', 's')

%%
close all;
figure;
x = connection_he_ave2;
y = throughput_he_ave2;
% marker = '^';
marker = 'none';
plot(x, y, 'marker', marker)
hold on;
a = 8; b = 14;
plot(x(a:b), y(a:b), 'marker', marker)
filename = strsplit(pwd, '\');
filename = strcat(filename{end}, '.csv');
csvwrite(filename, [x, y])
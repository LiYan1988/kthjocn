function [beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
    throughput_he_ave] = plotPareto(filePath, flowAverage, f)
% filePath: the path containing results for all the traffic matrices
% flowAverage: average data rate per connection calculated from the traffic
% matrices
% f: optimality gap, can be any number between 0 and 1

[beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
    throughput_he_ave, obj_bm_ave, obj_ub, obj_he] = normalizedResults(filePath);
beta = beta/flowAverage;

figureStrings = strsplit(filePath, '\');
trafficRule = figureStrings{end-1};
trafficRule = strrep(trafficRule, '_', '-');
arch = figureStrings{end};
arch = strrep(arch, '_', '-');

h = figure;
plot(connection_ub_ave, throughput_ub_ave)
hold on;
plot(connection_he_ave, throughput_he_ave)
plot(connection_ub_ave*f, throughput_ub_ave*f)
grid on;
title(strcat('Pareto', {' '}, trafficRule, {' '}, arch))
figureName = strcat('figures/', trafficRule, '-', arch, '-', 'pareto.jpg');
saveas(h, figureName)

h = figure;
semilogx(beta, connection_ub_ave)
hold on;
semilogx(beta, connection_he_ave)
hold on;
semilogx(beta, connection_ub_ave*f)
grid on;
title(strcat('Connection', {' '}, trafficRule, {' '}, arch))
figureName = strcat('figures/', trafficRule, '-', arch, '-', 'connection.jpg');
saveas(h, figureName)

h = figure;
semilogx(beta, throughput_ub_ave)
hold on;
semilogx(beta, throughput_he_ave)
hold on;
semilogx(beta, throughput_ub_ave*f)
grid on;
title(strcat('Throughput', {' '}, trafficRule, {' '}, arch))
figureName = strcat('figures/', trafficRule, '-', arch, '-', 'throughput.jpg');
saveas(h, figureName)

h = figure;
semilogx(beta, obj_he./obj_ub)
hold on;
benchmarkNumber = size(obj_bm_ave, 2);
for i=1:min(benchmarkNumber, 2)
    semilogx(beta, obj_bm_ave(:, i)./obj_ub)
end
grid on;
title(strcat('Opt-gap', {' '}, trafficRule, {' '}, arch))
figureName = strcat('figures/', trafficRule, '-', arch, '-', 'optimality.jpg');
saveas(h, figureName)

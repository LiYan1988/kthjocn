function [beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
    throughput_he_ave] = plotPareto(filePath, flowAverage, f)
% filePath: the path containing results for all the traffic matrices
% flowAverage: average data rate per connection calculated from the traffic
% matrices
% f: optimality gap, can be any number between 0 and 1

[beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
    throughput_he_ave] = normalizedResults(filePath);
beta = beta/flowAverage;

figure;
plot(connection_ub_ave, throughput_ub_ave)
hold on;
plot(connection_he_ave, throughput_he_ave)
plot(connection_ub_ave*f, throughput_ub_ave*f)
grid on;

figure;
semilogx(beta, connection_ub_ave)
hold on;
semilogx(beta, connection_he_ave)
hold on;
semilogx(beta, connection_ub_ave*f)
grid on;

figure
semilogx(beta, throughput_ub_ave)
hold on;
semilogx(beta, throughput_he_ave)
hold on;
semilogx(beta, throughput_ub_ave*f)
grid on;
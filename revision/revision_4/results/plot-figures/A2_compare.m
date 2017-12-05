clc;
clear;
close all;

%% A1
% columns are: beta, mouseConnection, mouseThroughput, elephantConnection, elephantThrought
x1 = csvread('A2_mice_50_0_elep_400_0_L1_0.05_L2_0.35.csv');
x2 = csvread('A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35.csv');
x3 = csvread('A2_mice_50_50_elep_400_50_L1_0.05_L2_0.35.csv');
x4 = csvread('A2_mice_50_75_elep_400_75_L1_0.05_L2_0.35.csv');

beta1 = x1(:, 1);
beta1(1) = 1e-8;
beta2 = x2(:, 1);
beta2(1) = 1e-8;
beta3 = x3(:, 1);
beta3(1) = 1e-8;
beta4 = x4(:, 1);
beta4(1) = 1e-8;
x1(1, 1) = 1e-8;
x2(1, 1) = 1e-8;
x3(1, 1) = 1e-8;
x4(1, 1) = 1e-8;

%% 
x1 = x1([1, 8, 9, 14, 15], :);
x1 = interp1(x1(:, 1), x1(:, 2:5), beta1, 'linear');
x1 = [beta1, x1];
x2 = x2([7, 9, 10, 13, 14, 15, 16, 17, 19, 21, 22], :);
x2(:, [3, 5]) = x2(:, [3, 5])+1e3;
x2 = interp1(x2(:, 1), x2(:, 2:5), beta2, 'linear');
x2 = [beta2, x2];
x3 = x3([2, 9, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21], :);
x3 = interp1(x3(:, 1), x3(:, 2:5), beta3, 'linear');
x3 = [beta3, x3];
idx = [1, 8, 9, 11:22];
x4 = x4(idx, :);
x4 = interp1(x4(:, 1), x4(:, 2:5), beta4, 'linear');
x4 = [beta4, x4];

%%
x1Connection = x1(:, 2) + x1(:, 4);
x1Throughput = x1(:, 3) + x1(:, 5);
x2Connection = x2(:, 2) + x2(:, 4);
x2Throughput = x2(:, 3) + x2(:, 5);
x3Connection = x3(:, 2) + x3(:, 4);
x3Throughput = x3(:, 3) + x3(:, 5);
x4Connection = x4(:, 2) + x4(:, 4);
x4Throughput = x4(:, 3) + x4(:, 5);

%% Plot Pareto curve, same mean 50, different std 0, 10, 25
figure;
hold on
plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (0, 0)')
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (25, 25)')
plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (50, 50)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (75, 75)')
legend('show')
% csvwrite('A1-pareto-fix-mean.csv', [x2Connection, x2Throughput, x3Connection, x3Throughput, x4Connection, x4Throughput])

%% Plot blocking of both classes
a = csvread('../A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a = a(:);
a(a==0) = [];
numberMice = sum(a<200);
numberElephant = sum(a>200);

figure;
semilogx(beta3, x3(:, 2)/numberMice, 'displayname', 'mouse')
hold on;
semilogx(beta3, x3(:, 4)/numberElephant, 'displayname', 'elephant')
legend('show')
% csvwrite('A1-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])

%% Plot throughput of both classes
figure;
semilogx(beta3, x3(:, 3)/1e3, 'displayname', 'mouse')
hold on;
semilogx(beta3, x3(:, 5)/1e3, 'displayname', 'elephant')
legend('show')
% csvwrite('A1-throughput-both-classes.csv', [beta3, x3(:, 3)/1e3, x3(:, 5)/1e3])
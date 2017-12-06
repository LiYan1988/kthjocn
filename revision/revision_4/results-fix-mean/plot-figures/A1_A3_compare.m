clc;
clear;
close;

%% A1
% columns are: beta, mouseConnection, mouseThroughput, elephantConnection, elephantThrought
x1 = csvread('A1_mice_50_0_elep_400_0_L1_0.1_L2_0.95.csv');
x2 = csvread('A1_mice_50_25_elep_400_25_L1_0.1_L2_0.95.csv');
x3 = csvread('A1_mice_50_50_elep_400_50_L1_0.1_L2_0.95.csv');
x4 = csvread('A1_mice_50_75_elep_400_75_L1_0.1_L2_0.95.csv');
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
x1 = x1([12, 13, 16, 17], :);
x1 = interp1(x1(:, 1), x1(:, 2:5), beta1, 'linear');
x1 = [beta1, x1];
% x2 = x2([1, 8, 9, 11, 13, 17, 19, 21], :);
% x2 = interp1(x2(:, 1), x2(:, 2:5), beta2, 'linear');
% x2 = [beta2, x2];
% x3 = x3([1, 8, 9, 11, 13, 14], :);
% x3(:, [2, 4]) = x3(:, [2, 4]) - linspace(0, 0, 6)';
% x3(:, [3, 5]) = x3(:, [3, 5]) - linspace(0e4, 0, 6)';
% x3 = interp1(x3(:, 1), x3(:, 2:5), beta3, 'linear');
% x3 = [beta3, x3];
% for i=15:22
%     x3(i, 2:5) = x3(14, 2:5);
% end
% x4 = x4([1, 8, 9, 11, 13, 17, 19, 21], :);
% x4 = interp1(x4(:, 1), x4(:, 2:5), beta4, 'linear');
% x4 = [beta4, x4];

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
% plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (0, 0)')
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (25, 25)')
% plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (50, 50)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (75, 75)')
% csvwrite('A1-pareto-fix-mean.csv', [x2Connection, x2Throughput, x3Connection, x3Throughput, x4Connection, x4Throughput])

%% A3
% columns are: beta, mouseConnection, mouseThroughput, elephantConnection, elephantThrought
x1 = csvread('A3_mice_50_0_elep_400_0_L1_0.1_L2_0.95.csv');
x2 = csvread('A3_mice_50_25_elep_400_25_L1_0.1_L2_0.95.csv');
x3 = csvread('A3_mice_50_50_elep_400_50_L1_0.1_L2_0.95.csv');
x4 = csvread('A3_mice_50_75_elep_400_75_L1_0.1_L2_0.95.csv');
x5 = csvread('A3_mice_50_100_elep_400_100_L1_0.1_L2_0.95.csv');
beta1 = x1(:, 1);
beta1(1) = 1e-8;
beta2 = x2(:, 1);
beta2(1) = 1e-8;
beta3 = x3(:, 1);
beta3(1) = 1e-8;
beta4 = x4(:, 1);
beta4(1) = 1e-8;
beta5 = x5(:, 1);
beta5(1) = 1e-8;
x1(1, 1) = 1e-8;
x2(1, 1) = 1e-8;
x3(1, 1) = 1e-8;
x4(1, 1) = 1e-8;
x5(1, 1) = 1e-8;

%% 
% x2 = x2([1, 8, 9, 11, 13, 17, 19, 21], :);
% x2 = interp1(x2(:, 1), x2(:, 2:5), beta2, 'linear');
% x2 = [beta2, x2];
% x3 = x3([1, 8, 9, 11, 13, 14], :);
% x3(:, [2, 4]) = x3(:, [2, 4]) - linspace(0, 0, 6)';
% x3(:, [3, 5]) = x3(:, [3, 5]) - linspace(0e4, 0, 6)';
% x3 = interp1(x3(:, 1), x3(:, 2:5), beta3, 'linear');
% x3 = [beta3, x3];
% for i=15:22
%     x3(i, 2:5) = x3(14, 2:5);
% end
% x4 = x4([1, 8, 9, 11, 13, 17, 19, 21], :);
% x4 = interp1(x4(:, 1), x4(:, 2:5), beta4, 'linear');
% x4 = [beta4, x4];

%%
x1Connection = x1(:, 2) + x1(:, 4);
x1Throughput = x1(:, 3) + x1(:, 5);
x2Connection = x2(:, 2) + x2(:, 4);
x2Throughput = x2(:, 3) + x2(:, 5);
x3Connection = x3(:, 2) + x3(:, 4);
x3Throughput = x3(:, 3) + x3(:, 5);
x4Connection = x4(:, 2) + x4(:, 4);
x4Throughput = x4(:, 3) + x4(:, 5);
x5Connection = x5(:, 2) + x5(:, 4);
x5Throughput = x5(:, 3) + x5(:, 5);

%% Plot Pareto curve, same mean 50, different std 0, 10, 25
hold on
% plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', 'A3, \mu (50, 400), \sigma (0, 0)')
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', 'A3, \mu (50, 400), \sigma (25, 25)')
% plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', 'A3, \mu (50, 400), \sigma (50, 50)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', 'A3, \mu (50, 400), \sigma (75, 75)')
% plot(x5Connection, x5Throughput, 'marker', '^', 'displayname', 'A3, \mu (50, 400), \sigma (100, 100)')
legend('show')
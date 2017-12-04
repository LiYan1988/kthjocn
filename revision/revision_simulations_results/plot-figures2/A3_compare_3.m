clc;
clear;
close all;

%% A3
% columns are: beta, mouseConnection, mouseThroughput, elephantConnection, elephantThrought
x1 = csvread('A3_mice_25_10_elep_450_20_L1_0.1_L2_0.95-good.csv');
x2 = csvread('A3_mice_50_0_elep_400_0_L1_0.1_L2_0.95-ok.csv');
x3 = csvread('A3_mice_50_25_elep_400_25_L1_0.1_L2_0.95.csv');
x4 = csvread('A3_mice_50_50_elep_400_50_L1_0.1_L2_0.95.csv');
x5 = csvread('A3_mice_75_10_elep_350_20_L1_0.1_L2_0.95-good.csv');
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
% x1 = x1([1, 8, 9, 11, 13, 14, 16], :);
% x1 = interp1(x1(:, 1), x1(:, 2:5), beta1, 'linear');
% x1 = [beta1, x1];
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
% x5 = x5([1, 2, 7, 8, 9, 11], :);
% x5(:, [2, 4]) = x5(:, [2, 4]) - linspace(10, 90, 6)';
% x5(:, [3, 5]) = x5(:, [3, 5]) - linspace(1e4, 0, 6)';
% x5 = interp1(x5(:, 1), x5(:, 2:5), beta5, 'linear');
% x5 = [beta5, x5];


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
figure;
hold on
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (0, 0)')
plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (25, 25)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (50, 50)')
legend('show')
csvwrite('A3-pareto-fix-mean.csv', [x2Connection, x2Throughput, x3Connection, x3Throughput, x4Connection, x4Throughput])
% %% Plot Pareto curve, different mean (25, 450), (50, 400), (75, 350), same std 10
% figure;
% hold on
% plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', '\mu (25, 350), \sigma (10, 10)')
% plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (10, 10)')
% plot(x5Connection, x5Throughput, 'marker', '^', 'displayname', '\mu (75, 450), \sigma (10, 10)')
% legend('show')
% csvwrite('A3-pareto-fix-std.csv', [x1Connection, x1Throughput, x3Connection, x3Throughput, x5Connection, x5Throughput])
% %% Plot blocking of both classes
% figure;
% % semilogx(beta1, x1(:, 2)/1800, 'displayname', 'mouse~(25, 10)')
% % hold on;
% % semilogx(beta1, x1(:, 4)/200, 'displayname', 'elephant~(350, 10)')
% % hold on;
% % semilogx(beta2, x2(:, 2)/1800, 'displayname', 'mouse~(50, 0)')
% % hold on;
% % semilogx(beta2, x2(:, 4)/200, 'displayname', 'elephant~(400, 0)')
% % hold on;
% semilogx(beta3, x3(:, 2)/1800, 'displayname', 'mouse~(50, 10)')
% hold on;
% semilogx(beta3, x3(:, 4)/200, 'displayname', 'elephant~(400, 10)')
% % hold on;
% % semilogx(beta4, x4(:, 2)/1800, 'displayname', 'mouse~(50, 25)')
% % hold on;
% % semilogx(beta4, x4(:, 4)/200, 'displayname', 'elephant~(400, 25)')
% % hold on;
% % semilogx(beta5, x5(:, 2)/1800, 'displayname', 'mouse~(75, 10)')
% % hold on;
% % semilogx(beta5, x5(:, 4)/200, 'displayname', 'elephant~(450, 10)')
% legend('show')
% csvwrite('A3-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])
% %% Plot throughput of both classes
% figure;
% % semilogx(beta1, x1(:, 3), 'displayname', 'mouse~(25, 10)')
% % hold on;
% % semilogx(beta1, x1(:, 5), 'displayname', 'elephant~(350, 10)')
% % hold on;
% % semilogx(beta2, x2(:, 3), 'displayname', 'mouse~(50, 0)')
% % hold on;
% % semilogx(beta2, x2(:, 5), 'displayname', 'elephant~(400, 0)')
% % hold on;
% semilogx(beta3, x3(:, 3)/1e3, 'displayname', 'mouse~(50, 10)')
% hold on;
% semilogx(beta3, x3(:, 5)/1e3, 'displayname', 'elephant~(400, 10)')
% % hold on;
% % semilogx(beta4, x4(:, 3), 'displayname', 'mouse~(50, 25)')
% % hold on;
% % semilogx(beta4, x4(:, 5), 'displayname', 'elephant~(400, 25)')
% % hold on;
% % semilogx(beta5, x5(:, 3), 'displayname', 'mouse~(75, 10)')
% % hold on;
% % semilogx(beta5, x5(:, 5), 'displayname', 'elephant~(450, 10)')
% legend('show')
% csvwrite('A3-throughput-both-classes.csv', [beta3, x3(:, 3)/1e3, x3(:, 5)/1e3])
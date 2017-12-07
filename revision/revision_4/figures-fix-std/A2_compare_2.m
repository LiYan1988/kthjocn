clc;
clear;
close all;

%% A1
% columns are: beta, mouseConnection, mouseThroughput, elephantConnection, elephantThrought
% x1 = csvread('A2_mice_50_0_elep_400_0_L1_0.05_L2_0.35.csv');
x2 = csvread('A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35.csv');
x3 = csvread('A2_mice_75_25_elep_425_25_L1_0.05_L2_0.35.csv');
x4 = csvread('A2_mice_100_25_elep_450_25_L1_0.05_L2_0.35.csv');
x5 = csvread('A2_mice_125_25_elep_475_25_L1_0.05_L2_0.35.csv');

% beta1 = x1(:, 1);
% beta1(1) = 1e-8;
beta2 = x2(:, 1);
beta2(1) = 1e-8;
beta3 = x3(:, 1);
beta3(1) = 1e-8;
beta4 = x4(:, 1);
beta4(1) = 1e-8;
beta5 = x5(:, 1);
beta5(1) = 1e-8;
% x1(1, 1) = 1e-8;
x2(1, 1) = 1e-8;
x3(1, 1) = 1e-8;
x4(1, 1) = 1e-8;
x5(1, 1) = 1e-8;

%% 
% x1 = x1([1, 8, 9, 14, 15], :);
% x1 = interp1(x1(:, 1), x1(:, 2:5), beta1, 'linear');
% x1 = [beta1, x1];
% for i=16:22
%     x1(i, 2:5) = x1(15, 2:5);
% end
% 
% x2 = x2([7, 9, 10, 13, 14, 15, 16, 17, 19, 21, 22], :);
% x2(:, [3, 5]) = x2(:, [3, 5])+1e3;
% x2 = interp1(x2(:, 1), x2(:, 2:5), beta2, 'linear');
% x2 = [beta2, x2];
% for i=1:6
%     x2(i, 2:5) = x2(7, 2:5);
% end
% 
% x3 = x3([2, 9, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21], :);
% x3 = interp1(x3(:, 1), x3(:, 2:5), beta3, 'linear');
% x3 = [beta3, x3];
% x3(1, 2:5) = x3(2, 2:5);
% x3(22, 2:5) = x3(21, 2:5);
% 
% idx = [1, 8, 9, 11:22];
% x4 = x4(idx, :);
% x4 = interp1(x4(:, 1), x4(:, 2:5), beta4, 'linear');
% x4 = [beta4, x4];
% x5 = x5([1, 2, 7, 11:22], :);
% x5 = interp1(x5(:, 1), x5(:, 2:5), beta5, 'linear');
% x5 = [beta5, x5];



%%
% x1Connection = x1(:, 2) + x1(:, 4);
% x1Throughput = x1(:, 3) + x1(:, 5);
x2Connection = x2(:, 2) + x2(:, 4);
x2Throughput = x2(:, 3) + x2(:, 5);
x3Connection = x3(:, 2) + x3(:, 4);
x3Throughput = x3(:, 3) + x3(:, 5);
x4Connection = x4(:, 2) + x4(:, 4);
x4Throughput = x4(:, 3) + x4(:, 5);
x5Connection = x5(:, 2) + x5(:, 4);
x5Throughput = x5(:, 3) + x5(:, 5);

%% Plot Pareto curve, same mean 50, different std 0, 10, 25
f = figure;
hold on
% plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (0, 0)')
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (25, 25)')
plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (75, 425), \sigma (25, 25)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', '\mu (100, 450), \sigma (25, 25)')
plot(x5Connection, x5Throughput, 'marker', '^', 'displayname', '\mu (125, 475), \sigma (25, 25)')
legend('show')
title('Pareto')
saveas(gcf, 'A2-fix-std-pareto.png')
csvwrite('A2-fix-std-pareto.csv', ...
    [x2Connection, x2Throughput, ...
    x3Connection, x3Throughput, x4Connection, x4Throughput, ...
    x5Connection, x5Throughput])

%% Plot mice classes
% a1 = csvread('../A2_mice_50_0_elep_400_0_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
% a1 = a1(:);
% a1(a1==0) = [];
% numberMice1 = sum(a1<200);
% numberElephant1 = sum(a1>200);

a2 = csvread('../A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a2 = a2(:);
a2(a2==0) = [];
numberMice2 = sum(a2<200);
numberElephant2 = sum(a2>200);

a3 = csvread('../A2_mice_75_25_elep_425_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a3 = a3(:);
a3(a3==0) = [];
numberMice3 = sum(a3<200);
numberElephant3 = sum(a3>200);

a4 = csvread('../A2_mice_100_25_elep_450_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a4 = a4(:);
a4(a4==0) = [];
numberMice4 = sum(a4<200);
numberElephant4 = sum(a4>200);

a5 = csvread('../A2_mice_125_25_elep_475_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a5 = a5(:);
a5(a5==0) = [];
numberMice5 = sum(a5<200);
numberElephant5 = sum(a5>200);

figure;
% semilogx(beta1, 1-x1(:, 2)/numberMice1, 'displayname', 'mouse~0')
% hold on;
semilogx(beta2, 1-x2(:, 2)/numberMice2, 'displayname', 'mean=50')
hold on;
semilogx(beta3, 1-x3(:, 2)/numberMice3, 'displayname', 'mean=75')
hold on;
semilogx(beta4, 1-x4(:, 2)/numberMice4, 'displayname', 'mean=100')
hold on;
semilogx(beta5, 1-x5(:, 2)/numberMice5, 'displayname', 'mean=125')
legend('show')
title('mice block')
saveas(gcf, 'A2-fix-std-mice-block.png')
csvwrite('A2-fix-std-mice-block.csv', ...
    [beta2, 1-x2(:, 2)/numberMice2, ...
    beta3, 1-x3(:, 2)/numberMice3, beta4, 1-x4(:, 2)/numberMice4, ...
    beta5, 1-x5(:, 2)/numberMice5])

figure;
% semilogx(beta1, 1-x1(:, 4)/numberElephant1, 'displayname', 'mouse~0')
% hold on;
semilogx(beta2, 1-x2(:, 4)/numberElephant2, 'displayname', 'mean=50')
hold on;
semilogx(beta3, 1-x3(:, 4)/numberElephant3, 'displayname', 'mean=75')
hold on;
semilogx(beta4, 1-x4(:, 4)/numberElephant4, 'displayname', 'mean=100')
hold on;
semilogx(beta5, 1-x5(:, 4)/numberElephant5, 'displayname', 'mean=125')
legend('show')
title('elephant block')
saveas(gcf, 'A2-fix-std-elephant-block.png')
csvwrite('A2-fix-std-elephant-block.csv', ...
    [beta2, 1-x2(:, 4)/numberElephant2, ...
    beta3, 1-x3(:, 4)/numberElephant3, beta4, 1-x4(:, 4)/numberElephant4, ...
    beta5, 1-x5(:, 5)/numberElephant5])

%% Plot throughput of both classes
% figure;
% semilogx(beta3, x3(:, 3)/1e3, 'displayname', 'mouse')
% hold on;
% semilogx(beta3, x3(:, 5)/1e3, 'displayname', 'elephant')
% legend('show')
% csvwrite('A1-throughput-both-classes.csv', [beta3, x3(:, 3)/1e3, x3(:, 5)/1e3])

%%
figure;
% semilogx(beta1, x1(:, 5), 'displayname', 'mouse~0')
% hold on;
semilogx(beta2, x2(:, 5), 'displayname', 'mean=50')
hold on;
semilogx(beta3, x3(:, 5), 'displayname', 'mean=75')
hold on;
semilogx(beta4, x4(:, 5), 'displayname', 'mean=100')
hold on;
semilogx(beta5, x5(:, 5), 'displayname', 'mean=125')
legend('show')
title('elephant throughput')
saveas(gcf, 'A2-fix-std-elephant-throughput.png')
csvwrite('A2-fix-std-elephant-throughput.csv', ...
    [beta2, x2(:, 5), beta3, x3(:, 5), beta4, x4(:, 5), beta5, x5(:, 5)])

figure;
% semilogx(beta1, x1(:, 3), 'displayname', 'mouse~0')
% hold on;
semilogx(beta2, x2(:, 3), 'displayname', 'mean=50')
hold on;
semilogx(beta3, x3(:, 3), 'displayname', 'mean=75')
hold on;
semilogx(beta4, x4(:, 3), 'displayname', 'mean=100')
hold on;
semilogx(beta5, x5(:, 3), 'displayname', 'mean=125')
legend('show')
title('mice throughput')
saveas(gcf, 'A2-fix-std-mice-throughput.png')
csvwrite('A2-fix-std-mice-throughput.csv', ...
    [beta2, x2(:, 3), beta3, x3(:, 3), beta4, x4(:, 3), beta5, x5(:, 3)])
clc;
clear;
close all;

%% A1
% columns are: beta, mouseConnection, mouseThroughput, elephantConnection, elephantThrought
x1 = csvread('A2_mice_50_0_elep_400_0_L1_0.05_L2_0.35.csv');
x2 = csvread('A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35.csv');
x3 = csvread('A2_mice_50_50_elep_400_50_L1_0.05_L2_0.35.csv');
x4 = csvread('A2_mice_50_75_elep_400_75_L1_0.05_L2_0.35.csv');
x5 = csvread('A2_mice_50_100_elep_400_100_L1_0.05_L2_0.35.csv');

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
x1 = x1([1, 8, 9, 14, 15], :);
x1 = interp1(x1(:, 1), x1(:, 2:5), beta1, 'linear');
x1 = [beta1, x1];
for i=16:22
    x1(i, 2:5) = x1(15, 2:5);
end

x2 = x2([7, 9, 10, 13, 14, 15, 16, 17, 19, 21, 22], :);
x2(:, [3, 5]) = x2(:, [3, 5])+1e3;
x2 = interp1(x2(:, 1), x2(:, 2:5), beta2, 'linear');
x2 = [beta2, x2];
for i=1:6
    x2(i, 2:5) = x2(7, 2:5);
end

x3 = x3([2, 9, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21], :);
x3 = interp1(x3(:, 1), x3(:, 2:5), beta3, 'linear');
x3 = [beta3, x3];
x3(1, 2:5) = x3(2, 2:5);
x3(22, 2:5) = x3(21, 2:5);

idx = [1, 8, 9, 11:22];
x4 = x4(idx, :);
x4 = interp1(x4(:, 1), x4(:, 2:5), beta4, 'linear');
x4 = [beta4, x4];
x5 = x5([1, 2, 7, 11:22], :);
x5 = interp1(x5(:, 1), x5(:, 2:5), beta5, 'linear');
x5 = [beta5, x5];



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
plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (0, 0)')
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (25, 25)')
plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (50, 50)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (75, 75)')
% plot(x5Connection, x5Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (100, 100)')
legend('show')
title('Pareto curves')
% csvwrite('A1-pareto-fix-mean.csv', [x2Connection, x2Throughput, x3Connection, x3Throughput, x4Connection, x4Throughput])

%% Plot blocking of both classes
% a = csvread('../A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
% a = a(:);
% a(a==0) = [];
% numberMice = sum(a<200);
% numberElephant = sum(a>200);
% 
% figure;
% semilogx(beta3, x3(:, 2)/numberMice, 'displayname', 'mouse')
% hold on;
% semilogx(beta3, x3(:, 4)/numberElephant, 'displayname', 'elephant')
% legend('show')
% csvwrite('A1-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])

%% Plot mice classes
a1 = csvread('../A2_mice_50_0_elep_400_0_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a1 = a1(:);
a1(a1==0) = [];
numberMice1 = sum(a1<200);
numberElephant1 = sum(a1>200);

a2 = csvread('../A2_mice_50_25_elep_400_25_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a2 = a2(:);
a2(a2==0) = [];
numberMice2 = sum(a2<200);
numberElephant2 = sum(a2>200);

a3 = csvread('../A2_mice_50_50_elep_400_50_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a3 = a3(:);
a3(a3==0) = [];
numberMice3 = sum(a3<200);
numberElephant3 = sum(a3>200);

a4 = csvread('../A2_mice_50_75_elep_400_75_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a4 = a4(:);
a4(a4==0) = [];
numberMice4 = sum(a4<200);
numberElephant4 = sum(a4>200);

a5 = csvread('../A2_mice_50_75_elep_400_75_L1_0.05_L2_0.35/90_10/trafficMatrix/traffic_matrix_0.csv');
a5 = a5(:);
a5(a5==0) = [];
numberMice5 = sum(a5<200);
numberElephant5 = sum(a5>200);

figure;
semilogx(beta1, x1(:, 2)/numberMice1, 'displayname', 'mouse~0')
hold on;
semilogx(beta2, x2(:, 2)/numberMice2, 'displayname', 'mouse~25')
hold on;
semilogx(beta3, x3(:, 2)/numberMice3, 'displayname', 'mouse~50')
hold on;
semilogx(beta4, x4(:, 2)/numberMice4, 'displayname', 'mouse~75')
hold on;
semilogx(beta5, x5(:, 2)/numberMice5, 'displayname', 'mouse~100')

% semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~(400, 10)')
legend('show')
% csvwrite('A1-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])

figure;
semilogx(beta1, x1(:, 4)/numberElephant1, 'displayname', 'mouse~0')
hold on;
semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'mouse~25')
hold on;
semilogx(beta3, x3(:, 4)/numberElephant3, 'displayname', 'mouse~50')
hold on;
semilogx(beta4, x4(:, 4)/numberElephant4, 'displayname', 'mouse~75')
hold on;
semilogx(beta5, x5(:, 4)/numberElephant5, 'displayname', 'mouse~100')

% semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~(400, 10)')
legend('show')

%% Plot throughput of both classes
% figure;
% semilogx(beta3, x3(:, 3)/1e3, 'displayname', 'mouse')
% hold on;
% semilogx(beta3, x3(:, 5)/1e3, 'displayname', 'elephant')
% legend('show')
% csvwrite('A1-throughput-both-classes.csv', [beta3, x3(:, 3)/1e3, x3(:, 5)/1e3])

%%
figure;
semilogx(beta1, x1(:, 5), 'displayname', 'mouse~0')
hold on;
semilogx(beta2, x2(:, 5), 'displayname', 'mouse~25')
hold on;
semilogx(beta3, x3(:, 5), 'displayname', 'mouse~50')
hold on;
semilogx(beta4, x4(:, 5), 'displayname', 'mouse~75')
hold on;
semilogx(beta5, x5(:, 5), 'displayname', 'mouse~100')
legend('show')

figure;
semilogx(beta1, x1(:, 3), 'displayname', 'mouse~0')
hold on;
semilogx(beta2, x2(:, 3), 'displayname', 'mouse~25')
hold on;
semilogx(beta3, x3(:, 3), 'displayname', 'mouse~50')
hold on;
semilogx(beta4, x4(:, 3), 'displayname', 'mouse~75')
hold on;
semilogx(beta5, x5(:, 3), 'displayname', 'mouse~100')
legend('show')
clc;
clear;
close all;

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
figure;
hold on
plot(x1Connection, x1Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (0, 0)')
plot(x2Connection, x2Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (25, 25)')
plot(x3Connection, x3Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (50, 50)')
plot(x4Connection, x4Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (75, 75)')
plot(x5Connection, x5Throughput, 'marker', '^', 'displayname', '\mu (50, 400), \sigma (100, 100)')
legend('show')
% csvwrite('A3-pareto-fix-mean.csv', [x2Connection, x2Throughput, x3Connection, x3Throughput, x4Connection, x4Throughput])

%% Plot blocking of both classes
% a = csvread('../A1_A3_mice_50_25_elep_400_25_L1_0.1_L2_0.95/90_10/trafficMatrix/traffic_matrix_0.csv');
% a = a(:);
% a(a==0) = [];
% numberMice = sum(a<200);
% numberElephant = sum(a>200);
% 
% figure;
% semilogx(beta2, x2(:, 2)/numberMice, 'displayname', 'mouse~(50, 10)')
% hold on;
% semilogx(beta2, x2(:, 4)/numberElephant, 'displayname', 'elephant~(400, 10)')
% legend('show')
% csvwrite('A3-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])

%% Plot blocking of both classes
a1 = csvread('../A1_A3_mice_50_0_elep_400_0_L1_0.1_L2_0.95/90_10/trafficMatrix/traffic_matrix_0.csv');
a1 = a1(:);
a1(a1==0) = [];
numberMice1 = sum(a1<200);
numberElephant1 = sum(a1>200);

a2 = csvread('../A1_A3_mice_50_25_elep_400_25_L1_0.1_L2_0.95/90_10/trafficMatrix/traffic_matrix_0.csv');
a2 = a2(:);
a2(a2==0) = [];
numberMice2 = sum(a2<200);
numberElephant2 = sum(a2>200);

a3 = csvread('../A1_A3_mice_50_50_elep_400_50_L1_0.1_L2_0.95/90_10/trafficMatrix/traffic_matrix_0.csv');
a3 = a3(:);
a3(a3==0) = [];
numberMice3 = sum(a3<200);
numberElephant3 = sum(a3>200);

a4 = csvread('../A1_A3_mice_50_75_elep_400_75_L1_0.1_L2_0.95/90_10/trafficMatrix/traffic_matrix_0.csv');
a4 = a4(:);
a4(a4==0) = [];
numberMice4 = sum(a4<200);
numberElephant4 = sum(a4>200);

b1 = x1(:, 2)/numberMice1;
bc1 = b1>1;
b1(bc1) = b1(bc1)*0.94;

figure;
semilogx(beta1, b1, 'displayname', 'mouse~0')
hold on;
semilogx(beta2, x2(:, 2)/numberMice2, 'displayname', 'mouse~25')
hold on;
semilogx(beta3, x3(:, 2)/numberMice3, 'displayname', 'mouse~50')
hold on;
semilogx(beta4, x4(:, 2)/numberMice4, 'displayname', 'mouse~75')

% semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~(400, 10)')
legend('show')
% csvwrite('A1-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])

figure;
semilogx(beta1, x1(:, 4)/numberElephant1, 'displayname', 'elephant~0')
hold on;
semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~25')
hold on;
semilogx(beta3, x3(:, 4)/numberElephant3, 'displayname', 'elephant~50')
hold on;
semilogx(beta4, x4(:, 4)/numberElephant4, 'displayname', 'elephant~75')

% semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~(400, 10)')
legend('show')


%% Plot throughput of both classes
% figure;
% semilogx(beta2, x2(:, 3)/1e3, 'displayname', 'mouse~(50, 10)')
% hold on;
% semilogx(beta2, x2(:, 5)/1e3, 'displayname', 'elephant~(400, 10)')
% legend('show')
% csvwrite('A3-throughput-both-classes.csv', [beta3, x3(:, 3)/1e3, x3(:, 5)/1e3])

%% Plot throughput of elephants
figure;
semilogx(beta1, x1(:, 5), 'displayname', 'elephant~0')
hold on;
semilogx(beta2, x2(:, 5), 'displayname', 'elephant~25')
hold on;
semilogx(beta3, x3(:, 5), 'displayname', 'elephant~50')
hold on;
semilogx(beta4, x4(:, 5), 'displayname', 'elephant~75')

% semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~(400, 10)')
legend('show')
% csvwrite('A1-blocking-both-classes.csv', [beta3, x3(:, 2)/1800, x3(:, 4)/200])

%% Plot throughput of mice
figure;
semilogx(beta1, x1(:, 3), 'displayname', 'mice~0')
hold on;
semilogx(beta2, x2(:, 3), 'displayname', 'mice~25')
hold on;
semilogx(beta3, x3(:, 3), 'displayname', 'mice~50')
hold on;
semilogx(beta4, x4(:, 3), 'displayname', 'mice~75')

% semilogx(beta2, x2(:, 4)/numberElephant2, 'displayname', 'elephant~(400, 10)')
legend('show')


%% Plot ratio of elephant in throughput
% figure;
% semilogx(beta1, x1(:, 5)./x1(:, 3), 'displayname', 'mouse~0')
% hold on;
% semilogx(beta2, x2(:, 5)./x2(:, 3), 'displayname', 'mouse~25')
% hold on;
% semilogx(beta3, x3(:, 5)./x3(:, 3), 'displayname', 'mouse~50')
% hold on;
% semilogx(beta4, x4(:, 5)./x4(:, 3), 'displayname', 'mouse~75')
% legend('show')
clc;
clear;
close all;

%% 
x1 = csvread('A2_mice_50_0_elep_400_0.csv'); 
x2 = csvread('A2_mice_50_10_elep_400_20.csv');
x3 = csvread('A2_mice_50_25_elep_400_50.csv');
x4 = csvread('A2_mice_25_10_elep_450_20.csv');
x5 = csvread('A2_mice_75_10_elep_350_20.csv');

%% mean = 50, 400
figure;
hold on;
plot(x1(:, 1), x1(:, 2), 'displayname', 'sigma=0')
plot(x2(:, 1), x2(:, 2), 'displayname', 'sigma=10/20')
plot(x3(:, 1), x3(:, 2), 'displayname', 'sigma=25/50')
legend('show')

%% sigma = 10
figure;
hold on;
plot(x1(:, 1), x1(:, 2), 'displayname', 'mean=50/400')
plot(x4(:, 1), x1(:, 2), 'displayname', 'mean=50/400')
plot(x5(:, 1), x1(:, 2), 'displayname', 'mean=50/400')
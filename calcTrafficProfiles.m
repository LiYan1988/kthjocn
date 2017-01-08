clc;
close all;
clear;

Nele = 0.25;
Tele = 0.75;
% f = [-1, zeros(1, 3), -1, -1];
f = -ones(1, 5);
% f = [1, zeros(1, 5)];
% f = zeros(1, 6);
x = trafficProfile(f, Nele, Tele, 0.1, 1, 1);
g = [50; 100; 200; 400; 1000];
throughput = x.*g/sum(x.*g);

% check
x = x/sum(x)
sum(x(4:5))/sum(x)
sum(throughput(4:5))/sum(throughput)
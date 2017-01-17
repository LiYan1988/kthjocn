function plotArea(X1, ymatrix1, figureStrings)
%CREATEFIGURE(X1, YMATRIX1)
%  X1:  area x
%  YMATRIX1:  area matrix data

%  Auto-generated by MATLAB on 08-Dec-2016 12:59:12

%% Create figure for connection histogram
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to area
area1 = area(X1,ymatrix1','Parent',axes1);
set(area1(1),'DisplayName','50 Gbps');
set(area1(2),'DisplayName','100 Gbps');
set(area1(3),'DisplayName','200 Gbps');
set(area1(4),'DisplayName','400 Gbps');
set(area1(5),'DisplayName','1000 Gbps');

axes1.YLim = [0, 1];
axes1.XLim = [min(X1), max(X1)];
% Create xlabel
xlabel('\beta');

% Create ylabel
ylabel('Percentage');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XMinorTick','on','XScale','log');
legend1 = legend(area1);
legend1.Location = 'southwest';
figureTitle = strcat('Rule:', figureStrings{1}, '-', figureStrings{2}, ...
    {' '}, figureStrings{3}, '-', figureStrings{4}, {' '}, 'connection');
title(figureTitle);
figureName = strcat('figures/', figureStrings{1}, '-', figureStrings{2}, ...
    '-', figureStrings{3}, '-', figureStrings{4}, ...
    '-', 'histo-cnk', '.jpg');
saveas(figure1, figureName)

%% Create figure for throughput histogram
figure2 = figure;

% Create axes
axes1 = axes('Parent',figure2);
hold(axes1,'on');

% Create multiple lines using matrix input to area
dataRates = [50; 100; 200; 400; 1000];
ymatrix2 = ymatrix1'.*dataRates'./(ymatrix1'*dataRates);
area1 = area(X1,ymatrix2,'Parent',axes1);
set(area1(1),'DisplayName','50 Gbps');
set(area1(2),'DisplayName','100 Gbps');
set(area1(3),'DisplayName','200 Gbps');
set(area1(4),'DisplayName','400 Gbps');
set(area1(5),'DisplayName','1000 Gbps');

axes1.YLim = [0, 1];
axes1.XLim = [min(X1), max(X1)];

% Create xlabel
xlabel('\beta');

% Create ylabel
ylabel('Percentage');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XMinorTick','on','XScale','log');
legend1 = legend(area1);
legend1.Location = 'southwest';
figureTitle = strcat('Rule:', figureStrings{1}, '-', figureStrings{2}, ...
    {' '}, figureStrings{3}, '-', figureStrings{4}, {' '}, 'throughput');
title(figureTitle);
figureName = strcat('figures/', figureStrings{1}, '-', figureStrings{2}, ...
    '-', figureStrings{3}, '-', figureStrings{4}, ...
    '-', 'histo-thp', '.jpg');
saveas(figure2, figureName)
